import 'package:flutter/material.dart';

class PengaturanTab extends StatelessWidget {
  final bool isDarkMode;

  final int colorIndex;

  final List<Color> pilihanWarna;

  final ValueChanged<bool> onDarkModeChanged;

  final ValueChanged<int> onColorChanged;

  const PengaturanTab({
    super.key,
    required this.isDarkMode,
    required this.colorIndex,
    required this.pilihanWarna,
    required this.onDarkModeChanged,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SwitchListTile(
          title: const Text('Mode gelap'),
          subtitle: const Text(
            'Tema tetap tersimpan setelah aplikasi ditutup.',
          ),
          value: isDarkMode,
          onChanged: onDarkModeChanged,
        ),

        const SizedBox(height: 16),

        Text('Warna tema', style: tema.textTheme.titleMedium),

        const SizedBox(height: 12),

        Wrap(
          spacing: 12,
          children: [
            for (int i = 0; i < pilihanWarna.length; i++)
              GestureDetector(
                onTap: () {
                  onColorChanged(i);
                },
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: pilihanWarna[i],
                  child: colorIndex == i
                      ? const Icon(Icons.check, color: Colors.white)
                      : null,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
