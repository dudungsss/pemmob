import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/db_helper.dart';
import '../models/kegiatan.dart';
import '../state/pengaturan.dart';
import '../utils/format.dart';
import '../utils/ui_style.dart';
import '../widgets/ringkasan_card.dart';

class LaporanPage extends StatefulWidget {
  const LaporanPage({super.key});

  @override
  State<LaporanPage> createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {
  DateTime _tanggal = DateTime.now();

  late Future<Ringkasan> _ringkasan;
  late Future<Map<String, int>> _kategori;
  late Future<List<MapEntry<DateTime, Ringkasan>>> _tujuhHari;

  @override
  void initState() {
    super.initState();

    _ringkasan = DbHelper.ringkasan(tanggalKey(_tanggal));

    _kategori = DbHelper.pengeluaranPerKategori(tanggalKey(_tanggal));

    _tujuhHari = _ambilTujuhHari(_tanggal);

    versiData.addListener(_muat);
  }

  @override
  void dispose() {
    versiData.removeListener(_muat);
    super.dispose();
  }

  void _muat() {
    if (!mounted) return;

    setState(() {
      final tanggal = tanggalKey(_tanggal);

      _ringkasan = DbHelper.ringkasan(tanggal);

      _kategori = DbHelper.pengeluaranPerKategori(tanggal);

      _tujuhHari = _ambilTujuhHari(_tanggal);
    });
  }

  Future<List<MapEntry<DateTime, Ringkasan>>> _ambilTujuhHari(
    DateTime akhir,
  ) async {
    final hasil = <MapEntry<DateTime, Ringkasan>>[];

    for (var i = 0; i < 7; i++) {
      final tanggal = DateTime(akhir.year, akhir.month, akhir.day - i);

      final data = await DbHelper.ringkasan(tanggalKey(tanggal));

      hasil.add(MapEntry(tanggal, data));
    }

    return hasil;
  }

  void _geserHari(int delta) {
    final baru = DateTime(_tanggal.year, _tanggal.month, _tanggal.day + delta);

    if (baru.isBefore(DateTime(2020)) || baru.isAfter(DateTime(2100, 12, 31))) {
      return;
    }

    _tanggal = baru;
    _muat();
  }

  Future<void> _pilihTanggal() async {
    final pilihan = await showDatePicker(
      context: context,
      initialDate: _tanggal,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100, 12, 31),
    );

    if (pilihan == null || !mounted) return;

    _tanggal = pilihan;
    _muat();
  }

  Future<void> _salinLaporan() async {
    try {
      final ringkasan = await _ringkasan;
      final kategori = await _kategori;

      final laporan = StringBuffer()
        ..writeln('LAPORAN TABUNGKU')
        ..writeln(formatTanggal(_tanggal))
        ..writeln('Kegiatan: ${ringkasan.selesai}/${ringkasan.jumlahKegiatan}')
        ..writeln('Pemasukan: ${rupiah(ringkasan.pemasukan)}')
        ..writeln('Pengeluaran: ${rupiah(ringkasan.pengeluaran)}')
        ..writeln('Tabungan: ${rupiah(ringkasan.tabungan)}')
        ..writeln('Pengeluaran per kategori:');

      if (kategori.isEmpty) {
        laporan.writeln('Tidak ada pengeluaran');
      }

      for (final item in kategori.entries) {
        laporan.writeln('${item.key}: ${rupiah(item.value)}');
      }

      await Clipboard.setData(ClipboardData(text: laporan.toString()));

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Laporan berhasil disalin!')),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal menyalin laporan: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pengaturan,
      builder: (context, _) => ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 26),
        children: [
          Row(
            children: [
              IconButton(
                tooltip: 'Hari sebelumnya',
                onPressed: () => _geserHari(-1),
                icon: const Icon(Icons.chevron_left_rounded),
              ),

              Expanded(
                child: TextButton.icon(
                  onPressed: _pilihTanggal,
                  icon: const Icon(Icons.calendar_month_rounded),
                  label: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      formatTanggal(_tanggal),
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),

              IconButton(
                tooltip: 'Hari berikutnya',
                onPressed: () => _geserHari(1),
                icon: const Icon(Icons.chevron_right_rounded),
              ),
            ],
          ),

          const SizedBox(height: 14),

          FutureBuilder<Ringkasan>(
            future: _ringkasan,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return _pesan('Gagal memuat ringkasan: ${snapshot.error}');
              }

              if (!snapshot.hasData) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              return RingkasanCard(
                ringkasan: snapshot.data!,
                target: pengaturan.target,
                judul: 'Ringkasan harian',
              );
            },
          ),

          const SizedBox(height: 26),

          _judulBagian('Pengeluaran per kategori'),

          const SizedBox(height: 14),

          FutureBuilder<Map<String, int>>(
            future: _kategori,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return _pesan('Gagal memuat kategori: ${snapshot.error}');
              }

              if (!snapshot.hasData) {
                return const LinearProgressIndicator();
              }

              final kategori = snapshot.data!;

              if (kategori.isEmpty) {
                return _pesan('Belum ada pengeluaran pada tanggal ini.');
              }

              final terbesar = kategori.values.reduce((a, b) => a > b ? a : b);

              return Column(
                children: kategori.entries.map((item) {
                  final porsi = terbesar == 0 ? 0.0 : item.value / terbesar;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 17),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              item.key,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              rupiah(item.value),
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: LinearProgressIndicator(
                            minHeight: 8,
                            value: porsi,
                            color: Theme.of(context).colorScheme.primary,
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.13),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),

          const SizedBox(height: 16),

          _judulBagian('7 hari sampai tanggal ini'),

          const SizedBox(height: 14),

          FutureBuilder<List<MapEntry<DateTime, Ringkasan>>>(
            future: _tujuhHari,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return _pesan('Gagal memuat 7 hari: ${snapshot.error}');
              }

              if (!snapshot.hasData) {
                return const LinearProgressIndicator();
              }

              final hari = snapshot.data!;

              final total = hari.fold<int>(
                0,
                (sum, item) => sum + item.value.tabungan,
              );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 15,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer
                          .withOpacity(0.45),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Total tabungan 7 hari',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        Text(
                          rupiah(total),
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: total < 0
                                ? UiStyle.merah(context)
                                : UiStyle.hijau(context),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  ...hari.map((item) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 9),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  formatTanggal(item.key),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${item.value.jumlahKegiatan} kegiatan · '
                                  'Masuk ${rupiah(item.value.pemasukan)} · '
                                  'Keluar ${rupiah(item.value.pengeluaran)}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 8),

                          Text(
                            rupiah(item.value.tabungan),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: item.value.tabungan < 0
                                  ? UiStyle.merah(context)
                                  : UiStyle.hijau(context),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              );
            },
          ),

          const SizedBox(height: 18),

          SizedBox(
            height: 50,
            child: OutlinedButton.icon(
              onPressed: _salinLaporan,
              icon: const Icon(Icons.copy_all_rounded),
              label: const Text('Salin laporan ke Clipboard'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _judulBagian(String label) {
    return Text(
      label,
      style: Theme.of(context).textTheme.titleMedium
          ?.copyWith(fontWeight: FontWeight.w800),
    );
  }

  Widget _pesan(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
