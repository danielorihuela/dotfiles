# Configure graphics (this is optional and only needed for GUI apps like ghostty on linux distros other than NixOS)
config-graphics:
    #!/usr/bin/env bash
    if [ "{{ os() }}" == "linux" ]; then
        sudo --preserve-env=PATH env nix run 'github:numtide/system-manager' -- switch --flake '.#default'
    else 
        echo "Unsupported OS: {{ os() }}"
    fi

# Build configuration
build-config config:
    #!/usr/bin/env bash
    if [ "{{ os() }}" == "linux" ]; then
        if ! command -v home-manager 2>&1 >/dev/null; then
            nix run home-manager/master -- init --switch --flake .#{{ config }}
        else
            home-manager switch --flake .#{{ config }}
        fi
    elif [ "{{ os() }}" == "macos" ]; then
        if ! command -v darwin-rebuild 2>&1 >/dev/null; then
            sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .#{{ config }}
        else
            sudo darwin-rebuild switch --flake .#{{ config }}
        fi
    else 
        echo "Unsupported OS: {{ os() }}"
    fi

# Build virtual machine
build-vm vm:
    nix run .#{{ vm }}

# Delete ALL old generations
delete-old-generations:
    sudo nix-collect-garbage -d

# Uninstall all the tools, including Nix
uninstall:
    #!/usr/bin/env bash
    if [ "{{ os() }}" == "macos" ]; then
        nix --extra-experimental-features "nix-command flakes" run nix-darwin#darwin-uninstaller
    fi
    /nix/nix-installer uninstall
