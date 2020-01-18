#!/usr/bin/env bash
cd $HOME/TeKToK
rm -rf $HOME/.telegram-cli
ins() {
sudo chmod +x tg
chmod +x TeKToK
chmod +x tk
./tk
}
if [ "$1" = "ins" ]; then
ins
fi
chmod +x ins.sh
lua run.lua
