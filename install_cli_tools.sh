#!/bin/bash

# Script: install_cli_tools.sh
# Description: Installs system-level CLI tools required for the AI-Assisted Article Data Extraction project.
# Supported Platforms: Linux (Debian/Ubuntu), Mac (Homebrew)
# Usage: ./install_cli_tools.sh

# Exit on error
set -e

# Function to print colored messages
print_message() {
    local color=$1
    local message=$2
    case $color in
        "red") echo -e "\033[31m[ERROR] $message\033[0m" ;;
        "green") echo -e "\033[32m[SUCCESS] $message\033[0m" ;;
        "yellow") echo -e "\033[33m[WARNING] $message\033[0m" ;;
        "blue") echo -e "\033[34m[INFO] $message\033[0m" ;;
        *) echo "[INFO] $message" ;;
    esac
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Detect the operating system
OS="$(uname -s)"
case "$OS" in
    Linux*)     OS=Linux ;;
    Darwin*)    OS=Mac ;;
    *)          OS=Unknown ;;
esac

print_message "blue" "Detected OS: $OS"

# Install pdftotext (Poppler)
print_message "blue" "Checking for pdftotext..."
if command_exists pdftotext; then
    print_message "green" "pdftotext is already installed."
else
    print_message "yellow" "pdftotext not found. Installing..."
    if [ "$OS" = "Linux" ]; then
        # Check for apt-get (Debian/Ubuntu)
        if command_exists apt-get; then
            print_message "blue" "Installing poppler-utils via apt-get..."
            sudo apt-get update
            sudo apt-get install -y poppler-utils
        else
            print_message "red" "Unsupported Linux distribution. Please install poppler-utils manually."
            print_message "blue" "For other Linux distributions, use your package manager to install poppler-utils."
            exit 1
        fi
    elif [ "$OS" = "Mac" ]; then
        # Check for Homebrew
        if command_exists brew; then
            print_message "blue" "Installing poppler via Homebrew..."
            brew install poppler
        else
            print_message "red" "Homebrew not found. Please install Homebrew first."
            print_message "blue" "Install Homebrew from: https://brew.sh/"
            exit 1
        fi
    else
        print_message "red" "Unsupported OS: $OS. Please install pdftotext manually."
        exit 1
    fi
fi

# Verify pdftotext installation
if command_exists pdftotext; then
    print_message "green" "pdftotext installed successfully."
    print_message "blue" "Version: $(pdftotext -v 2>&1 | head -n 1)"
else
    print_message "red" "Failed to install pdftotext. Please install it manually."
    exit 1
fi

# Optional: Install git (if not installed)
print_message "blue" "Checking for git..."
if command_exists git; then
    print_message "green" "git is already installed."
else
    print_message "yellow" "git not found. Installing..."
    if [ "$OS" = "Linux" ]; then
        if command_exists apt-get; then
            sudo apt-get install -y git
        else
            print_message "red" "Unsupported Linux distribution. Please install git manually."
        fi
    elif [ "$OS" = "Mac" ]; then
        if command_exists brew; then
            brew install git
        else
            print_message "red" "Homebrew not found. Please install git manually."
        fi
    fi
fi

# Verify git installation
if command_exists git; then
    print_message "green" "git installed successfully."
    print_message "blue" "Version: $(git --version)"
else
    print_message "yellow" "git installation skipped or failed. It is optional but recommended."
fi

print_message "green" "CLI tools installation completed successfully!"
print_message "blue" "You can now proceed with the project setup."
