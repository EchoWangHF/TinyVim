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
#set autoload
cp -r autoload ~/.vim/


#set syntax
#if [[ -d ~/.vim ]]
#then
#  echo "~/.vim/ is exist"
#  if [[ -d ~/.vim/syntax ]]
#  then
#    echo "~/.vim/syntax/ is exist"
#    cp syntax/* ~/.vim/syntax/
#  else
#    echo "~/.vim/syntax/ is not exist"
#    cp -r syntax ~/.vim/
#  fi
#else
#  echo " ~/.vim is not exist"
#  mkdir ~/.vim
#  cp -r syntax ~/.vim/
#fi
#
#if [[ -d ~/.vim ]]
#then
#  echo "~/.vim/ is exist"
#  if [[ -d ~/.vim/after ]]
#  then
#    echo "~/.vim/after/ is exist"
#    rm -rf ~/.vim/after/
#    cp -r after ~/.vim/
#  else
#    echo "~/.vim/after/ is not exist"
#    cp -r after ~/.vim/
#  fi
#else
#  echo " ~/.vim is not exist"
#  mkdir ~/.vim
#  cp -r after ~/.vim/
#fi
#
##set colors scheme
#if [[ -d ~/.vim ]]
#then
#  echo "~/.vim/ is exist"
#  if [[ -d ~/.vim/colors ]]
#  then
#    echo "~/.vim/colors/ is exist"
#    cp colors/* ~/.vim/colors/
#  else
#    echo "~/.vim/colors/ is not exist"
#    cp -r colors ~/.vim/
#  fi
#else
#  echo " ~/.vim is not exist"
#  mkdir ~/.vim
#  cp -r colors ~/.vim/
#fi
#
##set autoload
#if [[ -d ~/.vim ]]
#then
#  echo "~/.vim/ is exist"
#  if [[ -d ~/.vim/autoload ]]
#  then
#    echo "~/.vim/autoload/ is exist"
#    rm -rf ~/.vim/autoload/
#    cp -r autoload ~/.vim/
#  else
#    echo "~/.vim/colors/ is not exist"
#    cp -r autoload ~/.vim/
#  fi
#else
#  echo " ~/.vim is not exist"
#  mkdir ~/.vim
#  cp -r autoload ~/.vim/
#fi

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
bash install_awesome_vimrc.sh

