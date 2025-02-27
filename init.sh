#!/bin/bash

# Function to check if tlmgr is installed
check_tlmgr_installed() {
    if ! command -v tlmgr &> /dev/null; then
        echo "TeX Live Manager (tlmgr) is not installed. Please install it first."
        exit 1
    fi
}

# Function to install required LaTeX packages using tlmgr
install_required_packages() {
    required_packages=(
        amsfonts
        amsmath
        lm
        unicode-math
        iftex
        listings
        fancyvrb
        longtable
        booktabs
        multirow
        graphicx
        bookmark
        xcolor
        soul
        geometry
        setspace
        babel
        xeCJK
        luatexja
        framed
        fontspec
        selnolig
        lua-ul
        bidi
        mathspec
        upquote
        microtype
        parskip
        xurl
        footnotehyper
        natbib
        biblatex
        bibtex
        biber
    )

    # Ensure tlmgr is up-to-date before installing packages
    echo "Updating tlmgr..."
    tlmgr update --self

    echo "Installing required LaTeX packages..."
    for package in "${required_packages[@]}"; do
        echo "Installing $package..."
        tlmgr install "$package"
    done
    echo "All required LaTeX packages are installed."
}

# Menu to choose options
while true; do
    echo "Select an option:"
    echo "1) Use Online LaTeX Compiler (does nothing)"
    echo "2) Ensure tlmgr is installed with required packages for pandoc"
    echo "3) Exit"
    
    read -p "Enter your choice (1-3): " choice
    
    case $choice in
        1)
            echo "Option 1: Use an online LaTeX compiler (does nothing)"
            # Option 1 does nothing
            ;;
        2)
            check_tlmgr_installed
            install_required_packages
            ;;
        3)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option. Please choose a valid option."
            ;;
    esac
done
