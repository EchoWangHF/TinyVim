#!/usr/bin/env bash
set -euo pipefail

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
bash "$script_dir/.vim_runtime/install_others.sh"
bash "$script_dir/.vim_runtime/install_basic_vimrc.sh"

