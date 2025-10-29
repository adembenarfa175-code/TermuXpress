#!/bin/bash
# compiling.sh: Builds TermuXpress from source (Bypasses dpkg-deb)

echo "🛠️ TermuXpress Compiler - Starting source build..."

# 1. Install required dependencies
echo "Installing core dependencies (code-server, nodejs-22, ripgrep)..."
pkg update
pkg install -y code-server nodejs-22 ripgrep neovim curl git termux-api

# 2. Define Paths
PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
PREFIX_DIR="$PREFIX"
SHARE_DIR="$PREFIX_DIR/share/termuxpress"
BIN_DIR="$PREFIX_DIR/bin"
CONFIG_SOURCE_DIR="$PROJECT_DIR/config"
SCRIPTS_SOURCE_DIR="$PROJECT_DIR/scripts"

# Create final directories in $PREFIX
mkdir -p "$SHARE_DIR/config"
mkdir -p "$SHARE_DIR/scripts"
mkdir -p "$BIN_DIR"

# 3. Copy files to the system
echo "Copying scripts and config files to system paths..."
cp "$SCRIPTS_SOURCE_DIR/start-ide.sh" "$SHARE_DIR/scripts/"
chmod 755 "$SHARE_DIR/scripts/start-ide.sh"
cp "$CONFIG_SOURCE_DIR/init.lua" "$SHARE_DIR/config/"

# Create symbolic link 'tmx'
ln -sf "$SHARE_DIR/scripts/start-ide.sh" "$BIN_DIR/tmx"

# 4. Install NeoVim plugins (Packer)
echo "Installing NeoVim plugin manager (Packer)..."
if [ ! -d "$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim" ]; then
    git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    "$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
fi

# Copy NVIM settings to $HOME if not present
if [ ! -d "$HOME/.config/nvim" ]; then
    mkdir -p "$HOME/.config/nvim"
fi
cp -f "$SHARE_DIR/config/init.lua" "$HOME/.config/nvim/"

echo "🎉 TermuXpress source build completed successfully!"
echo "Run: tmx"
