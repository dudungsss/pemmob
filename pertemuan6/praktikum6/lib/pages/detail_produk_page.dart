import 'package:flutter/material.dart';

import '../models/produk.dart';

class DetailProdukPage extends StatefulWidget {
  final Produk produk;

  const DetailProdukPage({super.key, required this.produk});

  @override
  State<DetailProdukPage> createState() => _DetailProdukPageState();
}

class _DetailProdukPageState extends State<DetailProdukPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
    final tema = Theme.of(context);
    final p = widget.produk;

    return Scaffold(
      appBar: AppBar(
        title: Text(p.nama),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: RotationTransition(
              turns: _controller,
              child: Icon(Icons.star, color: tema.colorScheme.primary),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Center(
            child: Hero(
              tag: 'produk-${p.id}',
              child: CircleAvatar(
                radius: 80,
                backgroundColor: p.warna,
                child: Icon(p.ikon, size: 80, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Center(child: Text(p.nama, style: tema.textTheme.headlineSmall)),
          const SizedBox(height: 8),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: tema.colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                p.kategori,
                style: tema.textTheme.labelLarge?.copyWith(
                  color: tema.colorScheme.onSecondaryContainer,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              _formatRupiah(p.harga),
              style: tema.textTheme.titleLarge?.copyWith(
                color: tema.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('Deskripsi', style: tema.textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(p.deskripsi, style: tema.textTheme.bodyLarge),
        ],
      ),
    );
  }
}
