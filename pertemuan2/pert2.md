# Praktikum Flutter - Pertemuan 2

## Layout, ListView, Class, Object, dan Navigasi

Pertemuan 2 membahas cara membuat tampilan aplikasi Flutter yang lebih terstruktur serta menampilkan data dalam bentuk daftar. Materi yang dipelajari meliputi penggunaan widget layout seperti `Container`, `Padding`, `Row`, `Column`, dan `Expanded`, penggunaan `ListView.builder`, pembuatan data menggunakan `class` dan `object`, serta navigasi antar halaman menggunakan `Navigator`.

## Materi yang Dipelajari

### 1. Container

`Container` digunakan untuk membungkus widget dan mengatur ukuran, margin, padding, warna, serta dekorasi.

Contoh:

```dart
Container(
  margin: const EdgeInsets.all(10),
  padding: const EdgeInsets.all(16),
  child: const Text('Hello Flutter'),
)
```

`Container` dapat digunakan untuk membuat tampilan setiap bagian aplikasi menjadi lebih rapi.

### 2. Padding

`Padding` digunakan untuk memberikan jarak antara widget dengan bagian di sekitarnya.

Contoh:

```dart
Padding(
  padding: const EdgeInsets.all(16),
  child: const Text('Daftar Kontak'),
)
```

### 3. Row dan Column

`Row` digunakan untuk menyusun widget secara horizontal.

```dart
Row(
  children: [
    Icon(Icons.person),
    Text('Dudung'),
  ],
)
```

Sedangkan `Column` digunakan untuk menyusun widget secara vertikal.

```dart
Column(
  children: [
    Text('Nama'),
    Text('Nomor Telepon'),
    Text('Email'),
  ],
)
```

### 4. MainAxis dan CrossAxis

Pada `Row` dan `Column`, terdapat dua arah utama dalam mengatur posisi widget.

* `mainAxis` mengatur posisi pada arah utama.
* `crossAxis` mengatur posisi pada arah yang berlawanan dengan arah utama.

Contohnya, pada `Column`, `mainAxis` berjalan secara vertikal dan `crossAxis` secara horizontal.

### 5. Expanded

`Expanded` digunakan agar sebuah widget dapat menggunakan ruang yang tersedia.

Contoh:

```dart
Row(
  children: [
    Expanded(
      child: Text('Nama Kontak'),
    ),
    Icon(Icons.arrow_forward),
  ],
)
```

`Expanded` berguna untuk membantu mengatur pembagian ruang pada layout.

### 6. ListView.builder

`ListView.builder` digunakan untuk menampilkan data dalam bentuk daftar secara dinamis.

Contoh:

```dart
ListView.builder(
  itemCount: daftarKontak.length,
  itemBuilder: (context, index) {
    final item = daftarKontak[index];

    return ListTile(
      title: Text(item.nama),
    );
  },
)
```

`itemCount` menentukan jumlah data yang ditampilkan, sedangkan `itemBuilder` digunakan untuk membuat tampilan setiap item.

### 7. Class dan Object

Pada pertemuan ini data mulai dibuat menggunakan `class` dan `object`.

Contoh:

```dart
class Kontak {
  final String nama;
  final String nomorTelepon;
  final String email;

  const Kontak(
    this.nama,
    this.nomorTelepon,
    this.email,
  );
}
```

Kemudian dibuat object dari class tersebut:

```dart
const daftarKontak = [
  Kontak('Mery', '08123456789', 'mery@example.com'),
  Kontak('Budi', '08198765432', 'budi@example.com'),
];
```

Dengan menggunakan class, beberapa informasi yang masih berhubungan dapat dikelompokkan menjadi satu object.

### 8. Card dan ListTile

`Card` digunakan untuk membuat tampilan item menjadi seperti kartu, sedangkan `ListTile` mempermudah pembuatan item daftar yang memiliki beberapa bagian.

Contoh:

```dart
Card(
  child: ListTile(
    leading: const CircleAvatar(
      child: Text('M'),
    ),
    title: const Text('Mery'),
    subtitle: const Text('08123456789'),
    trailing: const Icon(Icons.chevron_right),
  ),
)
```

`ListTile` memiliki beberapa bagian seperti:

* `leading` untuk widget di sebelah kiri.
* `title` untuk judul.
* `subtitle` untuk informasi tambahan.
* `trailing` untuk widget di sebelah kanan.

### 9. Navigasi Antar Halaman

Untuk berpindah dari satu halaman ke halaman lainnya digunakan `Navigator`.

Contoh:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const DetailPage(),
  ),
);
```

`Navigator.push()` digunakan untuk membuka halaman baru.

Untuk kembali ke halaman sebelumnya digunakan:

```dart
Navigator.pop(context);
```

Alur sederhananya:

```text
Halaman Daftar
      ↓
Navigator.push()
      ↓
Halaman Detail
      ↓
Navigator.pop()
      ↓
Kembali ke Halaman Daftar
```

### 10. Mengirim Data ke Halaman Detail

Data dapat dikirim melalui constructor halaman.

Contoh:

```dart
DetailPage({
  required this.kontak,
});
```

Kemudian object kontak dikirim ketika melakukan navigasi:

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => DetailPage(
      kontak: item,
    ),
  ),
);
```

Dengan cara ini, halaman detail dapat menampilkan data dari kontak yang dipilih.

## Praktik yang Dikerjakan

Pada pertemuan ini dibuat aplikasi **Daftar Kontak**. Aplikasi menampilkan minimal enam kontak yang terdiri dari nama, nomor telepon, dan email.

Data kontak dibuat menggunakan `class Kontak` dan disimpan dalam sebuah `List`. Seluruh kontak kemudian ditampilkan menggunakan `ListView.builder` dan `ListTile`.

Setiap kontak memiliki avatar yang menampilkan huruf pertama dari nama kontak. Ketika salah satu kontak ditekan, aplikasi berpindah ke halaman detail dan menampilkan seluruh informasi kontak tersebut.

## Konsep Penting

Alur sederhana aplikasi yang dibuat pada Pertemuan 2 adalah:

```text
Class Kontak
     ↓
Object Kontak
     ↓
List<Kontak>
     ↓
ListView.builder
     ↓
ListTile
     ↓
User memilih kontak
     ↓
Navigator.push()
     ↓
Halaman Detail
```

Dari materi ini dapat dipahami bahwa data dan tampilan dapat dipisahkan menggunakan `class` dan `object`, kemudian data tersebut dapat ditampilkan secara dinamis menggunakan `ListView.builder`.

## Kesimpulan

Pada Pertemuan 2 dipelajari cara membuat layout yang lebih terstruktur, mengelola data menggunakan `class` dan `object`, menampilkan kumpulan data menggunakan `ListView.builder`, serta membuat navigasi antar halaman menggunakan `Navigator`. Materi tersebut diterapkan dalam pembuatan aplikasi Daftar Kontak yang memiliki halaman daftar dan halaman detail.
