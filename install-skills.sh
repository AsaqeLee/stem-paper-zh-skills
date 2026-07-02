#!/usr/bin/env bash
# Install stem-paper-zh-* skills and shared references to Grok, Claude Code, Codex.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
SRC="$ROOT/skills"
SHARED_DIR="shared"
SKILLS=(stem-paper-zh-write stem-paper-zh-polish)

usage() {
  cat <<'EOF'
Usage: ./install-skills.sh [--user | --project [DIR] | --both]

--user          Install to ~/.grok/skills, ~/.agents/skills, ~/.codex/skills
--project [DIR] Install to <repo>/.grok/skills, <repo>/.agents/skills, <repo>/.codex/skills
                (default repo: script directory)
--both          Install to both user and project scopes

Examples:
  ./install-skills.sh --user
  ./install-skills.sh --project /path/to/thesis-repo
  ./install-skills.sh --both
EOF
}

install_one() {
  local name="$1"
  local dest="$2"

  if [[ ! -d "$SRC/$name" ]]; then
    echo "Missing $SRC/$name" >&2
    exit 1
  fi

  mkdir -p "$dest"
  rm -rf "$dest/$name"
  cp -R "$SRC/$name" "$dest/"
  echo " -> $dest/$name"
}

install_shared() {
  local dest="$1"

  if [[ ! -d "$SRC/$SHARED_DIR" ]]; then
    echo "Missing $SRC/$SHARED_DIR" >&2
    exit 1
  fi

  mkdir -p "$dest"
  rm -rf "$dest/$SHARED_DIR"
  cp -R "$SRC/$SHARED_DIR" "$dest/"
  echo " -> $dest/$SHARED_DIR"
}

install_bundle() {
  local dest="$1"
  local name

  install_shared "$dest"
  for name in "${SKILLS[@]}"; do
    install_one "$name" "$dest"
  done
}

do_user() {
  echo "User scope:"
  install_bundle "$HOME/.grok/skills"
  install_bundle "$HOME/.agents/skills"
  install_bundle "$HOME/.codex/skills"
}

do_project() {
  local proj="${1:-$ROOT}"

  echo "Project scope ($proj):"
  install_bundle "$proj/.grok/skills"
  install_bundle "$proj/.agents/skills"
  install_bundle "$proj/.codex/skills"
}

MODE="${1:-}"
PROJECT_DIR="${2:-$ROOT}"

if [[ -z "$MODE" ]]; then
  cat <<'EOF'
Choose install mode:
  1) --user
  2) --project
  3) --both
EOF
  read -r -p "Enter 1/2/3 [1]: " choice
  case "${choice:-1}" in
    1) MODE="--user" ;;
    2) MODE="--project" ;;
    3) MODE="--both" ;;
    *) echo "Invalid choice" >&2; exit 1 ;;
  esac
fi

case "$MODE" in
  --user)
    do_user
    ;;
  --project)
    do_project "$PROJECT_DIR"
    ;;
  --both)
    do_user
    do_project "$PROJECT_DIR"
    ;;
  *)
    usage
    exit 1
    ;;
esac

echo "Done. Slash commands: /stem-paper-zh-write, /stem-paper-zh-polish"
echo "Modes: say 'natural' (default) or 'source-grounded' when invoking either skill."
