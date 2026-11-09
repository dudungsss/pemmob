import 'package:flutter/material.dart';

import '../models/teknologi.dart';

const daftarTeknologi = [
  Teknologi(
    nama: 'Flutter',
    kategori: 'Mobile Framework',
    deskripsi: 'Flutter adalah framework untuk membangun aplikasi multiplatform menggunakan bahasa Dart. Flutter dapat digunakan untuk membuat aplikasi Android, iOS, web, dan desktop dari satu basis kode.',
    ikon: Icons.flutter_dash,
  ),
  Teknologi(
    nama: 'Laravel',
    kategori: 'Backend Framework',
    deskripsi: 'Laravel adalah framework PHP yang digunakan untuk membangun aplikasi web dan REST API. Laravel menyediakan routing, ORM, authentication, migration, dan berbagai fitur backend lainnya.',
    ikon: Icons.web,
  ),
  Teknologi(
    nama: 'PostgreSQL',
    kategori: 'Database',
    deskripsi: 'PostgreSQL adalah relational database management system yang mendukung SQL, transaksi, relasi antar tabel, constraint, dan berbagai fitur database lainnya.',
    ikon: Icons.storage,
  ),
  Teknologi(
    nama: 'Git',
    kategori: 'Version Control',
    deskripsi: 'Git adalah version control system yang digunakan untuk mencatat perubahan kode, membuat branch, melakukan merge, dan bekerja secara kolaboratif dalam pengembangan perangkat lunak.',
    ikon: Icons.account_tree,
  ),
];
