#!/bin/bash
#
# This is a quick start guide to setting up a machine

readonly BREW_CONFIG_CLEAN="Updating and cleaning up Brew...\n"
readonly PACKAGES_INSTALL="Installing common packages...\n"
readonly PACKAGES_INSTALL_CASK="Installing MacOS Brew Cask Packages...\n"
readonly INSTALL_PROMPT="Installing the following packages...\n"
readonly INSTALL_PROMPT_MACOS="Installing the following HomeBrew Packages...\n"
readonly INSTALL_PROMPT_LINUX="Installing the following APT Packages...\n"

# Brew packages to pick up
readonly PACKAGES=(
"cowsay"
"cmus"
"curl"
"findutils"
"gcc"
"gdb"
"gearboy"
"git"
"go"
"htop"
"lua"
"lynx"
"maven"
"mongodb"
"mplayer"
"mpv"
"mutt"
"neofetch"
"neovim"
"node"
"perl"
"ponysay"
"python3"
"tree"
"tmux"
"youtube-dl"
"zsh"
"zsh-completions"
)

# Brew cask package to pick up
readonly PACKAGES_BREW=(
"appcleaner"
"coconutbattery"
"gfxcardstatus"
"gifcapture"
"gimp"
"google-backup-and-sync"
"intellij-idea-ce"
"java"
"mgba"
"omnidisksweeper"
"private-internet-access"
"qutebrowser"
"smcfancontrol"
"spotify"
"vimr"
"vnc-viewer"
)

# Array of packages for debian based linux
readonly PACKAGES_APT=()

# Array of git repos I wanted local
readonly GIT=(
"https://github.com/robbyrussell/oh-my-zsh.git"
"https://github.com/ubuntuphp/cute-browser.git"
)

# Project folder to save all repos
readonly PROJECT_FOLDER="~yui/Documents/projects"

# Name of current OS
readonly SYSTEM_NAME=`uname`


# Updates brew, upgrades current packages, and cleans up system
function brew_configs() {
    echo $BREW_CONFIG_CLEAN
    brew update
    brew upgrade --all
    brew cleanup
}

# Checks to see if the Project folder exist
function create_project_folder() {
if [[ ! -d "$PROJECT_FOLDER" ]]; then
    mkdir $PROJECT_FOLDER
fi
}

# Installs all listed packages for Linux
function install_linux_packages() {
    echo 'Linux\n'
    for item in ${PACKAGES[@]}
    do
        sudo apt install $item
    done
}

# Installs all listed packages for MacOS
function install_macos_packages() {
    echo "macOS\n"
    for item in ${PACKAGES[@]}
    do
        brew install $item
    done
    for item in ${PACKAGES_BREW[@]}
    do
        brew cask install $item
    done
}

# List all packages to be installed
function list_packages() {
    echo $INSTALL_PROMPT
    for item in ${PACKAGES[@]}
    do
        echo $item
    done
    echo "\n"
    if [[ "$SYSTEM_NAME" == 'Darwin' ]]; then
        echo $INSTALL_PROMPT_MACOS

        for item in ${PACKAGES_BREW[@]}
        do
            echo $item
        done
    fi
    if [[ "$SYSTEM_NAME" == 'Linux' ]]; then
        echo $INSTALL_PROMPT_LINUX

        for item in ${PACKAGES_APT[@]}
        do
            echo $item
        done
    fi
    echo "\n"
}

list_packages
if [[ "$1" == 'Linux' ]]; then
    install_linux_packages
else
    brew_configs
    install_macos_packages
fi