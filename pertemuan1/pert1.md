# Praktikum Flutter - Pertemuan 1

## Flutter Fundamental dan Widget Dasar

Pertemuan 1 merupakan pengenalan dasar pemrograman mobile menggunakan **Flutter**. Pada pertemuan ini dipelajari konsep dasar widget, struktur aplikasi Flutter, layout sederhana, serta pengelolaan state menggunakan `StatefulWidget` dan `setState()`.

## Materi yang Dipelajari

### 1. Struktur Dasar Aplikasi Flutter

Aplikasi Flutter memiliki fungsi utama:

```dart
void main() {
  runApp(const MyApp());
}
```

`main()` merupakan titik awal program, sedangkan `runApp()` digunakan untuk menjalankan widget utama aplikasi.

Struktur dasar aplikasi biasanya menggunakan `MaterialApp` sebagai pembungkus aplikasi.

### 2. MaterialApp

`MaterialApp` digunakan sebagai struktur utama aplikasi Flutter.

Contoh:

```dart
MaterialApp(
  title: 'Praktikum 1',
  home: const HomePage(),
)
```

Beberapa bagian yang dipelajari:

* `title` untuk menentukan judul aplikasi.
* `home` untuk menentukan halaman pertama yang ditampilkan.
* `theme` untuk mengatur tampilan dan tema aplikasi.

### 3. Scaffold

`Scaffold` digunakan sebagai struktur dasar sebuah halaman.

Contoh:

```dart
Scaffold(
  appBar: AppBar(
    title: const Text('Hello Flutter'),
  ),
  body: const Center(
    child: Text('Hello World'),
  ),
)
```

Bagian yang dipelajari antara lain:

* `appBar`
* `body`
* `floatingActionButton`

### 4. StatelessWidget

`StatelessWidget` digunakan untuk widget yang tampilannya tidak memiliki state yang berubah.

Contoh:

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
}
```

Widget ini cocok digunakan ketika tampilan tidak perlu berubah berdasarkan suatu data yang berubah.

### 5. StatefulWidget

`StatefulWidget` digunakan ketika sebuah halaman memiliki data yang dapat berubah.

Contohnya pada aplikasi counter:

```dart
class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}
```

Data yang dapat berubah disimpan pada class `State`.

### 6. setState()

`setState()` digunakan untuk memberi tahu Flutter bahwa state telah berubah sehingga tampilan perlu diperbarui.

Contoh:

```dart
setState(() {
  _count++;
});
```

Alurnya:

```text
State berubah
    ↓
setState()
    ↓
Flutter menjalankan build()
    ↓
UI diperbarui
```

### 7. Widget Layout Dasar

Beberapa widget layout yang dipelajari:

#### Column

Digunakan untuk menyusun widget secara vertikal.

```dart
Column(
  children: [
    Text('Nama'),
    Text('NIM'),
  ],
)
```

#### Row

Digunakan untuk menyusun widget secara horizontal.

```dart
Row(
  children: [
    Icon(Icons.remove),
    Icon(Icons.refresh),
    Icon(Icons.add),
  ],
)
```

#### Center

Digunakan untuk menempatkan widget di tengah.

```dart
Center(
  child: Text('Hello Flutter'),
)
```

### 8. Widget Tampilan Dasar

Widget dasar yang dipelajari antara lain:

```text
Text
Icon
SizedBox
```

`Text` digunakan untuk menampilkan teks.

`Icon` digunakan untuk menampilkan ikon.

`SizedBox` digunakan untuk memberikan jarak atau menentukan ukuran.

Contoh:

```dart
Column(
  children: [
    const Icon(Icons.person),
    const SizedBox(height: 16),
    const Text('Dudung'),
  ],
)
```

### 9. FloatingActionButton

`FloatingActionButton` digunakan untuk menyediakan tombol aksi utama pada halaman.

Contoh:

```dart
FloatingActionButton(
  onPressed: () {
    setState(() {
      _count++;
    });
  },
  child: const Icon(Icons.add),
)
```

`onPressed` menentukan aksi yang dilakukan ketika tombol ditekan.

## Praktik yang Dikerjakan

Pada pertemuan ini dibuat beberapa latihan Flutter dasar, salah satunya adalah aplikasi **Counter**.

Fitur yang dibuat:

* Menambah nilai.
* Mengurangi nilai.
* Mereset nilai.
* Mencegah nilai menjadi negatif.

Contoh logika untuk mencegah nilai negatif:

```dart
if (_count > 0) {
  _count--;
}
```

Selain itu dibuat juga aplikasi sederhana berupa **Kartu Perkenalan** yang menampilkan informasi seperti:

* Nama.
* NIM.
* Jurusan.
* Hobi.
* Ikon atau elemen visual.

Dalam pembuatan kartu tersebut digunakan `Column`, `Text`, `Icon`, dan `SizedBox`.

## Konsep Penting

Hal utama yang dipelajari pada Pertemuan 1 adalah bahwa tampilan aplikasi Flutter dibangun dari **widget**.

Contoh struktur sederhana:

```text
MaterialApp
    ↓
Scaffold
    ↓
Column
 ├── Text
 ├── Icon
 └── SizedBox
```

Ketika aplikasi memiliki data yang dapat berubah, digunakan:

```text
StatefulWidget
      ↓
    State
      ↓
  setState()
      ↓
  UI diperbarui
```

## Kesimpulan

Pertemuan 1 menjadi dasar untuk memahami bagaimana aplikasi Flutter dibangun. Materi yang dipelajari meliputi struktur dasar aplikasi, `MaterialApp`, `Scaffold`, `StatelessWidget`, `StatefulWidget`, `setState()`, serta widget layout dan tampilan dasar seperti `Column`, `Row`, `Center`, `Text`, `Icon`, dan `SizedBox`.

Pemahaman terhadap konsep-konsep dasar ini menjadi dasar untuk mempelajari materi Flutter berikutnya seperti `ListView`, navigasi antar halaman, form input, validasi, dan state management.
