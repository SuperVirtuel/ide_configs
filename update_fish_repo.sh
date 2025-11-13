#!/bin/bash
# Copy fish config from ~/.config/fish to this repo

trap 'echo "./fish doesnt exist."' ERR
rm -rf ./fish

cp -r ~/.config/fish/ ./

echo "Fish configuration has been updated from ~/.config/fish/ to ./fish"
