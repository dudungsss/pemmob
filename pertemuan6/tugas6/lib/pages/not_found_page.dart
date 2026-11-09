import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('404')),
      body: Center(
        child: Text(
          '404 - Halaman tidak ditemukan',
          style: tema.textTheme.headlineSmall,
        ),
      ),
    );
  }
}
