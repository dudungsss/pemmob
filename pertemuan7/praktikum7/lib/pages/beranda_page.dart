import 'package:flutter/material.dart';

import '../data/db_helper.dart';
import '../models/kegiatan.dart';
import '../state/pengaturan.dart';
import '../utils/format.dart';
import '../widgets/kegiatan_tile.dart';
import '../widgets/ringkasan_card.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  late Future<List<Kegiatan>> _kegiatan;
  late Future<Ringkasan> _ringkasan;

  String _cari = '';
  Tipe? _filter;

  String get _hariIni => tanggalKey(DateTime.now());

  @override
  void initState() {
    super.initState();

    _kegiatan = DbHelper.pada(_hariIni);
    _ringkasan = DbHelper.ringkasan(_hariIni);

    versiData.addListener(_muat);
  }

  void _muat() {
    if (!mounted) return;

    setState(() {
      _kegiatan = DbHelper.pada(_hariIni);
      _ringkasan = DbHelper.ringkasan(_hariIni);
    });
  }

  @override
  void dispose() {
    versiData.removeListener(_muat);
    super.dispose();
  }

  Future<void> _hapus(Kegiatan kegiatan) async {
    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus kegiatan?'),
        content: Text('"${kegiatan.judul}" akan dihapus.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (konfirmasi != true || kegiatan.id == null) return;

    try {
      await DbHelper.hapus(kegiatan.id!);
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Gagal menghapus: $error')));
    }
  }

  Widget _pilihanFilter(String teks, Tipe? tipe) {
    return Padding(
      padding: const EdgeInsets.only(right: 7),
      child: ChoiceChip(
        label: Text(teks),
        selected: _filter == tipe,
        onSelected: (_) {
          setState(() => _filter = tipe);
        },
        showCheckmark: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pengaturan,
      builder: (context, _) => Scaffold(
        body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 110),
          children: [
            Text(
              formatTanggal(DateTime.now()),
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            Text(
              'Kelola kegiatan dan uangmu dalam satu tempat.',
              style: Theme.of(context).textTheme.bodySmall,
            ),

            const SizedBox(height: 18),

            FutureBuilder<Ringkasan>(
              future: _ringkasan,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return _pesan('Gagal memuat ringkasan: ${snapshot.error}');
                }

                if (!snapshot.hasData) {
                  return const Padding(
                    padding: EdgeInsets.all(34),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                return RingkasanCard(
                  ringkasan: snapshot.data!,
                  target: pengaturan.target,
                );
              },
            ),

            const SizedBox(height: 26),

            Row(
              children: [
                Text(
                  'Daftar kegiatan',
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
                const Spacer(),
                Text(
                  'Ketuk untuk edit',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),

            const SizedBox(height: 13),

            TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search_rounded),
                hintText: 'Cari nama kegiatan...',
                isDense: true,
              ),
              onChanged: (value) {
                setState(() => _cari = value);
              },
            ),

            const SizedBox(height: 8),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _pilihanFilter('Semua', null),
                  _pilihanFilter('Pemasukan', Tipe.pemasukan),
                  _pilihanFilter('Pengeluaran', Tipe.pengeluaran),
                  _pilihanFilter('Tanpa uang', Tipe.tanpa),
                ],
              ),
            ),

            const SizedBox(height: 13),

            FutureBuilder<List<Kegiatan>>(
              future: _kegiatan,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return _pesan('Gagal memuat kegiatan: ${snapshot.error}');
                }

                if (!snapshot.hasData) {
                  return const Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final daftar = snapshot.data!.where((k) {
                  final cocokNama = k.judul.toLowerCase().contains(
                    _cari.toLowerCase().trim(),
                  );

                  final cocokTipe = _filter == null || k.tipe == _filter;

                  return cocokNama && cocokTipe;
                }).toList();

                if (daftar.isEmpty) {
                  return _pesan(
                    snapshot.data!.isEmpty
                        ? 'Belum ada kegiatan hari ini. Yuk, mulai tambah kegiatan!'
                        : 'Tidak ada kegiatan yang cocok dengan pencarian.',
                  );
                }

                return Column(
                  children: daftar.map((kegiatan) {
                    return KegiatanTile(
                      key: ValueKey(kegiatan.id),
                      kegiatan: kegiatan,

                      onSelesai: (nilai) async {
                        try {
                          await DbHelper.ubah(
                            kegiatan.copyWith(selesai: nilai ?? false),
                          );
                        } catch (error) {
                          if (!mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Gagal mengubah: $error')),
                          );
                        }
                      },

                      onEdit: () {
                        Navigator.pushNamed(
                          context,
                          '/form',
                          arguments: kegiatan,
                        );
                      },

                      onHapus: () => _hapus(kegiatan),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),

        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, '/form');
          },
          icon: const Icon(Icons.add_rounded),
          label: const Text('Kegiatan'),
        ),
      ),
    );
  }

  Widget _pesan(String pesan) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 12),
      child: Center(
        child: Text(
          pesan,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
