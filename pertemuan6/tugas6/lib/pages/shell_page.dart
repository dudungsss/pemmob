import 'package:flutter/material.dart';

import '../tabs/animasi_tab.dart';
import '../tabs/beranda_tab.dart';
import '../tabs/pengaturan_tab.dart';

class ShellPage extends StatefulWidget {
  final bool isDarkMode;

  final int colorIndex;

  final List<Color> pilihanWarna;

  final ValueChanged<bool> onDarkModeChanged;

  final ValueChanged<int> onColorChanged;

  const ShellPage({
    super.key,
    required this.isDarkMode,
    required this.colorIndex,
    required this.pilihanWarna,
    required this.onDarkModeChanged,
    required this.onColorChanged,
  });

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final halaman = [
      const BerandaTab(),
      const AnimasiTab(),
      PengaturanTab(
        isDarkMode: widget.isDarkMode,
        colorIndex: widget.colorIndex,
        pilihanWarna: widget.pilihanWarna,
        onDarkModeChanged: widget.onDarkModeChanged,
        onColorChanged: widget.onColorChanged,
      ),
    ];

    const judul = ['Beranda', 'Animasi', 'Pengaturan'];

    return Scaffold(
      appBar: AppBar(title: Text(judul[_index])),

      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                child: Center(
                  child: Text(
                    'Katalog Teknologi',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),

              ListTile(
                leading: const Icon(Icons.home_outlined),
                title: const Text('Beranda'),
                onTap: () {
                  setState(() {
                    _index = 0;
                  });

                  Navigator.pop(context);
                },
              ),

              ListTile(
                leading: const Icon(Icons.animation),
                title: const Text('Animasi'),
                onTap: () {
                  setState(() {
                    _index = 1;
                  });

                  Navigator.pop(context);
                },
              ),

              ListTile(
                leading: const Icon(Icons.settings_outlined),
                title: const Text('Pengaturan'),
                onTap: () {
                  setState(() {
                    _index = 2;
                  });

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),

      body: IndexedStack(index: _index, children: halaman),

      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (index) {
          setState(() {
            _index = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),

          NavigationDestination(icon: Icon(Icons.animation), label: 'Animasi'),

          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}
