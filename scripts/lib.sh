#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

CONTAINER="${LAMPYTHON_CONTAINER:-lampython_app}"
VENV_DIR="${LAMPYTHON_VENV:-/opt/django_env}"
VENV_PYTHON="${VENV_DIR}/bin/python"
VENV_PIP="${VENV_DIR}/bin/pip"

if [[ -f "$ROOT_DIR/.env" ]]; then
  set -a
  # shellcheck disable=SC1091
  source "$ROOT_DIR/.env"
  set +a
fi

WORKDIR="${LAMPYTHON_WORKDIR:-/var/www/${DJANGO_PROJECT_NAME:-DjangoBlog}}"

ensure_container() {
  if ! docker ps --format '{{.Names}}' | grep -qx "$CONTAINER"; then
    echo "Error: container '$CONTAINER' is not running." >&2
    echo "Start it with: docker compose up -d" >&2
    exit 1
  fi
}
