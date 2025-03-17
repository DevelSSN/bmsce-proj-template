#!/bin/bash

# Function to install TeX Live packages via tlmgr
install_tlmgr_packages() {
    echo "Installing TeX Live packages..."
    tlmgr install tabulary graphicx lipsum geometry soul hyphenat ragged2e pgf logreq
}

# Function to install biber
install_biber() {
    echo "Installing Biber..."
    if ! command -v biber &> /dev/null
    then
        echo "Biber not found, installing..."
        # Install biber (for Debian/Ubuntu-based systems)
        sudo apt-get update
        sudo apt-get install -y biber
    else
        echo "Biber is already installed!"
    fi
}

# Function to install pandoc
install_pandoc() {
    echo "Installing Pandoc..."
    if ! command -v pandoc &> /dev/null
    then
        echo "Pandoc not found, installing..."
        # Install pandoc (for Debian/Ubuntu-based systems)
        sudo apt-get update
        sudo apt-get install -y pandoc
    else
        echo "Pandoc is already installed!"
    fi
}

# Function to install tlmgr
install_tlmgr() {
    echo "Installing tlmgr..."
    if ! command -v tlmgr &> /dev/null
    then
        echo "tlmgr not found, installing TeX Live..."
        # Install TeX Live (for Debian/Ubuntu-based systems)
        sudo apt-get update
        sudo apt-get install -y texlive
    else
        echo "tlmgr is already installed!"
    fi
}

# Function to check and install necessary tools
install_tools() {
    # Check if tlmgr, biber, and pandoc are installed
    if ! command -v tlmgr &> /dev/null
    then
        read -p "tlmgr is not installed. Would you like to install it? (y/n): " response
        if [[ "$response" =~ ^[Yy]$ ]]
        then
            install_tlmgr
        fi
    else
        echo "tlmgr is already installed."
    fi

    if ! command -v biber &> /dev/null
    then
        read -p "Biber is not installed. Would you like to install it? (y/n): " response
        if [[ "$response" =~ ^[Yy]$ ]]
        then
            install_biber
        fi
    else
        echo "Biber is already installed."
    fi

    if ! command -v pandoc &> /dev/null
    then
        read -p "Pandoc is not installed. Would you like to install it? (y/n): " response
        if [[ "$response" =~ ^[Yy]$ ]]
        then
            install_pandoc
        fi
    else
        echo "Pandoc is already installed."
    fi
}

# Main installation process
echo "Starting installation process..."

install_tools

# Install TeX Live packages
read -p "Would you like to install the TeX Live packages? (y/n): " response
if [[ "$response" =~ ^[Yy]$ ]]
then
    install_tlmgr_packages
fi

echo "Installation process complete!"
