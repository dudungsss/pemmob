import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeMode = ValueNotifier<ThemeMode>(ThemeMode.light);
final seedColor = ValueNotifier<Color>(Colors.indigo);

const pilihanWarna = [
  Colors.indigo,
  Colors.teal,
  Colors.deepOrange,
  Colors.pink,
];

ThemeData buatTema(Color seed, Brightness brightness) {
  return ThemeData(
    useMaterial3: true,
    colorSchemeSeed: seed,
    brightness: brightness,
    appBarTheme: const AppBarTheme(centerTitle: true),
  );
}

Future<void> muatTema() async {
  final prefs = await SharedPreferences.getInstance();
  final mode = prefs.getString('themeMode') ?? 'light';
  final idx = prefs.getInt('seedIndex') ?? 0;
  themeMode.value = mode == 'dark' ? ThemeMode.dark : ThemeMode.light;
  seedColor.value = pilihanWarna[idx.clamp(0, pilihanWarna.length - 1)];
}

Future<void> simpanTema() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(
    'themeMode',
    themeMode.value == ThemeMode.dark ? 'dark' : 'light',
  );
  final index = pilihanWarna.indexWhere((warna) => warna == seedColor);

  await prefs.setInt('seedIndex', index < 0 ? 0 : index);
}
