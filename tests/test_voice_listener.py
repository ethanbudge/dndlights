import json

from dndlights.voice.listener import VoiceListener


class FakeRecognizer:
    """Duck-types vosk.KaldiRecognizer without needing vosk or a model."""

    def __init__(self, final_texts):
        self._final_texts = list(final_texts)
        self._last_result = ""

    def AcceptWaveform(self, data):  # noqa: N802
        if self._final_texts:
            self._last_result = self._final_texts.pop(0)
            return True
        return False

    def Result(self):  # noqa: N802
        return json.dumps({"text": self._last_result})

    def PartialResult(self):  # noqa: N802
        return json.dumps({"partial": ""})


def test_feed_fires_callback_on_matching_utterance():
    matches = []
    recognizer = FakeRecognizer(["someone yells fireball"])
    listener = VoiceListener(recognizer, "en", matches.append)
    result = listener.feed(b"\x00\x01")
    assert result is not None
    assert result.cue_id == "fireball"
    assert matches == [result]


def test_feed_returns_none_when_not_final():
    matches = []
    recognizer = FakeRecognizer([])  # AcceptWaveform always returns False
    listener = VoiceListener(recognizer, "en", matches.append)
    assert listener.feed(b"\x00\x01") is None
    assert matches == []


def test_feed_returns_none_when_final_but_no_match():
    matches = []
    recognizer = FakeRecognizer(["just some table chatter"])
    listener = VoiceListener(recognizer, "en", matches.append)
    assert listener.feed(b"\x00\x01") is None
    assert matches == []
