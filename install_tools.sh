#!/bin/bash

# Display a colorful title
echo -e "\e[1;32m Installing Required Tools - SM-TOOL \e[0m\n"

# List of required tools
REQUIRED_TOOLS=("curl" "nslookup" "subfinder" "nuclei" "httpx")

# Function to install missing tools
install_tools() {
    echo -e "\e[1;34m[+] Checking and installing required tools...\e[0m"
    for tool in "${REQUIRED_TOOLS[@]}"; do
        if ! command -v $tool &>/dev/null; then
            echo -e "\e[1;31m[-] $tool is not installed. Installing...\e[0m"
            if [[ "$tool" == "subfinder" || "$tool" == "nuclei" || "$tool" == "httpx" ]]; then
                # Install using Go
                GO111MODULE=on go install -v github.com/projectdiscovery/$tool/v2/cmd/$tool@latest
                mv ~/go/bin/$tool /usr/local/bin/
            else
                # Install using apt (for common tools)
                sudo apt-get install -y $tool
            fi
        else
            echo -e "\e[1;32m[+] $tool is already installed.\e[0m"
        fi
    done
    echo -e "\e[1;34m[+] Installation completed!\e[0m"
}

# Execute installation
install_tools
