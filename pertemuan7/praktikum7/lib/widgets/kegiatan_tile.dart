import 'package:flutter/material.dart';

import '../models/kegiatan.dart';
import '../utils/format.dart';
import '../utils/ui_style.dart';

class KegiatanTile extends StatelessWidget {
  final Kegiatan kegiatan;
  final ValueChanged<bool?> onSelesai;
  final VoidCallback onEdit;
  final VoidCallback onHapus;

  const KegiatanTile({
    super.key,
    required this.kegiatan,
    required this.onSelesai,
    required this.onEdit,
    required this.onHapus,
  });

  @override
  Widget build(BuildContext context) {
    final nominal = switch (kegiatan.tipe) {
      Tipe.pemasukan => '+${rupiah(kegiatan.nominal)}',
      Tipe.pengeluaran => '-${rupiah(kegiatan.nominal)}',
      Tipe.tanpa => '',
    };

    final warna = switch (kegiatan.tipe) {
      Tipe.pemasukan => UiStyle.hijau(context),
      Tipe.pengeluaran => UiStyle.merah(context),
      Tipe.tanpa => Theme.of(context).colorScheme.onSurfaceVariant,
    };

    final kategori = kegiatan.tipe == Tipe.tanpa
        ? 'Tanpa uang'
        : kegiatan.tipe == Tipe.pemasukan
        ? 'Pemasukan'
        : kegiatan.kategori;

    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Material(
        color: UiStyle.permukaan(context),
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onEdit,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 11),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: UiStyle.garis(context)),
            ),
            child: Row(
              children: [
                Checkbox(
                  value: kegiatan.selesai,
                  onChanged: onSelesai,
                  visualDensity: VisualDensity.compact,
                ),
                const SizedBox(width: 3),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        kegiatan.judul,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          decoration: kegiatan.selesai
                              ? TextDecoration.lineThrough
                              : null,
                          color: kegiatan.selesai
                              ? Theme.of(context).colorScheme.onSurfaceVariant
                              : null,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        kategori,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),

                if (nominal.isNotEmpty) ...[
                  const SizedBox(width: 7),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 100),
                    child: Text(
                      nominal,
                      textAlign: TextAlign.end,
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                        color: warna,
                      ),
                    ),
                  ),
                ],

                PopupMenuButton<String>(
                  tooltip: 'Aksi kegiatan',
                  icon: const Icon(Icons.more_vert_rounded, size: 21),
                  onSelected: (pilihan) {
                    if (pilihan == 'edit') onEdit();
                    if (pilihan == 'hapus') onHapus();
                  },
                  itemBuilder: (_) => const [
                    PopupMenuItem(value: 'edit', child: Text('Ubah kegiatan')),
                    PopupMenuItem(
                      value: 'hapus',
                      child: Text('Hapus kegiatan'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
