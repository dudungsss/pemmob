import 'package:flutter/material.dart';

import '../models/produk.dart';

class KatalogTab extends StatefulWidget {
  const KatalogTab({super.key});

  @override
  State<KatalogTab> createState() => _KatalogTabState();
}

class _KatalogTabState extends State<KatalogTab> {
  String _filter = 'Semua';
  final Set<String> _favorit = {};

  static const _kategori = ['Semua', 'Minuman', 'Roti', 'Kue'];

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
    final tema = Theme.of(context);
    final data = _filter == 'Semua'
        ? daftarProduk
        : daftarProduk.where((p) => p.kategori == _filter).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _kategori.map((k) {
                final dipilih = k == _filter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(k),
                    selected: dipilih,
                    onSelected: (_) => setState(() => _filter = k),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemCount: data.length,
            itemBuilder: (context, i) {
              final p = data[i];
              final fav = _favorit.contains(p.id);
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: tema.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(fav ? 24 : 12),
                  border: Border.all(
                    color: fav
                        ? tema.colorScheme.primary
                        : tema.colorScheme.outlineVariant,
                    width: fav ? 3 : 1,
                  ),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(fav ? 24 : 12),
                  onTap: () {
                    Navigator.pushNamed(context, '/detail', arguments: p);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Hero(
                              tag: 'produk-${p.id}',
                              child: CircleAvatar(
                                backgroundColor: p.warna,
                                child: Icon(p.ikon, color: Colors.white),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                fav ? Icons.favorite : Icons.favorite_border,
                                color: fav
                                    ? tema.colorScheme.primary
                                    : tema.colorScheme.onSurfaceVariant,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (fav) {
                                    _favorit.remove(p.id);
                                  } else {
                                    _favorit.add(p.id);
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          p.nama,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: tema.textTheme.titleSmall,
                        ),
                        const Spacer(),
                        Text(
                          p.kategori,
                          style: tema.textTheme.labelSmall?.copyWith(
                            color: tema.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _formatRupiah(p.harga),
                          style: tema.textTheme.titleSmall?.copyWith(
                            color: tema.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
