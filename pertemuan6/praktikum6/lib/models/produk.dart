import 'package:flutter/material.dart';

class Produk {
  final String id;
  final String nama;
  final String kategori;
  final int harga;
  final String deskripsi;
  final IconData ikon;
  final Color warna;

  const Produk({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.deskripsi,
    required this.ikon,
    required this.warna,
  });
}

const daftarProduk = [
  Produk(
    id: 'p1',
    nama: 'Kopi Susu Gula Aren',
    kategori: 'Minuman',
    harga: 22000,
    deskripsi: 'Kopi susu dengan gula aren asli dan espresso double shot.',
    ikon: Icons.local_cafe,
    warna: Color(0xFF6D4C41),
  ),
  Produk(
    id: 'p2',
    nama: 'Matcha Latte',
    kategori: 'Minuman',
    harga: 28000,
    deskripsi: 'Matcha premium Jepang dengan susu segar, tanpa gula tambahan.',
    ikon: Icons.emoji_food_beverage,
    warna: Color(0xFF388E3C),
  ),
  Produk(
    id: 'p3',
    nama: 'Croissant Butter',
    kategori: 'Roti',
    harga: 18000,
    deskripsi: 'Croissant butter Prancis, renyah di luar lembut di dalam.',
    ikon: Icons.bakery_dining,
    warna: Color(0xFFF57C00),
  ),
  Produk(
    id: 'p4',
    nama: 'Cheese Cake Slice',
    kategori: 'Kue',
    harga: 32000,
    deskripsi: 'Cheese cake creamy dengan base biskuit dan topping blueberry.',
    ikon: Icons.cake,
    warna: Color(0xFFD81B60),
  ),
  Produk(
    id: 'p5',
    nama: 'Teh Melati',
    kategori: 'Minuman',
    harga: 12000,
    deskripsi: 'Teh melati wangi, cocok diminum hangat maupun dingin.',
    ikon: Icons.emoji_food_beverage,
    warna: Color(0xFF00897B),
  ),
  Produk(
    id: 'p6',
    nama: 'Roti Bakar Srikaya',
    kategori: 'Roti',
    harga: 15000,
    deskripsi: 'Roti bakar dengan selai srikaya homemade, aroma pandan.',
    ikon: Icons.bakery_dining,
    warna: Color(0xFF8D6E63),
  ),
];
