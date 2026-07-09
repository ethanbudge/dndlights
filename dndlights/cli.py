"""Entrypoint: `python -m dndlights.cli` or the `dndlights` console script."""

from __future__ import annotations

import argparse

import uvicorn

from .web.app import create_app


def main() -> None:
    parser = argparse.ArgumentParser(description="Run the dndlights control panel web app.")
    parser.add_argument("--host", default="0.0.0.0",
                         help="Bind address (0.0.0.0 so other devices on the LAN can reach it)")
    parser.add_argument("--port", type=int, default=8420)
    args = parser.parse_args()

    app = create_app()
    print(f"dndlights running -- open http://<this-computer's-LAN-IP>:{args.port}/ "
          f"from any phone or computer on the same network.")
    uvicorn.run(app, host=args.host, port=args.port)


if __name__ == "__main__":
    main()
