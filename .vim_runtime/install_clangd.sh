#!/usr/bin/env bash
set -euo pipefail

tinyvim_server_dir="$HOME/.vim/lsp-servers/clangd"
if command -v clangd >/dev/null 2>&1 || [[ -x "$tinyvim_server_dir/clangd" ]]; then
  exit 0
fi

for tinyvim_major in {30..9}; do
  if command -v "clangd-$tinyvim_major" >/dev/null 2>&1; then
    tinyvim_versioned_clangd=$(command -v "clangd-$tinyvim_major")
    if "$tinyvim_versioned_clangd" --version >/dev/null 2>&1; then
      mkdir -p "$tinyvim_server_dir"
      ln -sfn "$tinyvim_versioned_clangd" "$tinyvim_server_dir/clangd"
      echo "Using $tinyvim_versioned_clangd"
      exit 0
    fi
  fi
done

# clangd publishes a smaller standalone archive for Linux x64 and macOS.
# Other platforms use the installer supplied by vim-lsp-settings.
tinyvim_clangd_version=23.1.0
case "$(uname -s):$(uname -m)" in
  Linux:x86_64) tinyvim_platform=linux ;;
  Darwin:x86_64|Darwin:arm64) tinyvim_platform=mac ;;
  *) tinyvim_platform= ;;
esac

if [[ -n "$tinyvim_platform" ]] && command -v curl >/dev/null 2>&1 && command -v unzip >/dev/null 2>&1; then
  mkdir -p "$HOME/.vim/lsp-servers"
  tinyvim_stage_dir=$(mktemp -d "$HOME/.vim/lsp-servers/.clangd.XXXXXX")
  trap 'rm -rf "$tinyvim_stage_dir"' EXIT
  tinyvim_archive="clangd-$tinyvim_platform-$tinyvim_clangd_version.zip"
  tinyvim_url="https://github.com/clangd/clangd/releases/download/$tinyvim_clangd_version/$tinyvim_archive"
  echo "Downloading $tinyvim_archive ..."
  curl -fL --retry 2 --progress-bar -o "$tinyvim_stage_dir/clangd.zip" "$tinyvim_url"
  unzip -q "$tinyvim_stage_dir/clangd.zip" -d "$tinyvim_stage_dir"
  tinyvim_extracted_dir="$tinyvim_stage_dir/clangd_$tinyvim_clangd_version"
  test -f "$tinyvim_extracted_dir/bin/clangd"
  chmod +x "$tinyvim_extracted_dir/bin/clangd"
  "$tinyvim_extracted_dir/bin/clangd" --version >/dev/null
  rm -rf "$tinyvim_server_dir"
  mv "$tinyvim_extracted_dir" "$tinyvim_server_dir"
  ln -s bin/clangd "$tinyvim_server_dir/clangd"
else
  mkdir -p "$tinyvim_server_dir"
  (
    cd "$tinyvim_server_dir"
    sh "$HOME/.vim/plugged/vim-lsp-settings/installer/install-clangd.sh"
  )
fi

if [[ ! -x "$tinyvim_server_dir/clangd" ]]; then
  echo 'Failed to install clangd.' >&2
  exit 1
fi
"$tinyvim_server_dir/clangd" --version
