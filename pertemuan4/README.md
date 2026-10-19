# Praktikum Flutter - Pertemuan 4

## Mengambil Data dari REST API

Praktikum ini membahas cara mengambil data dari REST API menggunakan Flutter dan Dart, mengolah respons JSON menjadi objek model, serta menampilkan data secara asinkron menggunakan `FutureBuilder`.

## Tujuan Pembelajaran

Setelah menyelesaikan praktikum ini, mahasiswa diharapkan mampu:

1. Memahami konsep `Future`, `async`, dan `await` dalam Dart.
2. Mengambil data dari REST API menggunakan paket `http`.
3. Mengubah data JSON menjadi objek menggunakan model dan `fromJson`.
4. Menampilkan data menggunakan `FutureBuilder`.
5. Menangani status loading, error, dan data.
6. Membuat fitur untuk memuat ulang data.

## Teknologi yang Digunakan

- Flutter
- Dart
- HTTP
- REST API
- JSON
- FutureBuilder
- JSONPlaceholder API

## Persiapan Proyek

Buat proyek Flutter baru menggunakan perintah:

```bash
flutter create praktikum_4
```

Masuk ke direktori proyek:

```bash
cd praktikum_4
```

Tambahkan paket HTTP:

```bash
flutter pub add http
```

Pastikan perangkat atau emulator memiliki koneksi internet.

## Endpoint API

Praktikum ini menggunakan JSONPlaceholder sebagai API publik untuk latihan.

| Endpoint | Fungsi |
|---|---|
| `/users` | Mengambil daftar pengguna |
| `/posts` | Mengambil daftar postingan |
| `/posts/{id}/comments` | Mengambil komentar berdasarkan ID postingan |

Base URL:

`https://jsonplaceholder.typicode.com`

## Materi Praktikum

### Bagian A: Future dan FutureBuilder

Mempelajari cara menangani proses asinkron dengan mensimulasikan pengambilan data selama dua detik.

Checkpoint:
- Indikator loading tampil terlebih dahulu.
- Teks muncul setelah proses selesai.
- Future dibuat di `initState()` agar tidak berulang setiap kali widget dibangun ulang.

### Bagian B: Menyiapkan HTTP

Menambahkan paket `http` untuk mengirim permintaan HTTP ke REST API.

### Bagian C: Model dan Pengambilan Data

Membuat model `Pengguna` dengan atribut:

- `id`
- `name`
- `email`
- `phone`
- `website`

Menggunakan `Pengguna.fromJson()` untuk mengubah respons JSON menjadi objek Dart.

### Bagian D: Menampilkan Data

Menggunakan `FutureBuilder` untuk menampilkan daftar pengguna dengan tiga kondisi:

- Loading: menampilkan indikator proses.
- Error: menampilkan pesan kesalahan dan tombol coba lagi.
- Success: menampilkan daftar pengguna.

Fitur tambahan berupa tombol refresh untuk mengambil ulang data.

### Bagian E: Halaman Detail

Ketika pengguna dipilih, aplikasi membuka halaman detail yang menampilkan email, nomor telepon, dan situs web.

### Bagian F: Pengujian Error

Melakukan pengujian untuk mengetahui respons aplikasi ketika:

1. Endpoint API tidak ditemukan.
2. Koneksi internet terputus.
3. Pengambilan data perlu diulangi.

## Tugas Praktikum

Buat aplikasi **Daftar Postingan** dengan ketentuan:

1. Halaman utama menampilkan judul dan potongan isi postingan dari endpoint `/posts`.
2. Pengguna dapat membuka halaman detail postingan.
3. Halaman detail menampilkan isi lengkap dan daftar komentar dari endpoint `/posts/{id}/comments`.
4. Membuat model `Post` dan `Komentar` menggunakan `fromJson`.
5. Memisahkan kode model, layanan pengambilan data, dan UI.
6. Menangani kondisi loading dan error pada halaman daftar maupun detail.
7. Menyediakan tombol coba lagi ketika terjadi kesalahan.

### Berkas yang Dikumpulkan

- Source code aplikasi, terutama `main.dart` atau tautan repository.
- Screenshot halaman daftar postingan.
- Screenshot halaman detail postingan.
- Screenshot tampilan error.

## Menjalankan Aplikasi

Pastikan terminal berada di direktori proyek, kemudian jalankan:

```bash
flutter pub get
flutter run
```

Jika menggunakan konfigurasi custom command di terminal, `flutter run` dapat dijalankan melalui alias `fr`.

## Troubleshooting

| Masalah | Solusi |
|---|---|
| `SocketException` atau `Failed host lookup` | Periksa koneksi internet emulator atau perangkat. |
| Paket `http` tidak ditemukan | Jalankan `flutter pub get`. |
| Data dimuat ulang berulang kali | Buat Future di `initState()`, bukan di `build()`. |
| Error tipe data `Null` | Periksa nama key dan struktur respons JSON. |
| API lambat atau tidak tersedia | Coba lagi setelah beberapa saat. |

## Referensi

- [Flutter Networking Cookbook](https://docs.flutter.dev/cookbook/networking/fetch-data)
- [Dart Async and Await](https://dart.dev/codelabs/async-await)
- [Paket HTTP](https://pub.dev/packages/http)
- [JSONPlaceholder](https://jsonplaceholder.typicode.com)
