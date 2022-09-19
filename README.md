# TinyVim
A simple but useful vim set for your vimrc.

## How to use
### 1 安装
如果只想用简单的vim设置，可以运行下面的脚本。basic 基本上可以满足正常的开发使用，并且比较简洁。
```
bash install_basic_vim.sh
```

如果你想基于插件，使用更加丰富的vim功能，可以运行下面的脚本。
```
bash install_with_plug.sh
```

### 2 个性化设置
#### 2.1 主题配色
主题配色可以通过插件安装(下面会介绍), 也可以直接将vim配色文件放进`color`文件夹当中，然后在`.vim_runtime/my_configs.vim` 当中设置一下，比如:
```
set background=dark
colorscheme gruvbox
```
目前`TinyVim`自带的配色有:`gruvbox`,`molokai`, `peaksea`,`soloarized`, `space-vim-dark`; 默认配色是`gruvbox`。

#### 2.2 高亮设置
大部分开发语言，都已经支持高亮操作了，如果有特殊的文本格式需要高亮支持，可以将vim高亮设置文本放在`syntax`文件夹下，然后在`.vim_runtime/my_configs.vim` 当中设置一下，比如：
```
au! BufRead,BufNewFile *.ll     set filetype=llvm
```

### 3 插件安装
`TinyVim` 使用的是[vim-plug](https://github.com/junegunn/vim-plug)插件，需要添加什么插件，只需要在`.vim_runtime/plugins_config.vim`当中按照`vim-plug`插件格式添加对应的插件就可以了，然后在vim当中运行`PlugInstall`命令。比如：
```
Plug 'vim-airline/vim-airline
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
