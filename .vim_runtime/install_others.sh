#!/usr/bin/env bash
set -euo pipefail

repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
mkdir -p "$HOME/.vim" "$HOME/.vim_runtime"

cp -R "$repo_dir"/{syntax,after,colors} "$HOME/.vim/"
if [[ ${1:-} == --with-plug ]]; then
  cp -R "$repo_dir/autoload" "$HOME/.vim/"
fi
cp -R "$repo_dir/.vim_runtime/." "$HOME/.vim_runtime/"

