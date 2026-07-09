const LANGUAGE_LABELS = { en: "English", fr: "Français", la: "Latin", ar: "العربية", zh: "中文" };

let state = {
  cues: null,
  language: "en",
  listening: false,
  ws: null,
  audioCtx: null,
  micStream: null,
};

function toast(msg) {
  const el = document.getElementById("toast");
  el.textContent = msg;
  el.classList.add("show");
  clearTimeout(toast._t);
  toast._t = setTimeout(() => el.classList.remove("show"), 2200);
}

async function api(path, opts) {
  const res = await fetch(path, {
    headers: { "Content-Type": "application/json" },
    ...opts,
  });
  if (!res.ok) {
    const body = await res.text();
    throw new Error(`${res.status}: ${body}`);
  }
  return res.status === 204 ? null : res.json();
}

function groupBy(items) {
  const groups = {};
  for (const item of items) {
    (groups[item.group || "other"] ??= []).push(item);
  }
  return groups;
}

function cueButton(item, onFire, extraClass = "") {
  const btn = document.createElement("button");
  btn.className = `cue-btn ${extraClass}`;
  btn.title = item.description || "";
  const label = item.id.replace(/_/g, " ");
  let html = label;
  if (item.trigger) html += `<span class="trigger">"${item.trigger}"</span>`;
  btn.innerHTML = html;
  btn.addEventListener("click", async () => {
    btn.classList.add("flash");
    setTimeout(() => btn.classList.remove("flash"), 400);
    try {
      await onFire(item.id);
    } catch (err) {
      toast(`Error: ${err.message}`);
    }
  });
  return btn;
}

function renderGrid(containerId, items, onFire, extraClass = "") {
  const container = document.getElementById(containerId);
  container.innerHTML = "";
  const groups = groupBy(items);
  for (const [group, groupItems] of Object.entries(groups)) {
    const heading = document.createElement("div");
    heading.className = "group-heading";
    heading.textContent = group.replace(/_/g, " ");
    container.appendChild(heading);
    const row = document.createElement("div");
    row.className = "grid";
    for (const item of groupItems) row.appendChild(cueButton(item, onFire, extraClass));
    container.appendChild(row);
  }
}

async function fireCue(id) {
  const result = await api(`/api/fire/${encodeURIComponent(id)}`, { method: "POST" });
  refreshState();
  return result;
}

async function refreshState() {
  const s = await api("/api/state");
  document.getElementById("scene-status").textContent = s.active_scene
    ? `Scene: ${s.active_scene.replace(/_/g, " ")}`
    : "no scene active";
}

async function loadCatalog() {
  const data = await api("/api/cues");
  state.cues = data;
  state.language = data.language;

  const select = document.getElementById("language-select");
  select.innerHTML = "";
  for (const lang of data.supported_languages) {
    const opt = document.createElement("option");
    opt.value = lang;
    opt.textContent = LANGUAGE_LABELS[lang] || lang;
    if (lang === data.language) opt.selected = true;
    select.appendChild(opt);
  }

  renderGrid("scenes-grid", data.scenes, fireCue, "scene-btn");
  renderGrid("spells-grid", data.spells, fireCue);
  renderGrid("effects-grid", data.effects, fireCue);
}

async function loadCustomButtons() {
  const buttons = await api("/api/custom-buttons");
  const items = Object.values(buttons).map((b) => ({ ...b, group: "your buttons", description: b.playlist_uri || "" }));
  renderGrid("custom-grid", items, (id) => api(`/api/custom-buttons/${encodeURIComponent(id)}/fire`, { method: "POST" }));
}

function setupTabs() {
  document.querySelectorAll(".tab-btn").forEach((btn) => {
    btn.addEventListener("click", () => {
      document.querySelectorAll(".tab-btn").forEach((b) => b.classList.remove("active"));
      document.querySelectorAll(".tab-panel").forEach((p) => p.classList.remove("active"));
      btn.classList.add("active");
      document.getElementById(`tab-${btn.dataset.tab}`).classList.add("active");
    });
  });
}

function setupLanguageSelect() {
  document.getElementById("language-select").addEventListener("change", async (e) => {
    await api("/api/language", { method: "POST", body: JSON.stringify({ language: e.target.value }) });
    await loadCatalog();
    toast(`Voice trigger language set to ${LANGUAGE_LABELS[e.target.value] || e.target.value}`);
  });
}

function setupCustomForm() {
  document.getElementById("custom-form").addEventListener("submit", async (e) => {
    e.preventDefault();
    const body = {
      id: document.getElementById("cb-id").value.trim(),
      label: document.getElementById("cb-label").value.trim(),
      color: document.getElementById("cb-color").value,
      brightness: parseFloat(document.getElementById("cb-brightness").value),
      playlist_uri: document.getElementById("cb-playlist").value.trim() || null,
    };
    try {
      await api("/api/custom-buttons", { method: "POST", body: JSON.stringify(body) });
      e.target.reset();
      await loadCustomButtons();
      toast("Custom button saved");
    } catch (err) {
      toast(`Error: ${err.message}`);
    }
  });
}

async function loadSettings() {
  const s = await api("/api/settings");
  document.getElementById("s-sounds-dir").value = s.sounds_dir || "";
  document.getElementById("s-vosk-dir").value = s.vosk_model_dir || "";
  document.getElementById("settings-status").textContent =
    `LIFX: ${s.lifx_configured ? "configured" : "not configured"} · ` +
    `Spotify: ${s.spotify_configured ? "configured" : "not configured"}`;
}

function setupSettingsForm() {
  document.getElementById("settings-form").addEventListener("submit", async (e) => {
    e.preventDefault();
    const body = {
      sounds_dir: document.getElementById("s-sounds-dir").value.trim(),
      vosk_model_dir: document.getElementById("s-vosk-dir").value.trim(),
    };
    const lifx = document.getElementById("s-lifx").value;
    const spotifyId = document.getElementById("s-spotify-id").value;
    const spotifySecret = document.getElementById("s-spotify-secret").value;
    if (lifx) body.lifx_token = lifx;
    if (spotifyId) body.spotify_client_id = spotifyId;
    if (spotifySecret) body.spotify_client_secret = spotifySecret;
    try {
      await api("/api/settings", { method: "POST", body: JSON.stringify(body) });
      toast("Settings saved");
      await loadSettings();
    } catch (err) {
      toast(`Error: ${err.message}`);
    }
  });
}

// -- Voice listening: capture mic audio, downsample to 16kHz mono PCM16,
// stream over the /ws/voice WebSocket. --------------------------------

function floatTo16BitPCM(input) {
  const output = new Int16Array(input.length);
  for (let i = 0; i < input.length; i++) {
    const s = Math.max(-1, Math.min(1, input[i]));
    output[i] = s < 0 ? s * 0x8000 : s * 0x7fff;
  }
  return output;
}

function downsampleBuffer(buffer, inRate, outRate) {
  if (outRate === inRate) return buffer;
  const ratio = inRate / outRate;
  const newLength = Math.round(buffer.length / ratio);
  const result = new Float32Array(newLength);
  for (let i = 0; i < newLength; i++) {
    result[i] = buffer[Math.floor(i * ratio)];
  }
  return result;
}

async function startListening() {
  try {
    state.micStream = await navigator.mediaDevices.getUserMedia({ audio: true });
  } catch (err) {
    toast(`Microphone access denied: ${err.message}`);
    return;
  }

  const proto = location.protocol === "https:" ? "wss:" : "ws:";
  state.ws = new WebSocket(`${proto}//${location.host}/ws/voice`);
  state.ws.binaryType = "arraybuffer";

  state.ws.onmessage = (ev) => {
    const msg = JSON.parse(ev.data);
    if (msg.error) {
      toast(`Voice: ${msg.error}`);
      stopListening();
      return;
    }
    if (msg.matched) {
      toast(`Voice matched: ${msg.matched.replace(/_/g, " ")}`);
      refreshState();
    }
  };
  state.ws.onerror = () => toast("Voice connection error");

  state.audioCtx = new (window.AudioContext || window.webkitAudioContext)();
  const source = state.audioCtx.createMediaStreamSource(state.micStream);
  const processor = state.audioCtx.createScriptProcessor(4096, 1, 1);
  source.connect(processor);
  processor.connect(state.audioCtx.destination);
  processor.onaudioprocess = (e) => {
    if (state.ws?.readyState !== WebSocket.OPEN) return;
    const input = e.inputBuffer.getChannelData(0);
    const down = downsampleBuffer(input, state.audioCtx.sampleRate, 16000);
    state.ws.send(floatTo16BitPCM(down).buffer);
  };
  state._processor = processor;

  state.listening = true;
  const btn = document.getElementById("listen-toggle");
  btn.textContent = "Listen: on";
  btn.classList.add("on");
}

function stopListening() {
  state._processor?.disconnect();
  state.audioCtx?.close();
  state.micStream?.getTracks().forEach((t) => t.stop());
  state.ws?.close();
  state.listening = false;
  const btn = document.getElementById("listen-toggle");
  btn.textContent = "Listen: off";
  btn.classList.remove("on");
}

function setupListenToggle() {
  document.getElementById("listen-toggle").addEventListener("click", () => {
    if (state.listening) stopListening();
    else startListening();
  });
}

async function init() {
  setupTabs();
  setupLanguageSelect();
  setupCustomForm();
  setupSettingsForm();
  setupListenToggle();
  await loadCatalog();
  await loadCustomButtons();
  await loadSettings();
  await refreshState();
}

init();
