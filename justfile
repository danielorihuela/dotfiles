# Install tools required to reproduce a Nix configuration (graphics are optional and only needed for GUI apps like ghostty)
install-tools:
    #!/usr/bin/env bash
    if [ "{{ os() }}" == "linux" ]; then
        just _install-home-manager
        just _install-graphics
    elif [ "{{ os() }}" == "darwin" ]; then
        just _install-nix-darwin
    else 
        echo "Unsupported OS"
    fi

# Build configuration
build-config config:
    #!/usr/bin/env bash
    if [ "{{ os() }}" == "linux" ]; then
        home-manager switch --flake .#{{ config }}
    elif [ "{{ os() }}" == "darwin" ]; then
        darwin-rebuild switch --flake .#{{ config }}
    else 
        echo "Unsupported OS"
    fi

# Build virtual machine
build-vm vm:
    nix run .#{{ vm }}

# Delete ALL old generations
delete-old-generations:
    nix-collect-garbage -d

# Uninstall all the tools, including Nix
uninstall:
    #!/usr/bin/env bash
    if [ "{{ os() }}" == "darwin" ]; then
        nix --extra-experimental-features "nix-command flakes" run nix-darwin#darwin-uninstaller
    fi
    /nix/nix-installer uninstall

_install-home-manager:
    nix run home-manager/master -- init --switch

_install-nix-darwin:
    nix run nix-darwin/master#darwin-rebuild -- switch

_install-graphics:
    sudo --preserve-env=PATH env nix run 'github:numtide/system-manager' -- switch --flake '.#default'