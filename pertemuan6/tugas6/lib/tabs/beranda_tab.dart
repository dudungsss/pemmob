import 'package:flutter/material.dart';

import '../data/teknologi_data.dart';

class BerandaTab extends StatelessWidget {
  const BerandaTab({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final warna = tema.colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Katalog Teknologi', style: tema.textTheme.headlineSmall),
        const SizedBox(height: 4),
        Text(
          'Pilih teknologi untuk melihat detail.',
          style: tema.textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),

        for (final teknologi in daftarTeknologi)
          Card(
            child: ListTile(
              leading: Hero(
                tag: 'ikon-${teknologi.nama}',
                child: CircleAvatar(
                  backgroundColor: warna.primaryContainer,
                  child: Icon(teknologi.ikon, color: warna.onPrimaryContainer),
                ),
              ),
              title: Text(teknologi.nama),
              subtitle: Text(teknologi.kategori),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pushNamed(context, '/detail', arguments: teknologi);
              },
            ),
          ),
      ],
    );
  }
}
