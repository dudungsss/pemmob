import 'package:flutter/material.dart';

import '../models/produk.dart';

class BerandaTab extends StatelessWidget {
  const BerandaTab({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final unggulan = daftarProduk.take(3).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Halo!', style: tema.textTheme.headlineSmall),
        const SizedBox(height: 4),
        Text(
          'Produk unggulan hari ini',
          style: tema.textTheme.bodyMedium?.copyWith(
            color: tema.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        for (final p in unggulan)
          Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Hero(
                tag: 'produk-${p.id}',
                child: CircleAvatar(
                  backgroundColor: p.warna,
                  child: Icon(p.ikon, color: Colors.white),
                ),
              ),
              title: Text(p.nama),
              subtitle: Text(p.kategori),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pushNamed(context, '/detail', arguments: p);
              },
            ),
          ),
      ],
    );
  }
}
