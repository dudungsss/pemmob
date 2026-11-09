import 'package:flutter/material.dart';

import '../state/pengaturan.dart';
import '../utils/format.dart';

class PengaturanPage extends StatefulWidget {
  const PengaturanPage({super.key});

  @override
  State<PengaturanPage> createState() => _PengaturanPageState();
}

class _PengaturanPageState extends State<PengaturanPage> {
  late double _targetSementara;

  @override
  void initState() {
    super.initState();

    _targetSementara = pengaturan.target.clamp(0, 100000).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;

    return AnimatedBuilder(
      animation: pengaturan,
      builder: (context, _) => ListView(
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 28),
        children: [
          Text(
            'Target tabungan harian',
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w800),
          ),

          const SizedBox(height: 8),

          Text(
            rupiah(_targetSementara.round()),
            style: Theme.of(context).textTheme.headlineMedium
                ?.copyWith(fontWeight: FontWeight.w800, color: warna.primary),
          ),

          const SizedBox(height: 14),

          Slider(
            value: _targetSementara,
            min: 0,
            max: 100000,
            divisions: 20,
            label: rupiah(_targetSementara.round()),
            onChanged: (value) {
              setState(() => _targetSementara = value);
            },
            onChangeEnd: (value) {
              pengaturan.ubahTarget(value.round());
            },
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Rp 0', style: Theme.of(context).textTheme.bodySmall),
              Text('Rp 100.000', style: Theme.of(context).textTheme.bodySmall),
            ],
          ),

          const SizedBox(height: 20),
          Divider(color: warna.outlineVariant),
          const SizedBox(height: 18),

          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Mode gelap',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            subtitle: const Text('Lebih nyaman dipakai saat malam'),
            value: pengaturan.modeGelap,
            onChanged: pengaturan.ubahModeGelap,
          ),

          const SizedBox(height: 24),

          Text(
            'Warna tema',
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w800),
          ),

          const SizedBox(height: 6),

          Text(
            'Pilih warna yang paling nyaman buat kamu.',
            style: Theme.of(context).textTheme.bodySmall,
          ),

          const SizedBox(height: 18),

          Wrap(
            spacing: 16,
            runSpacing: 12,
            children: List.generate(pengaturan.pilihanWarna.length, (index) {
              final dipilih = pengaturan.warna == index;

              return Tooltip(
                message: 'Warna tema ${index + 1}',
                child: InkWell(
                  onTap: () => pengaturan.ubahWarna(index),
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: pengaturan.pilihanWarna[index],
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: dipilih ? warna.onSurface : Colors.transparent,
                        width: 2.4,
                      ),
                    ),
                    child: dipilih
                        ? const Icon(Icons.check_rounded, color: Colors.white)
                        : null,
                  ),
                ),
              );
            }),
          ),

          const SizedBox(height: 32),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: warna.primaryContainer.withOpacity(0.45),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(Icons.lightbulb_outline_rounded, color: warna.primary),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Pengaturan ini akan tetap tersimpan meski aplikasi ditutup.',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
