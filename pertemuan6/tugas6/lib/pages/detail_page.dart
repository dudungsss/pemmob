import 'package:flutter/material.dart';

import '../models/teknologi.dart';

class DetailPage extends StatelessWidget {
  final Teknologi teknologi;

  const DetailPage({super.key, required this.teknologi});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final warna = tema.colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(teknologi.nama)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Hero(
              tag: 'ikon-${teknologi.nama}',
              child: CircleAvatar(
                radius: 64,
                backgroundColor: warna.primaryContainer,
                child: Icon(
                  teknologi.ikon,
                  size: 64,
                  color: warna.onPrimaryContainer,
                ),
              ),
            ),

            const SizedBox(height: 24),

            Text(teknologi.nama, style: tema.textTheme.headlineMedium),

            const SizedBox(height: 8),

            Text(teknologi.kategori, style: tema.textTheme.titleMedium),

            const SizedBox(height: 24),

            Text(
              teknologi.deskripsi,
              style: tema.textTheme.bodyLarge,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
