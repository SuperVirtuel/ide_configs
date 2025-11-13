#!/bin/bash
# Copy wezterm config from ~/.config/wezterm to this repo

trap 'echo "./wezterm doesnt exist."' ERR
rm -rf ./wezterm

cp -r ~/.config/wezterm/ ./

echo "Wezterm configuration has been updated from ~/.config/wezterm/ to ./wezterm"
