# TermuXpress Developer Commentary

## 1. Core Language Choice
The project is intentionally heavily weighted (93%%) toward Shell Scripting (SH). This decision prioritizes compatibility, quick execution, and resource efficiency within the constrained Termux/Android environment.

## 2. Packaging Strategy
Initial attempts to package TermuXpress using dpkg-deb led to significant system instability due to lock contention issues (e.g., linker64 process) when installing large dependencies like code-server.
The primary installation method is now the source build script (compiling.sh). The .deb files are for historical reference only.

## 3. NeoVim Configuration
Configuration is kept minimal (init.lua) to ensure fast startup times on mobile devices.
