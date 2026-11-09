import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/db_pengeluaran.dart';
import '../models/pengeluaran.dart';
import 'pengeluaran_form_page.dart';

class PengeluaranListPage extends StatefulWidget {
  const PengeluaranListPage({super.key});

  @override
  State<PengeluaranListPage> createState() => _PengeluaranListPageState();
}

class _PengeluaranListPageState extends State<PengeluaranListPage> {
  late Future<List<Pengeluaran>> _future;
  int _total = 0;
  bool _gelap = false;

  @override
  void initState() {
    super.initState();
    _muatPreferensi();
    _muat();
  }

  Future<void> _muatPreferensi() async {
    final prefs = await SharedPreferences.getInstance();
    final g = prefs.getBool('gelap') ?? false;
    if (!mounted) return;
    setState(() => _gelap = g);
  }

  Future<void> _ubahTema(bool v) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('gelap', v);
    if (!mounted) return;
    setState(() => _gelap = v);
  }

  void _muat() {
    setState(() {
      _future = DbPengeluaran.semua();
      DbPengeluaran.total().then((t) {
        if (!mounted) return;
        setState(() => _total = t);
      });
    });
  }

  Future<void> _buka([Pengeluaran? p]) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PengeluaranFormPage(pengeluaran: p)),
    );
    if (!mounted) return;
    _muat();
  }

  String _formatRupiah(int n) {
    final s = n.toString();
    final b = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final sisa = s.length - i;
      b.write(s[i]);
      if (sisa > 1 && sisa % 3 == 1) b.write('.');
    }
    return 'Rp ${b.toString()}';
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: _gelap ? Brightness.dark : Brightness.light,
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pengeluaran'),
          actions: [
            IconButton(
              icon: Icon(_gelap ? Icons.light_mode : Icons.dark_mode),
              onPressed: () => _ubahTema(!_gelap),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Pengeluaran',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatRupiah(_total),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Pengeluaran>>(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Galat: ${snapshot.error}'));
                  }
                  final data = snapshot.data ?? [];
                  if (data.isEmpty) {
                    return const Center(child: Text('Belum ada pengeluaran'));
                  }
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, i) {
                      final p = data[i];
                      return ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.receipt_long),
                        ),
                        title: Text(p.nama),
                        subtitle: Text('${p.tanggal} · ${p.kategori}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _formatRupiah(p.jumlah),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                final ok = await showDialog<bool>(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text('Hapus pengeluaran?'),
                                    content: Text(p.nama),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                        child: const Text('Batal'),
                                      ),
                                      FilledButton(
                                        onPressed: () =>
                                            Navigator.pop(context, true),
                                        child: const Text('Hapus'),
                                      ),
                                    ],
                                  ),
                                );
                                if (ok != true) return;
                                await DbPengeluaran.hapus(p.id!);
                                if (!mounted) return;
                                _muat();
                              },
                            ),
                          ],
                        ),
                        onTap: () => _buka(p),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _buka(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
