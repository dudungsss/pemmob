import 'package:flutter/material.dart';

import '../models/kegiatan.dart';
import '../utils/format.dart';
import '../utils/ui_style.dart';

class RingkasanCard extends StatelessWidget {
  final Ringkasan ringkasan;
  final int target;
  final String judul;

  const RingkasanCard({
    super.key,
    required this.ringkasan,
    required this.target,
    this.judul = 'Ringkasan hari ini',
  });

  @override
  Widget build(BuildContext context) {
    final warnaTema = Theme.of(context).colorScheme.primary;
    final tabungan = ringkasan.tabungan;

    final capaian = target > 0
        ? (tabungan / target).clamp(0.0, 1.0).toDouble()
        : 0.0;

    final berhasil = target > 0 && tabungan >= target;

    String pesan;

    if (tabungan < 0) {
      pesan = 'Pengeluaran melebihi pemasukan. Yuk, atur lagi pengeluaranmu.';
    } else if (target <= 0) {
      pesan = 'Atur target tabungan harian di halaman Pengaturan.';
    } else if (berhasil) {
      pesan =
          'Target ${rupiah(target)} tercapai! Pertahankan kebiasaan baikmu.';
    } else {
      pesan = 'Terkumpul ${rupiah(tabungan)} dari target ${rupiah(target)}.';
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              judul,
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),

            const SizedBox(height: 22),

            Row(
              children: [
                Expanded(
                  child: _Angka(
                    icon: Icons.checklist_rounded,
                    angka: '${ringkasan.selesai}/${ringkasan.jumlahKegiatan}',
                    label: 'Kegiatan',
                    warna: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Expanded(
                  child: _Angka(
                    icon: Icons.south_rounded,
                    angka: rupiah(ringkasan.pemasukan),
                    label: 'Pemasukan',
                    warna: UiStyle.hijau(context),
                  ),
                ),
                Expanded(
                  child: _Angka(
                    icon: Icons.north_rounded,
                    angka: rupiah(ringkasan.pengeluaran),
                    label: 'Pengeluaran',
                    warna: UiStyle.merah(context),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),
            Divider(color: UiStyle.garis(context)),
            const SizedBox(height: 10),

            Row(
              children: [
                const Text('Tabungan', style: TextStyle(fontSize: 15)),
                const Spacer(),
                Flexible(
                  child: Text(
                    rupiah(tabungan),
                    textAlign: TextAlign.end,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w800,
                      color: tabungan < 0
                          ? UiStyle.merah(context)
                          : UiStyle.hijau(context),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: capaian),
              duration: const Duration(milliseconds: 550),
              curve: Curves.easeOutCubic,
              builder: (context, nilai, _) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: LinearProgressIndicator(
                    value: nilai,
                    minHeight: 9,
                    backgroundColor: warnaTema.withOpacity(0.13),
                    valueColor: AlwaysStoppedAnimation<Color>(warnaTema),
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  tabungan < 0
                      ? Icons.info_outline_rounded
                      : berhasil
                      ? Icons.verified_rounded
                      : Icons.savings_outlined,
                  size: 17,
                  color: tabungan < 0 ? UiStyle.merah(context) : warnaTema,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    pesan,
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(height: 1.4),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Angka extends StatelessWidget {
  final IconData icon;
  final String angka;
  final String label;
  final Color warna;

  const _Angka({
    required this.icon,
    required this.angka,
    required this.label,
    required this.warna,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: warna, size: 27),
        const SizedBox(height: 8),
        SizedBox(
          height: 24,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              angka,
              style: TextStyle(
                color: warna,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
