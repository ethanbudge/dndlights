from dndlights.lifx import LifxClient
from tests.conftest import FakeHTTPResponse, FakeSession


def test_unconfigured_client_is_a_noop():
    slept = []
    client = LifxClient(token="", sleep_fn=slept.append)
    result = client.set_color("#ff0000", 0.5, 1.0)
    assert result is None
    assert slept == [1.0]
    assert client._warned is True


def test_configured_client_sends_request_and_sleeps():
    slept = []
    session = FakeSession(responses=[FakeHTTPResponse(200, {"results": []})])
    client = LifxClient(token="tok123", session=session, sleep_fn=slept.append)
    result = client.set_color("#00ff00", 0.8, 0.5)
    assert result == {"results": []}
    assert slept == [0.5]
    call = session.calls[0]
    assert call["method"] == "PUT"
    assert call["headers"]["Authorization"] == "Bearer tok123"
    assert call["json"] == {"color": "#00ff00", "brightness": 0.8, "duration": 0.5, "fast": True}


def test_error_response_returns_none_without_raising():
    session = FakeSession(responses=[FakeHTTPResponse(401, {}, text="unauthorized")])
    client = LifxClient(token="bad-token", session=session, sleep_fn=lambda _: None)
    assert client.set_color("#ffffff", 1.0, 0.1) is None


def test_wait_false_skips_sleep():
    slept = []
    session = FakeSession()
    client = LifxClient(token="tok", session=session, sleep_fn=slept.append)
    client.set_color("#ffffff", 1.0, 2.0, wait=False)
    assert slept == []
