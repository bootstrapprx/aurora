#!/usr/bin/env bash
set -euo pipefail

PY="${PY:-python3}"
VENV="$HOME/.venv_rea"

echo "===> 1. Dependências de sistema..."
# Check package manager
if command -v apt-get >/dev/null; then
    sudo apt-get update
    sudo apt-get install -y squashfs-tools p7zip-full python3-venv python3-dev gcc g++ make cmake libffi-dev libssl-dev
else
    echo "Unsupported package manager. Install squashfs-tools, p7zip, python3-dev, gcc, g++, make, cmake manually."
fi

echo "===> 2. Venv..."
"$PY" -m venv "$VENV"

echo "===> 3. Bibliotecas Python..."
"$VENV/bin/pip" install --upgrade pip setuptools wheel
"$VENV/bin/pip" install pwntools==4.15.0 pyelftools==0.33 unicorn==2.1.2

echo "===> 4. Validando imports..."
"$VENV/bin/python" -c "import pwn, elftools, unicorn; print('ok')"

echo "Pronto. Execute em seguida: export REA_PWNTOOLS_PYTHON=\"$VENV/bin/python\""
