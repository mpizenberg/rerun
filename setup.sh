#!/usr/bin/env bash
set -eu
script_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$script_path"
set -x

# eframe dependencies needed on run on Linux and Fedora Rawhide:
if [ -x "$(command -v apt-get)" ]; then sudo apt-get install libgtk-3-dev libxcb-render0-dev libxcb-shape0-dev libxcb-xfixes0-dev libspeechd-dev libxkbcommon-dev libssl-dev
elif [ -x "$(command -v dnf)" ];   then sudo dnf install clang clang-devel clang-tools-extra speech-dispatcher-devel libxkbcommon-devel pkg-config openssl-devel libxcb-devel
fi

# Needed to compile and check the code:
rustup install 1.60.0
cargo install cargo-deny
./crates/re_viewer/setup_web.sh
./crates/re_viewer/build_web.sh
