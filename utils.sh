#!/bin/bash

print_title() {
    printf "\n$1\n"
    printf "%-${#1}s\n" | tr ' ' '='
}

install_apt() {
    echo "Installing \`$1\`..."
    sudo apt-get install "$1" -y 1>/dev/null
}

install_rust_github_release() {
    echo "Installing \`$1\`..."
    reg=$(echo "${2}/releases/tag/v\{0,1\}[0-9]*.[0-9]*.[0-9]*")
    latest_version=$(curl -s -L "$2"/releases/latest | grep -o "${reg}" | head -n 1 | awk -F/ '{print $NF}')

    filename=nu-$latest_version-x86_64-unknown-linux-gnu
    wget -q $2/releases/download/$latest_version/$filename.tar.gz

    tar -xzf $filename.tar.gz
    sudo cp $filename/nu /usr/local/bin
    rm -rf $filename*
}

install_font() {
    wget -q $1
    unzip $2.zip -d $2 1>/dev/null
    cp -r $2 ~/.local/share/fonts
    rm -rf $2*
    fc-cache -fv 1>/dev/null
}
