import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pengaturan extends ChangeNotifier {
  bool modeGelap = false;
  int warna = 0;
  int target = 20000;

  final List<Color> pilihanWarna = const [
    Color(0xFF00796B), // Teal
    Color(0xFF4054B8), // Biru
    Color(0xFFF26A3D), // Oranye
    Color(0xFFDF2469), // Merah muda
  ];

  Color get warnaUtama => pilihanWarna[warna];

  Future<void> muat() async {
    final prefs = await SharedPreferences.getInstance();

    modeGelap = prefs.getBool('modeGelap') ?? false;
    target = prefs.getInt('target') ?? 20000;

    final tersimpan = prefs.getInt('warna') ?? 0;

    warna = (tersimpan >= 0 && tersimpan < pilihanWarna.length) ? tersimpan : 0;

    notifyListeners();
  }

  Future<void> ubahModeGelap(bool nilai) async {
    modeGelap = nilai;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('modeGelap', nilai);
  }

  Future<void> ubahWarna(int nilai) async {
    if (nilai < 0 || nilai >= pilihanWarna.length) return;

    warna = nilai;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('warna', nilai);
  }

  Future<void> ubahTarget(int nilai) async {
    target = nilai;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('target', nilai);
  }
}

final pengaturan = Pengaturan();
