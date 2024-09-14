#!/bin/bash

# Function to update and install necessary packages
install_packages() {
    echo "Updating package lists..."
    sudo apt-get update -y

    echo "Installing essential packages..."
    sudo apt-get install -y curl unzip git build-essential golang-go python3 python3-pip jq libpcap-dev cargo
}

# Function to install Go if the version is not 1.21 or later
install_go() {
    go_version=$(go version | grep -oP '\d+\.\d+\.\d+')
    required_version="1.21.0"
    
    if [ "$(printf '%s\n' "$required_version" "$go_version" | sort -V | head -n1)" != "$required_version" ]; then
        echo "Updating Go to version 1.21 or later..."
        wget https://golang.org/dl/go1.21.1.linux-amd64.tar.gz
        sudo tar -C /usr/local -xzf go1.21.1.linux-amd64.tar.gz
        export PATH=$PATH:/usr/local/go/bin
        rm go1.21.1.linux-amd64.tar.gz
    fi
}

# Function to install Project Discovery tools
install_project_discovery_tools() {
    echo "Installing Project Discovery tools..."

    # Check if Go is installed and in PATH
    if ! command -v go &> /dev/null; then
        echo "Go is not installed or not in PATH. Please install Go."
        exit 1
    fi

    # Ensure Go version is 1.21 or later
    install_go

    # Install Project Discovery tools
    go install github.com/projectdiscovery/httpx/cmd/httpx@latest
    go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
    go install github.com/owasp-amass/amass/v3/...@latest
    go install github.com/projectdiscovery/naabu/v2/cmd/naabu@latest

    echo "Project Discovery tools installed successfully."
}

# Function to install Nuclei and templates
install_nuclei() {
    echo "Installing Nuclei..."

    # Ensure Go version is 1.21 or later
    install_go

    # Install Nuclei
    go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest

    echo "Nuclei installed successfully."

    # Install Nuclei templates
    echo "Updating Nuclei templates..."
    nuclei -update-templates

    echo "Nuclei templates installed successfully."
}

# Function to install Python libraries
install_python_libraries() {
    echo "Installing Python libraries..."
    pip3 install --upgrade pip
    pip3 install requests beautifulsoup4

    echo "Python libraries installed successfully."
}

# Function to install Findomain
install_findomain() {
    echo "Attempting to install Findomain..."

    # Remove existing directory if it exists
    if [ -d "findomain" ]; then
        echo "Removing existing Findomain directory..."
        rm -rf findomain
    fi

    # Clone the repository
    git clone https://github.com/findomain/findomain.git
    cd findomain || exit

    # Build the project
    cargo build --release

    # Move the binary to /usr/local/bin
    sudo cp target/release/findomain /usr/local/bin/

    # Clean up
    cd ..
    rm -rf findomain

    echo "Findomain installed successfully."
}

# Function to verify installations
verify_installations() {
    echo "Verifying installations..."

    # Verify Go installation
    if ! command -v go &> /dev/null; then
        echo "Go installation not found."
        exit 1
    fi
    go version

    # Verify Project Discovery tools
    for tool in httpx subfinder amass naabu nuclei findomain; do
        if ! command -v $tool &> /dev/null; then
            echo "$tool not found."
            if [ "$tool" == "naabu" ]; then
                echo "Attempting to install Naabu again..."
                go install github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
            elif [ "$tool" == "findomain" ]; then
                install_findomain
            elif [ "$tool" == "nuclei" ]; then
                install_nuclei
            fi
        else
            $tool -version
        fi
    done

    # Check if Nuclei templates are installed
    if nuclei -update-templates &> /dev/null; then
        echo "Nuclei templates are installed and up to date."
    else
        echo "Error updating Nuclei templates. Attempting to update again..."
        nuclei -update-templates
    fi
    fi  

    # Verify Python libraries
    python3 -c "import requests; print('Requests version:', requests.__version__)"
    python3 -c "import bs4; print('BeautifulSoup4 version:', bs4.__version__)"
}

# Main function to run all steps
main() {
    install_packages
    install_project_discovery_tools
    install_nuclei
    install_python_libraries
    export PATH=$PATH:$HOME/go/bin
    verify_installations
    echo "All installations completed successfully."
}

# Run the main function
main
