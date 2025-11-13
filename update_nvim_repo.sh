#!/bin/bash
# Copy nvim config from ~/.config/nvim to this repo

trap 'echo "./nvim doesnt exist."' ERR
rm -rf ./nvim

cp -r ~/.config/nvim/ ./

echo "Neovim configuration has been updated from ~/.config/nvim/ to ./nvim"

