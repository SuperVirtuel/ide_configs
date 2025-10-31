#!/bin/bash
# try to remove ./nvim
trap 'echo "./nvim doesnt exists."' ERR
rm -rf ./nvim

cp -r ~/.config/nvim/ ./
