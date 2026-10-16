# TinyVim
A simple but useful vim set for your vimrc.

## How to use
### 1 安装
如果只想用简单的vim设置，可以运行下面的脚本。basic 基本上可以满足正常的开发使用，并且比较简洁。脚本会安装与插件版相同的 Solarized 配色及 C/C++、Python、MLIR 语法高亮，但不会安装 vim-plug 或任何插件，也不会启用插件配置。
```
bash install_basic_vim.sh
```

如果你想基于插件，使用更加丰富的vim功能，可以运行下面的脚本。它会安装相同的配色与语法文件，自动下载已配置的插件；系统中没有 `clangd` 时，还会自动安装 C/C++ 语言服务器。
```
bash install_with_plug.sh
```

### 2 个性化设置
#### 2.1 主题配色
主题配色可以通过插件安装(下面会介绍), 也可以直接将vim配色文件放进`colors`文件夹当中，然后在`.vim_runtime/my_configs.vim` 当中设置一下，比如:
```
set background=dark
colorscheme gruvbox
```
目前`TinyVim`自带的配色有:`gruvbox`,`molokai`, `peaksea`,`solarized`, `space-vim-dark`; 默认配色是`solarized`。

#### 2.2 高亮设置
大部分开发语言，都已经支持高亮操作了，如果有特殊的文本格式需要高亮支持，可以将vim高亮设置文本放在`syntax`文件夹下，然后在`.vim_runtime/my_configs.vim` 当中设置一下，比如：
```
au! BufRead,BufNewFile *.ll     set filetype=llvm
```

#### 2.3 左侧栏与诊断标记

默认不显示左侧折叠栏和诊断标记列。插件版中的 clangd 仍会检查 C/C++ 代码；`E>` 表示错误，`W>` 表示警告，可在 Vim 中运行 `:LspDocumentDiagnostics` 查看具体诊断。

如需重新显示左侧标记，在 `.vim_runtime/my_configs.vim`（安装后位于 `~/.vim_runtime/my_configs.vim`）中添加以下设置并重开 Vim。若修改的是仓库文件，需先重新运行安装脚本：

```vim
set foldcolumn=1
set signcolumn=auto
let g:lsp_diagnostics_signs_enabled = 1
```

### 3 插件安装
`TinyVim` 使用 [vim-plug](https://github.com/junegunn/vim-plug) 管理插件。运行 `bash install_with_plug.sh` 会自动下载并安装当前配置中已启用的插件，无需再手动运行 `:PlugInstall`。如需添加插件，在 `.vim_runtime/plugins_config.vim` 中按 vim-plug 格式声明，然后重新运行安装脚本；也可以在 Vim 中运行 `:PlugInstall`。例如：
```
Plug 'vim-airline/vim-airline'
```
`vim-plug`常用命令为：

| Command                             | Description                                                        |
| ----------------------------------- | ------------------------------------------------------------------ |
| `PlugInstall [name ...] [#threads]` | Install plugins                                                    |
| `PlugUpdate [name ...] [#threads]`  | Install or update plugins                                          |
| `PlugClean[!]`                      | Remove unlisted plugins (bang version will clean without prompt) |
| `PlugUpgrade`                       | Upgrade vim-plug itself                                            |
| `PlugStatus`                        | Check the status of plugins                                        |
| `PlugDiff`                          | Examine changes from the previous update and the pending changes   |
| `PlugSnapshot[!] [output path]`     | Generate script for restoring the current snapshot of the plugins  |

如果插件需要额外的配置，为了统一管理，请放在`.vim_runtime/extended.vim`当中。

#### 3.1 [LeaderfFile](https://github.com/Yggdroot/LeaderF) 
```
:LeaderfFile <file>
```

#### 3.2 [vim-better-whitespace](https://github.com/ntpeters/vim-better-whitespace) 
```
::StripWhitespace
```

#### 3.3 C/C++ LSP 自动补全

运行 `bash install_with_plug.sh` 后，插件版使用 `vim-lsp`、`vim-lsp-settings`、`asyncomplete.vim` 和 `asyncomplete-lsp.vim` 连接 `clangd`。安装脚本优先复用系统中的 `clangd`；如果只有 `clangd-版本号`，会在 `~/.vim/lsp-servers/clangd/clangd` 创建链接；否则自动下载并安装到该目录。重新运行脚本会复用已安装的服务器。

进入项目并打开 `.c`、`.h`、`.cpp`、`.hpp` 等文件即可使用，例如 `vim src/main.cpp`；本配置还将 `.mlu` 文件识别为 C++。首次打开后，等待 clangd 完成启动与索引，在 Vim 中输入 `:LspStatus` 可以查看状态。当前配置仅为 C/C++ 启用 clangd；`.mlir` 文件仍提供语法高亮。

左侧诊断标记的默认设置及开启方式见 2.3 节。

| 操作 | 用法 |
| --- | --- |
| 自动补全 | 在插入模式输入代码时等待候选菜单出现；`Ctrl-n` / `Ctrl-p` 选择，`Ctrl-y` 确认 |
| 手动补全 | 在插入模式按 `Ctrl-x`、`Ctrl-o`，调用 LSP 全能补全 |
| 跳转定义 | 普通模式将光标放在符号上，按 `gd` |
| 查找引用 | 普通模式将光标放在符号上，按 `gr` |
| 查看说明 | 普通模式将光标放在符号上，按 `K` |

为让 clangd 正确找到头文件、宏和编译选项，建议为项目提供 `compile_commands.json`。CMake 项目可以在项目根目录运行：

```bash
cmake -S . -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
```

clangd 会查找源码上级目录以及其中的 `build/` 目录。如果构建目录位于其他位置，请将 `compile_commands.json` 链接到项目根目录；Bazel 等项目也需要用相应工具生成编译数据库。详见 [clangd 项目配置说明](https://clangd.llvm.org/installation#project-setup)。

如果没有补全，先在 Vim 中运行 `:set filetype?`（确认是 `c` 或 `cpp`）、`:LspStatus`（检查 clangd 是否运行）、`:PlugStatus`（检查插件）。再在终端检查 clangd：系统安装时运行 `clangd --version`，由本脚本安装时运行 `~/.vim/lsp-servers/clangd/clangd --version`。若只有头文件或宏的诊断不准确，优先检查 `compile_commands.json` 的位置及其编译参数。
