import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/kegiatan.dart';

final ValueNotifier<int> versiData = ValueNotifier<int>(0);

class DbHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;

    final lokasi = join(await getDatabasesPath(), 'tabungku.db');

    _db = await openDatabase(
      lokasi,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE kegiatan (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            judul TEXT NOT NULL,
            tanggal TEXT NOT NULL,
            selesai INTEGER NOT NULL DEFAULT 0,
            tipe TEXT NOT NULL,
            nominal INTEGER NOT NULL DEFAULT 0,
            kategori TEXT NOT NULL DEFAULT '-'
          )
        ''');
      },
    );

    return _db!;
  }

  static Future<int> tambah(Kegiatan kegiatan) async {
    final db = await database;

    final id = await db.insert('kegiatan', kegiatan.toMap());

    versiData.value++;
    return id;
  }

  static Future<int> ubah(Kegiatan kegiatan) async {
    final db = await database;

    final hasil = await db.update(
      'kegiatan',
      kegiatan.toMap(),
      where: 'id = ?',
      whereArgs: [kegiatan.id],
    );

    versiData.value++;
    return hasil;
  }

  static Future<int> hapus(int id) async {
    final db = await database;

    final hasil = await db.delete('kegiatan', where: 'id = ?', whereArgs: [id]);

    versiData.value++;
    return hasil;
  }

  static Future<List<Kegiatan>> pada(String tanggal) async {
    final db = await database;

    final hasil = await db.query(
      'kegiatan',
      where: 'tanggal = ?',
      whereArgs: [tanggal],
      orderBy: 'id DESC',
    );

    return hasil.map(Kegiatan.fromMap).toList();
  }

  static Future<Ringkasan> ringkasan(String tanggal) async {
    final db = await database;

    final hasil = await db.rawQuery(
      '''
      SELECT
        COUNT(*) AS jumlah,
        COALESCE(SUM(selesai), 0) AS selesai,
        COALESCE(SUM(
          CASE WHEN tipe = 'pemasukan'
          THEN nominal ELSE 0 END
        ), 0) AS masuk,
        COALESCE(SUM(
          CASE WHEN tipe = 'pengeluaran'
          THEN nominal ELSE 0 END
        ), 0) AS keluar
      FROM kegiatan
      WHERE tanggal = ?
    ''',
      [tanggal],
    );

    final data = hasil.first;

    return Ringkasan(
      jumlahKegiatan: data['jumlah'] as int,
      selesai: data['selesai'] as int,
      pemasukan: data['masuk'] as int,
      pengeluaran: data['keluar'] as int,
    );
  }

  static Future<Map<String, int>> pengeluaranPerKategori(String tanggal) async {
    final db = await database;

    final hasil = await db.rawQuery(
      '''
      SELECT kategori, SUM(nominal) AS total
      FROM kegiatan
      WHERE tanggal = ? AND tipe = 'pengeluaran'
      GROUP BY kategori
      ORDER BY total DESC
    ''',
      [tanggal],
    );

    return {
      for (final baris in hasil)
        baris['kategori'] as String: baris['total'] as int,
    };
  }
}
