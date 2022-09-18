#set syntax
if [[ -d ~/.vim ]]
then
  echo "~/.vim/ is exist"
  if [[ -d ~/.vim/syntax ]]
  then
    echo "~/.vim/syntax/ is exist"
    cp syntax/* ~/.vim/syntax/
  else
    echo "~/.vim/syntax/ is not exist"
    cp -r syntax ~/.vim/
  fi
else
  echo " ~/.vim is not exist"
  mkdir ~/.vim
  cp -r syntax ~/.vim/
fi

#set colors scheme
if [[ -d ~/.vim ]]
then
  echo "~/.vim/ is exist"
  if [[ -d ~/.vim/colors ]]
  then
    echo "~/.vim/colors/ is exist"
    cp colors/* ~/.vim/colors/
  else
    echo "~/.vim/colors/ is not exist"
    cp -r colors ~/.vim/
  fi
else
  echo " ~/.vim is not exist"
  mkdir ~/.vim
  cp -r colors ~/.vim/
fi

# set vimrc vim_runtime
if [[ -d ~/.vim_runtime ]]
then
  echo "~/.vim_runtime is exist"
  rm -rf ~/.vim_runtime
  cp -r .vim_runtime ~/
else
  cp -r .vim_runtime ~/
fi

cd ~/.vim_runtime
bash install_awesome_vimrc.sh


