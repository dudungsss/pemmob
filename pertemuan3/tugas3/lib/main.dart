import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BarangBelanja {
  final String nama;
  final int jumlah;
  final String kategori;
  bool sudahDibeli;

  BarangBelanja({
    required this.nama,
    required this.jumlah,
    required this.kategori,
    this.sudahDibeli = false,
  });
}

class BelanjaModel extends ChangeNotifier {
  final List<BarangBelanja> _items = [];

  List<BarangBelanja> get items => List.unmodifiable(_items);
  int get jumlahBelumDibeli => _items.where((b) => !b.sudahDibeli).length;

  void tambah(BarangBelanja barang) {
    _items.add(barang);
    notifyListeners();
  }

  void toggle(int index) {
    _items[index].sudahDibeli = !_items[index].sudahDibeli;
    notifyListeners();
  }

  void hapus(int index) {
    _items.removeAt(index);
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => BelanjaModel(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daftar Belanja',
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: const DaftarBelanjaPage(),
    );
  }
}

class DaftarBelanjaPage extends StatelessWidget {
  const DaftarBelanjaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<BelanjaModel>();

    return Scaffold(
      appBar: AppBar(title: Text('Belanja (${model.jumlahBelumDibeli} belum)')),
      body: model.items.isEmpty
          ? const Center(child: Text('Belum ada barang'))
          : ListView.builder(
              itemCount: model.items.length,
              itemBuilder: (context, i) {
                final b = model.items[i];
                return CheckboxListTile(
                  value: b.sudahDibeli,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    b.nama,
                    style: TextStyle(
                      decoration: b.sudahDibeli
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  subtitle: Text('${b.jumlah} × ${b.kategori}'),
                  secondary: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => context.read<BelanjaModel>().hapus(i),
                  ),
                  onChanged: (_) => context.read<BelanjaModel>().toggle(i),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FormBelanjaPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class FormBelanjaPage extends StatefulWidget {
  const FormBelanjaPage({super.key});

  @override
  State<FormBelanjaPage> createState() => _FormBelanjaPageState();
}

class _FormBelanjaPageState extends State<FormBelanjaPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _jumlahController = TextEditingController();
  String? _kategori;

  @override
  void dispose() {
    _namaController.dispose();
    _jumlahController.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;
    final barang = BarangBelanja(
      nama: _namaController.text.trim(),
      jumlah: int.parse(_jumlahController.text.trim()),
      kategori: _kategori!,
    );
    context.read<BelanjaModel>().tambah(barang);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Barang')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _namaController,
              decoration: const InputDecoration(
                labelText: 'Nama barang',
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Nama wajib diisi' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _jumlahController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Jumlah',
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Jumlah wajib diisi';
                final n = int.tryParse(v.trim());
                if (n == null || n <= 0) return 'Jumlah harus angka > 0';
                return null;
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Kategori',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Makanan', child: Text('Makanan')),
                DropdownMenuItem(value: 'Minuman', child: Text('Minuman')),
                DropdownMenuItem(
                  value: 'Kebutuhan',
                  child: Text('Kebutuhan Rumah'),
                ),
                DropdownMenuItem(value: 'Lainnya', child: Text('Lainnya')),
              ],
              onChanged: (v) => setState(() => _kategori = v),
              validator: (v) => v == null ? 'Pilih kategori' : null,
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _simpan, child: const Text('Simpan')),
          ],
        ),
      ),
    );
  }
}
