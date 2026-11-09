import 'package:flutter/material.dart';

class AnimasiTab extends StatefulWidget {
  const AnimasiTab({super.key});

  @override
  State<AnimasiTab> createState() => _AnimasiTabState();
}

class _AnimasiTabState extends State<AnimasiTab>
    with SingleTickerProviderStateMixin {
  bool _besar = false;

  bool _terlihat = true;

  int _hitung = 0;

  late final AnimationController _putar;

  @override
  void initState() {
    super.initState();

    _putar = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _putar.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final warna = tema.colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('1. AnimatedContainer', style: tema.textTheme.titleMedium),

        const SizedBox(height: 12),

        Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            width: _besar ? 220 : 110,
            height: 100,
            decoration: BoxDecoration(
              color: _besar ? warna.primary : warna.tertiary,
              borderRadius: BorderRadius.circular(_besar ? 50 : 8),
            ),
          ),
        ),

        TextButton(
          onPressed: () {
            setState(() {
              _besar = !_besar;
            });
          },
          child: const Text('Ubah bentuk'),
        ),

        const Divider(),

        Text('2. AnimatedSwitcher', style: tema.textTheme.titleMedium),

        const SizedBox(height: 12),

        Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: Text(
              '$_hitung',
              key: ValueKey(_hitung),
              style: tema.textTheme.displayMedium,
            ),
          ),
        ),

        TextButton(
          onPressed: () {
            setState(() {
              _hitung++;
            });
          },
          child: const Text('Tambah'),
        ),

        const Divider(),

        Text('3. AnimationController', style: tema.textTheme.titleMedium),

        const SizedBox(height: 12),

        Center(
          child: RotationTransition(
            turns: _putar,
            child: Icon(Icons.settings, size: 64, color: warna.primary),
          ),
        ),

        TextButton(
          onPressed: () {
            if (_putar.isAnimating) {
              _putar.stop();
            } else {
              _putar.repeat();
            }

            setState(() {});
          },
          child: Text(_putar.isAnimating ? 'Berhenti' : 'Putar'),
        ),

        const Divider(),

        Text('4. AnimatedOpacity', style: tema.textTheme.titleMedium),

        const SizedBox(height: 12),

        AnimatedOpacity(
          opacity: _terlihat ? 1 : 0,
          duration: const Duration(milliseconds: 500),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Text(
                  'Kartu animasi opacity',
                  style: tema.textTheme.titleMedium,
                ),
              ),
            ),
          ),
        ),

        TextButton(
          onPressed: () {
            setState(() {
              _terlihat = !_terlihat;
            });
          },
          child: Text(_terlihat ? 'Sembunyikan' : 'Tampilkan'),
        ),
      ],
    );
  }
}
