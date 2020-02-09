#!/usr/bin/env bash
cd $HOME/SAKURRA
rm -rf $HOME/.telegram-cli
ins() {
sudo chmod +x tg
chmod +x SAKURRA
chmod +x sa
./sa
}
if [ "$1" = "ins" ]; then
ins
fi
chmod +x ins.sh
lua run.lua
