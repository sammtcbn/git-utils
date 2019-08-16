#!/bin/bash
mkdir -p ~/bin/ || exit 1
cp -f script_linux/* ~/bin/ || exit 1
echo "setup ok"
