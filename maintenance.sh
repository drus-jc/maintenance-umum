#!/bin/bash

# Nama program: Maintenance Paket
# Fungsi: Memperbaharui sistem, membersihkan cache, dan melakukan pemeliharaan umum.
# Author: [drus-jc] - [14 November 2024]
# Github: https://github.com/drus-jc
# Cara menjalankan: berikan ijin agar bisa berjalan | chmod +x path/to/your/pach/maintenance.sh
# Cara pertama: Pergi ke direktory tempat menyimpan maintenance.sh | lalu berikan perintah ./maintenance.sh
# Cara kedua: path/to/pach/maintenance.sh
# Silahkan hapus atau beri # pada awal perintah yang di perlukan

# Menghapus layar teminal
clear
echo "Silahkan tunggu sebentar...."
echo "$(date '+%d-%m-%Y %H:%M:%S')"

# Update sistem
echo "Sedang melakukan Update..."
if sudo apt update >/dev/null 2>&1; then
    echo "Update Berhasil"
else
    echo "Gagal meng update, periksa koneksi internet dan coba lagi!"
    exit 1
fi

# Cek apakah ada paket yang upgradable
UPGRADABLE=$(apt list --upgradable 2>/dev/null)

if [[ -z "$UPGRADABLE" ]]; then
    echo "Tidak ada paket yang perlu diupgrade."
else
    echo "Memeriksa Paket dan Melakukan Upgrade..."
    if sudo apt upgrade -y >/dev/null 2>&1; then
        echo "Upgrade selesai."
    else
        echo "Gagal melakukan upgrade, periksa internet dan coba lagi!"
        exit 1
    fi
fi

# Melakukan refresh untuk aplikasi snap
echo "Memeriksa paket snap..."
if sudo snap refresh >/dev/null 2>&1; then
    echo "Semua aplikasi snap telah diupdate."
else
    echo "Gagal memperbaharui aplikasi snap, periksa internet dan coba lagi"
    exit 1
fi

# Hapus paket-paket yang tidak diperlukan
if sudo apt autoremove -y >/dev/null 2>&1; then
    echo "Semua paket yang tidak diperlukan telah dihapus."
else
    echo "Gagal menghapus paket yang tidak diperlukan"
    exit 1
fi

# Hapus cache yang tidak diperlukan
if sudo apt autoclean -y >/dev/null 2>&1; then
    echo "Cache yang tidak diperlukan telah dihapus."
else
    echo "Gagal menghapus cache"
    exit 1
fi

if sudo apt clean -y >/dev/null 2>&1; then
    echo "Semua cache yang tidak diperlukan telah dihapus."
else
    echo "Gagal menghapus cache"
    exit 1
fi

# Menghapus pesan aktivitas
#clear
# Tampilkan pesan selesai
echo "Aplikasi dan sistem kamu sudah dalam kondisi up to date."
echo "$(date '+%d-%m-%Y %H:%M:%S')"
echo "Terima kasih telah menggunakan script dari drus-jc"

# Reboot sistem setelah proses selesai
#reboot
# Shutdown sistem setelah proses selesai
#shutdown
