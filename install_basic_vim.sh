set -e
if [[ -d ~/.vim ]]
then
  echo "~/.vim/ is exist, and ~/.vim will be delete!"
  rm -rf ~/.vim
  mkdir ~/.vim
else
  mkdir ~/.vim
fi
#set syntax
cp -r syntax ~/.vim/
#set after cp syntax
cp -r after ~/.vim/
#set colors scheme
cp -r colors ~/.vim/

# set vimrc vim_runtime
if [[ -d ~/.vim_runtime ]]
then
  echo "~/.vim_runtime is exist and ~/.vim_runtime will be delete"
  rm -rf ~/.vim_runtime
  cp -r .vim_runtime ~/
else
  cp -r .vim_runtime ~/
fi

cd ~/.vim_runtime
bash install_basic_vimrc.sh

