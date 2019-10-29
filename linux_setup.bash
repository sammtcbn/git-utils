#!/bin/bash
mkdir -p ~/bin/ || exit 1
cp -f script_linux/* ~/bin/ || exit 1

git config --global color.diff auto
git config --global color.status auto
git config --global color.branch auto
git config --global color.log auto

echo "setup ok"
