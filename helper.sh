#!/bin/bash

silent_install() {
    echo "Installing \`$1\`..."
    sudo apt-get install "$1" -y 1>/dev/null
}

show_configure_message() {
    echo "Configuring \`$1\`..."
}
