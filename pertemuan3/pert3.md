# Praktikum Flutter - Pertemuan 3

## Form Input dan State Management

Pada Pertemuan 3, saya mempelajari cara menerima input dari pengguna dan mengelola data yang dapat berubah pada aplikasi Flutter. Materi yang dipelajari meliputi penggunaan `TextField`, `TextEditingController`, `Form`, `TextFormField`, validasi input, `DropdownButtonFormField`, dan `CheckboxListTile`. Selain itu, saya juga mempelajari konsep state management menggunakan `ChangeNotifier` dan `Provider`.

## Materi yang Dipelajari

### 1. TextField dan TextEditingController

`TextField` digunakan untuk menerima input berupa teks dari pengguna. Isi dari input dapat diambil menggunakan `TextEditingController`.

Contoh:

```dart
final _controller = TextEditingController();

TextField(
  controller: _controller,
)
```

Isi input dapat diambil menggunakan:

```dart
_controller.text
```

Controller juga perlu dihapus ketika halaman sudah tidak digunakan menggunakan `dispose()`.

```dart
@override
void dispose() {
  _controller.dispose();
  super.dispose();
}
```

### 2. Form dan Validasi

Untuk membuat beberapa input yang membutuhkan validasi digunakan `Form` dan `GlobalKey<FormState>`.

```dart
final _formKey = GlobalKey<FormState>();

Form(
  key: _formKey,
  child: ...
)
```

Validasi dijalankan menggunakan:

```dart
_formKey.currentState!.validate()
```

Pada setiap `TextFormField` dapat diberikan `validator` yang mengembalikan pesan error jika input tidak valid atau `null` jika input valid.

Contoh:

```dart
TextFormField(
  validator: (value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nama wajib diisi';
    }

    return null;
  },
)
```

### 3. Dropdown

`DropdownButtonFormField` digunakan untuk membuat pilihan dari beberapa data yang sudah ditentukan.

Contoh:

```dart
DropdownButtonFormField<String>(
  items: const [
    DropdownMenuItem(
      value: 'TI',
      child: Text('Teknik Informatika'),
    ),
    DropdownMenuItem(
      value: 'SI',
      child: Text('Sistem Informasi'),
    ),
  ],
  onChanged: (value) {
    setState(() {
      _jurusan = value;
    });
  },
)
```

Dropdown juga dapat diberikan validasi agar pengguna wajib memilih salah satu pilihan.

### 4. Checkbox

`CheckboxListTile` digunakan untuk membuat pilihan yang dapat dicentang atau tidak.

Contoh:

```dart
CheckboxListTile(
  title: const Text('Saya menyetujui ketentuan'),
  value: _setuju,
  onChanged: (value) {
    setState(() {
      _setuju = value ?? false;
    });
  },
)
```

Nilai checkbox dapat berupa `true` atau `false`.

### 5. StatefulWidget dan setState

Pada form sederhana, state seperti nilai dropdown atau checkbox dapat dikelola menggunakan `StatefulWidget` dan `setState()`.

```dart
setState(() {
  _setuju = true;
});
```

`setState()` digunakan untuk memberi tahu Flutter bahwa state berubah sehingga tampilan dapat diperbarui.

### 6. ChangeNotifier

Ketika data mulai digunakan oleh beberapa halaman atau widget, `setState()` pada satu halaman dapat menjadi kurang praktis. Untuk mengelola state bersama digunakan `ChangeNotifier`.

Contoh:

```dart
class TugasModel extends ChangeNotifier {
  final List<Tugas> _items = [];

  void tambah(String judul) {
    _items.add(Tugas(judul));
    notifyListeners();
  }
}
```

`notifyListeners()` digunakan untuk memberi tahu widget yang sedang mendengarkan bahwa data telah berubah.

### 7. Provider

`Provider` digunakan untuk membagikan object state seperti `ChangeNotifier` ke widget lain.

Contoh:

```dart
ChangeNotifierProvider(
  create: (_) => TugasModel(),
  child: const MyApp(),
)
```

Dengan Provider, beberapa halaman dapat menggunakan data yang sama tanpa harus mengoper data melalui banyak constructor atau callback.

### 8. context.watch dan context.read

`context.watch<T>()` digunakan untuk mengambil data sekaligus mendengarkan perubahan data.

```dart
final model = context.watch<TugasModel>();
```

Ketika data berubah dan `notifyListeners()` dipanggil, widget yang menggunakan `watch` dapat dibangun ulang.

Sedangkan `context.read<T>()` digunakan untuk mengambil model ketika ingin menjalankan suatu aksi, misalnya pada tombol.

```dart
context.read<TugasModel>().hapus(index);
```

Secara sederhana:

```text
context.watch()
    ↓
membaca data + mendengarkan perubahan

context.read()
    ↓
membaca data untuk menjalankan aksi
```

## Praktik yang Dikerjakan

Pada pertemuan ini dibuat aplikasi **Daftar Tugas** menggunakan `ChangeNotifier` dan `Provider`.

Aplikasi memiliki halaman daftar tugas yang dapat:

* Menampilkan tugas.
* Menandai tugas sebagai selesai.
* Mencoret tugas yang sudah selesai.
* Menghapus tugas.
* Menambahkan tugas melalui halaman terpisah.

Pada halaman tambah tugas digunakan `TextEditingController`, `Form`, dan `TextFormField` untuk menerima serta memvalidasi input.

## Latihan Mandiri

Beberapa pengembangan yang dilakukan pada aplikasi Daftar Tugas yaitu menambahkan validasi judul minimal 3 karakter, membuat fungsi untuk menghapus semua tugas yang sudah selesai, menampilkan `SnackBar` setelah tugas ditambahkan, serta menampilkan pesan ketika daftar tugas masih kosong.

## Konsep Penting

Alur state management pada aplikasi yang dibuat adalah:

```text
User
  ↓
Input / Action
  ↓
TugasModel
  ↓
notifyListeners()
  ↓
context.watch()
  ↓
UI diperbarui
```

Sedangkan untuk menjalankan aksi dari widget digunakan:

```text
Button / Checkbox
        ↓
context.read()
        ↓
Method pada TugasModel
```

## Kesimpulan

Pada Pertemuan 3 saya mempelajari cara membuat form input dan melakukan validasi data pada Flutter. Selain itu, saya memahami perbedaan antara state lokal menggunakan `setState()` dan state yang digunakan bersama oleh beberapa halaman menggunakan `ChangeNotifier` dan `Provider`. Saya juga mempelajari penggunaan `context.watch()` untuk mengamati perubahan state dan `context.read()` untuk menjalankan aksi terhadap state.
