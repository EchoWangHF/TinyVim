#!/usr/bin/env bash
set -euo pipefail

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
bash "$script_dir/.vim_runtime/install_others.sh" --with-plug
bash "$script_dir/.vim_runtime/install_awesome_vimrc.sh"

if ! command -v git >/dev/null 2>&1; then
  echo 'git is required to install Vim plugins.' >&2
  exit 1
fi

tinyvim_install_dir=$(mktemp -d)
trap 'rm -rf "$tinyvim_install_dir"' EXIT
cat > "$tinyvim_install_dir/list.vim" <<'EOF'
let plugins = []
for [name, spec] in items(g:plugs)
  if has_key(spec, 'uri')
    call add(plugins, join([name, spec.uri, spec.dir], "\t"))
  endif
endfor
call writefile(plugins, expand('$TINYVIM_PLUGIN_MANIFEST'))
qa!
EOF

export TINYVIM_PLUGIN_MANIFEST="$tinyvim_install_dir/plugins"
if ! vim -n -es -u "$HOME/.vimrc" -S "$tinyvim_install_dir/list.vim" || [[ ! -s "$TINYVIM_PLUGIN_MANIFEST" ]]; then
  echo 'Could not read the configured Vim plugins.' >&2
  exit 1
fi

while IFS=$'\t' read -r plugin_name plugin_url plugin_dir; do
  if [[ -f "$plugin_dir/.git/HEAD" ]] && git -C "$plugin_dir" rev-parse --verify HEAD >/dev/null 2>&1; then
    continue
  fi
  if [[ -d "$plugin_dir" ]]; then
    rmdir "$plugin_dir" 2>/dev/null || true
  fi
  if [[ -e "$plugin_dir" ]]; then
    echo "Plugin directory is incomplete: $plugin_dir" >&2
    exit 1
  fi
  mkdir -p "$(dirname "$plugin_dir")"
  plugin_url=${plugin_url/https:\/\/git::@github.com/https:\/\/github.com}
  echo "Installing $plugin_name ..."
  if ! git clone --depth 1 "$plugin_url" "$plugin_dir" || ! git -C "$plugin_dir" rev-parse --verify HEAD >/dev/null 2>&1; then
    echo "Failed to install $plugin_name; check the network connection and rerun the script." >&2
    exit 1
  fi
done < "$TINYVIM_PLUGIN_MANIFEST"

bash "$script_dir/.vim_runtime/install_clangd.sh"
echo 'Installed TinyVim and its configured plugins.'

