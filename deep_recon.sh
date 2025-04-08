#!/bin/bash

# Display a colorful title
echo -e "\e[1;34m ███████╗███╗   ███╗      ████████╗ ██████╗  ██████╗ ██╗      \e[0m\n"
echo -e "\e[1;34m ██╔════╝████╗ ████║      ╚══██╔══╝██╔═══██╗██╔═══██╗██║      \e[0m\n"
echo -e "\e[1;34m ███████╗██╔████╔██║         ██║   ██║   ██║██║   ██║██║      \e[0m\n"
echo -e "\e[1;34m ╚════██║██║╚██╔╝██║         ██║   ██║   ██║██║   ██║██║      \e[0m\n"
echo -e "\e[1;34m ███████║██║ ╚═╝ ██║         ██║   ╚██████╔╝╚██████╔╝███████╗ \e[0m\n"
echo -e "\e[1;34m ╚══════╝╚═╝     ╚═╝         ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝ \e[0m"
echo -e "\e[1;34m Deep Recon Script - SM-TOOL \e[0m\n"
echo -e "\e[1;34m Github-UserName: @smrokon07  \e[0m\n"


# Check if required tools are installed
REQUIRED_TOOLS=("curl" "nslookup" "subfinder" "nuclei" "httpx")
for tool in "${REQUIRED_TOOLS[@]}"; do
    if ! command -v $tool &>/dev/null; then
        echo -e "\e[1;31m[-] $tool is not installed. Please run install_tools.sh first!\e[0m"
        exit 1
    fi
done

# Get the target domain
read -p "Enter target domain: " DOMAIN

# Subdomain enumeration
echo -e "\n\e[1;34m[+] Finding subdomains...\e[0m"
subfinder -d $DOMAIN > subdomains.txt
cat subdomains.txt | httpx -silent > alive_subdomains.txt
echo -e "\e[1;32m[+] Alive subdomains saved to alive_subdomains.txt\e[0m"

# Subdomain takeover check
echo -e "\n\e[1;34m[+] Checking for subdomain takeovers...\e[0m"
cat subdomains.txt | nuclei -t takeover.yaml > takeover_results.txt
echo -e "\e[1;32m[+] Takeover scan results saved to takeover_results.txt\e[0m"

# Basic vulnerability scanning
echo -e "\n\e[1;34m[+] Scanning for vulnerabilities...\e[0m"
cat alive_subdomains.txt | nuclei -t cves > vuln_results.txt
echo -e "\e[1;32m[+] Vulnerabilities saved to vuln_results.txt\e[0m"

echo -e "\n\e[1;34m[+] Recon Completed! Check the output files.\e