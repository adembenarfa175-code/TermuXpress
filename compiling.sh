#!/bin/bash
# سكريبت compiling.sh: بناء TermuXpress من المصدر (بدون dpkg-deb)

echo "🛠️ TermuXpress Compiler - Starting source build..."

# ====================================================================
# 1. تثبيت التبعيات الأساسية المطلوبة
# ====================================================================
echo "Installing core dependencies (code-server, nodejs-22, ripgrep)..."
pkg update
pkg install -y code-server nodejs-22 ripgrep neovim curl git termux-api

# ====================================================================
# 2. إعداد المسارات
# ====================================================================
PREFIX_DIR="$PREFIX"
SHARE_DIR="$PREFIX_DIR/share/termuxpress"
BIN_DIR="$PREFIX_DIR/bin"
CONFIG_SOURCE_DIR="$HOME/TermuXpress/config"
SCRIPTS_SOURCE_DIR="$HOME/TermuXpress/scripts"

# إنشاء المجلدات النهائية في $PREFIX
mkdir -p "$SHARE_DIR/config"
mkdir -p "$SHARE_DIR/scripts"
mkdir -p "$BIN_DIR"

# ====================================================================
# 3. نسخ الملفات إلى النظام
# ====================================================================
echo "Copying scripts and config files to system paths..."
# نسخ سكريبت التشغيل (start-ide.sh)
cp "$SCRIPTS_SOURCE_DIR/start-ide.sh" "$SHARE_DIR/scripts/"
chmod 755 "$SHARE_DIR/scripts/start-ide.sh"

# نسخ ملفات التكوين (init.lua)
cp "$CONFIG_SOURCE_DIR/init.lua" "$SHARE_DIR/config/"

# إنشاء الرابط الرمزي للاختصار (مثلما كان يفعل postinst)
ln -sf "$SHARE_DIR/scripts/start-ide.sh" "$BIN_DIR/tmx"

# ====================================================================
# 4. تثبيت إضافات NeoVim (Packer)
# ====================================================================
echo "Installing NeoVim plugin manager (Packer)..."
if [ ! -d "$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim" ]; then
    git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    "$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
fi

# نسخ إعدادات NVIM إلى $HOME إذا لم تكن موجودة
if [ ! -d "$HOME/.config/nvim" ]; then
    mkdir -p "$HOME/.config/nvim"
fi
cp -f "$SHARE_DIR/config/init.lua" "$HOME/.config/nvim/"

echo "🎉 بناء TermuXpress من المصدر اكتمل بنجاح!"
echo "يمكنك تشغيل بيئة التطوير الآن باستخدام الأمر: tmx"
