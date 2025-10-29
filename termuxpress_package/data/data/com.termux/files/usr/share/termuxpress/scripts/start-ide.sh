#!/bin/bash

# المسارات
CONFIG_DIR="$PREFIX/share/termuxpress/config"
SCRIPT_DIR="$PREFIX/share/termuxpress/scripts"
NVIM_CONFIG="$HOME/.config/nvim"

# تأكد من أن termux-api مثبتة (لمعرفة IP)
if ! command -v termux-api &> /dev/null; then
    echo "Error: termux-api is required. Please run 'pkg install termux-api'."
    exit 1
fi

# ==================================================
# دالة تشغيل Code Server
# ==================================================
launch_code_server() {
    # الحصول على IP المحلي للجهاز
    LOCAL_IP=$(ifconfig | grep -A 1 'inet addr' | awk '{ print $2 }' | cut -d ':' -f 2 | head -1)

    # التحقق من تشغيل Code Server
    if pgrep -f "code-server" > /dev/null; then
        echo "Code Server is already running. Access at: http://$LOCAL_IP:8080"
        return
    fi

    echo "Starting Code Server on port 8080..."
    # تشغيل code-server في الخلفية
    code-server --bind-addr 0.0.0.0:8080 --auth none &

    sleep 3
    echo -e "\nCode Server is ready! Access it via browser at: http://$LOCAL_IP:8080"
    echo "Press [Ctrl+C] to return to the launcher."
    read -r # الانتظار لإشارة من المستخدم
    pkill -f "code-server" # قتل العملية عند العودة
}

# ==================================================
# دالة تشغيل NeoVim
# ==================================================
launch_nvim() {
    echo "Launching NeoVim with custom configuration..."
    nvim
}

# ==================================================
# واجهة TUI البسيطة (القائمة)
# ==================================================
while true; do
    clear
    echo "========================================="
    echo "   🚀 TermuXpress - Mobile Dev Launcher "
    echo "========================================="
    echo "1) 💻 Code-Server (VS Code in Browser)"
    echo "2) 📝 NVIM (Custom Config)"
    echo "3) 🚪 Exit to Termux Shell"
    echo "========================================="
    read -rp "Enter your choice: " choice

    case "$choice" in
        1) launch_code_server ;;
        2) launch_nvim ;;
        3) exit 0 ;;
        *) echo "Invalid choice. Press any key to continue..." && read -r ;;
    esac
done
