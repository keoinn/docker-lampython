#!/usr/bin/env python3
"""Demo：在 container venv 中執行此腳本。

本機執行：
    ./scripts/py /var/www/scripts/hello.py
"""

import sys


def main() -> None:
    print("LAMPython venv demo")
    print(f"Python:  {sys.version.split()[0]}")
    print(f"Executable: {sys.executable}")

    try:
        import django

        print(f"Django:  {django.get_version()}")
    except ImportError:
        print("Django:  (not installed)")


if __name__ == "__main__":
    main()
