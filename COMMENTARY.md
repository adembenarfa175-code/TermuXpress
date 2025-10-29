# TermuXpress Developer Commentary

## 1. Core Language Choice
The project relies heavily on Shell Scripting (93%) for compatibility and efficiency within the Termux environment.

## 2. Packaging Strategy
The source build script (compiling.sh) is the primary installation method due to instability encountered with dpkg-deb and system lock issues.

## 3. NeoVim Configuration
The configuration (init.lua) is kept minimal for fast startup times on mobile devices.
