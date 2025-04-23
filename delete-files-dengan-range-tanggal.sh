#!/bin/bash

# Inputan jangka Tanggal awal dan akhir yang akan di hapus
read -p "Masukkan Tanggal Mulai (YYYY-MM-DD): " START_DATE_INPUT
read -p "Masukkan Tanggal Akhir (YYYY-MM-DD): " END_DATE_INPUT

# Arahkan ke folder yang akan di hapus filenya
FOLDER="/mnt/data/dump"

# Jangan Biarkan Inputan kosong
if [[ -z "$START_DATE_INPUT" || -z "$END_DATE_INPUT" ]]; then
    echo "Input tidak boleh kosong!"
    exit 1
fi

# Format tanggal lengkap
START_DATE="${START_DATE_INPUT} 00:00:00"
# Tambahkan satu hari ke END_DATE agar hasil 'find' mencakup hingga akhir tanggal akhir
END_DATE=$(date -d "$END_DATE_INPUT + 1 day" +"%Y-%m-%d 00:00:00")

# Menampilkan file yang akan dihapus
echo "File yang akan dihapus dari tanggal $START_DATE_INPUT sampai $END_DATE_INPUT:"
find "$FOLDER" -type f -newermt "$START_DATE" ! -newermt "$END_DATE"

# Konfirmasi sebelum file di hapus
read -p "Apakah Anda yakin ingin menghapus file ini? (y/n): " CONFIRM
if [[ "$CONFIRM" == "y" || "$CONFIRM" == "Y" ]]; then
    find "$FOLDER" -type f -newermt "$START_DATE" ! -newermt "$END_DATE" -exec rm -v {} \;
    echo "File berhasil dihapus."
else
    echo "Penghapusan dibatalkan."
fi