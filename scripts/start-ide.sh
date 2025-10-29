#!/bin/bash
# start-ide.sh: TermuXpress Launch Script

echo "🚀 Starting TermuXpress Mobile Development Environment..."

# 1. Check for Termux-API (required for clipboard/notifications)
if ! command -v termux-notification &> /dev/null
then
    echo "Warning: termux-api not found. Some features may be disabled."
fi

# 2. Check for code-server and launch it
if command -v code-server &> /dev/null
then
    echo "Launching Code-Server (accessible via browser at 127.0.0.1:8080)"
    code-server --bind-addr 127.0.0.1:8080 &
else
    echo "Error: 'code-server' is not installed or not in PATH."
    exit 1
fi

# 3. Launch NeoVim TUI interface
if command -v nvim &> /dev/null
then
    echo "Launching NeoVim TUI. Press Ctrl+C to stop."
    nvim
else
    echo "Warning: 'nvim' is not installed. Only Code-Server is running."
fi

# 4. Cleanup background processes (Code-Server)
echo "TermuXpress exited. Stopping background processes..."
pkill -f 'code-server'

