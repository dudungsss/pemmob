# TabungKu Layout

## Data Mahasiswa

- **Nama:** Yuliadhy Nugraha
- **NIM:** 20240801031
- **Mata Kuliah:** Pemrograman Mobile
- **Tugas:** Minggu 3 - Menyusun Layout dengan Widget Dasar Flutter

## Gambaran Aplikasi

TabungKu Layout adalah aplikasi Flutter sederhana yang menampilkan ringkasan tabungan. Tampilannya memakai warna pink pastel dengan susunan yang bersih dan mudah dibaca.

Aplikasi ini hanya memakai widget bawaan Flutter dari materi pertemuan 1 dan 2, tanpa package tambahan. Semua data tabungan dan transaksi ditulis langsung di kode (hard-code).

## Bagian Tampilan

1. **Kartu Tabungan**
   Satu Card memuat nama tabungan, saldo terkini, dan target yang ingin dicapai.

2. **Menu Kategori**
   Tiga menu berbentuk ikon dengan label: Menabung, Tarik, dan Riwayat.

3. **Daftar Transaksi**
   Tiga transaksi ditampilkan lengkap dengan judul, tanggal, dan nominalnya.

4. **Tampilan yang Menyesuaikan Layar**
   Konten dibungkus ListView sehingga tetap bisa digulir di ukuran layar apa pun.

## Widget yang Dipakai

| Widget | Kegunaan |
|---|---|
| MaterialApp | Pembungkus utama aplikasi |
| Scaffold | Rangka dasar halaman |
| AppBar | Bilah judul di bagian atas |
| Card | Kartu pembungkus informasi |
| Column | Menyusun widget ke bawah |
| Row | Menyusun widget ke samping |
| Padding | Memberi ruang di sekitar konten |
| Expanded | Membagi sisa ruang yang tersedia |
| ListView | Daftar yang bisa digulir |
| ListTile | Baris item transaksi |
| Text | Menampilkan tulisan |
| Icon | Menampilkan ikon |
| SizedBox | Memberi celah antarwidget |

## Langkah Menjalankan

1. Pastikan Flutter SDK dan VS Code sudah terpasang.
2. Buka folder proyek `tabungku_layout` di VS Code.
3. Nyalakan emulator Android atau sambungkan HP Android.
4. Buka terminal di folder proyek.
5. Unduh dependensi dengan perintah:

```bash
flutter pub get
```

6. Jalankan aplikasi:

```bash
flutter run
```

7. Cek kesalahan kode dengan:

```bash
flutter analyze
```

## Susunan Folder

```text
tabungku_layout/
├── docs/
│   └── img/
│       ├── tampilan_hp.png
│       └── tampilan_tablet.png
├── lib/
│   └── main.dart
├── README.md
└── pubspec.yaml
```

## Penutup

TabungKu Layout dibuat sebagai latihan menyusun antarmuka dengan widget dasar Flutter. Lewat kombinasi Card, Column, Row, Padding, ListView, dan widget lainnya, data tabungan tampil rapi dan mudah dipahami.

Aplikasi ini baru berfokus pada tampilan. Fitur untuk mengelola transaksi belum tersedia.
