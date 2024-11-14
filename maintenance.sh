#!/bin/bash

# Nama program: Maintenance Paket
# Fungsi: Memperbaharui sistem, membersihkan cache, dan melakukan pemeliharaan umum.
# Author: [drus-jc] - [14 November 2024]
# Github: https://github.com/drus-jc
# Cara menjalankan: berikan ijin agar bisa berjalan | chmod +x path/to/your/pach/maintenance.sh
# Cara pertama: Pergi ke direktory tempat menyimpan maintenance.sh | lalu berikan perintah ./maintenance.sh
# Cara kedua: path/to/pach/maintenance.sh
# Silahkan hapus atau beri # pada awal perintah yang di perlukan

# Fungsi untuk menampilkan animasi loading
loading() {
    spinner="/-\|"
    while true; do
        for i in {1..4}; do
            echo -ne "\rSedang bekerja... ${spinner:i-1:1}"
            sleep 0.1
        done
    done
}

# Menghapus layar teminal
clear
echo "Silahkan tunggu sebentar...."
echo "$(date '+%d-%m-%Y %H:%M:%S')"

# Update sistem
echo "Sedang melakukan Update..."
loading &  # Jalankan animasi loading di background
PID=$!      # Simpan PID proses loading
if sudo apt update >/dev/null 2>&1; then
    # Pastikan proses loading masih berjalan sebelum dihentikan
    if ps -p $PID > /dev/null; then
        kill $PID   # Hentikan animasi loading
    fi
    echo -e "\rUpdate Berhasil          "  # Hapus karakter loading
else
    # Pastikan proses loading masih berjalan sebelum dihentikan
    if ps -p $PID > /dev/null; then
        kill $PID   # Hentikan animasi loading
    fi
    echo -e "\rGagal meng-update, periksa koneksi internet dan coba lagi!"
    exit 1
fi

# Cek apakah ada paket yang upgradable
UPGRADABLE=$(apt list --upgradable 2>/dev/null)

if [[ -z "$UPGRADABLE" ]]; then
    echo "Tidak ada paket yang perlu diupgrade."
else
    echo "Memeriksa Paket dan Melakukan Upgrade..."
    loading &  # Jalankan animasi loading di background
    PID=$!      # Simpan PID proses loading
    if sudo apt upgrade -y >/dev/null 2>&1; then
        # Pastikan proses loading masih berjalan sebelum dihentikan
        if ps -p $PID > /dev/null; then
            kill $PID   # Hentikan animasi loading
        fi
        echo -e "\rUpgrade selesai.          "
    else
        # Pastikan proses loading masih berjalan sebelum dihentikan
        if ps -p $PID > /dev/null; then
            kill $PID   # Hentikan animasi loading
        fi
        echo -e "\rGagal melakukan upgrade, periksa internet dan coba lagi!"
        exit 1
    fi
fi

# Melakukan refresh untuk aplikasi snap
echo "Memeriksa paket snap..."
loading &  # Jalankan animasi loading di background
PID=$!      # Simpan PID proses loading
if sudo snap refresh >/dev/null 2>&1; then
    # Pastikan proses loading masih berjalan sebelum dihentikan
    if ps -p $PID > /dev/null; then
        kill $PID   # Hentikan animasi loading
    fi
    echo -e "\rSemua aplikasi snap telah diupdate.          "
else
    # Pastikan proses loading masih berjalan sebelum dihentikan
    if ps -p $PID > /dev/null; then
        kill $PID   # Hentikan animasi loading
    fi
    echo -e "\rGagal memperbaharui aplikasi snap, periksa internet dan coba lagi"
    exit 1
fi

# Hapus paket-paket yang tidak diperlukan
echo "Menghapus paket-paket yang tidak diperlukan..."
loading &  # Jalankan animasi loading di background
PID=$!      # Simpan PID proses loading
if sudo apt autoremove -y >/dev/null 2>&1; then
    # Pastikan proses loading masih berjalan sebelum dihentikan
    if ps -p $PID > /dev/null; then
        kill $PID   # Hentikan animasi loading
    fi
    echo -e "\rSemua paket yang tidak diperlukan telah dihapus.          "
else
    # Pastikan proses loading masih berjalan sebelum dihentikan
    if ps -p $PID > /dev/null; then
        kill $PID   # Hentikan animasi loading
    fi
    echo -e "\rGagal menghapus paket yang tidak diperlukan"
    exit 1
fi

# Hapus cache yang tidak diperlukan
echo "Menghapus cache yang tidak diperlukan..."
loading &  # Jalankan animasi loading di background
PID=$!      # Simpan PID proses loading
if sudo apt autoclean -y >/dev/null 2>&1; then
    # Pastikan proses loading masih berjalan sebelum dihentikan
    if ps -p $PID > /dev/null; then
        kill $PID   # Hentikan animasi loading
    fi
    echo -e "\rCache yang tidak diperlukan telah dihapus.          "
else
    # Pastikan proses loading masih berjalan sebelum dihentikan
    if ps -p $PID > /dev/null; then
        kill $PID   # Hentikan animasi loading
    fi
    echo -e "\rGagal menghapus cache"
    exit 1
fi

if sudo apt clean -y >/dev/null 2>&1; then
    # Pastikan proses loading masih berjalan sebelum dihentikan
    if ps -p $PID > /dev/null; then
        kill $PID   # Hentikan animasi loading
    fi
    echo -e "\rSemua cache yang tidak diperlukan telah dihapus.          "
else
    # Pastikan proses loading masih berjalan sebelum dihentikan
    if ps -p $PID > /dev/null; then
        kill $PID   # Hentikan animasi loading
    fi
    echo -e "\rGagal menghapus cache"
    exit 1
fi

# Tampilkan pesan selesai
echo "Aplikasi dan sistem kamu sudah dalam kondisi up to date."
echo "$(date '+%d-%m-%Y %H:%M:%S')"
echo "Terima kasih telah menggunakan script dari drus-jc"

# Reboot sistem setelah proses selesai
#reboot
# Shutdown sistem setelah proses selesai
#shutdown
