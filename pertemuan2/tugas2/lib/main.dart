import 'package:flutter/material.dart';

class Makanan {
  final String nama;
  final int harga;
  final String deskripsi;

  const Makanan(this.nama, this.harga, this.deskripsi);
}

const daftarMenu = [
  Makanan('Nasi Goreng', 15000, 'Nasi goreng spesial dengan telur dan ayam.'),
  Makanan('Mie Ayam', 12000, 'Mie ayam dengan topping ayam kecap.'),
  Makanan('Es Teh', 4000, 'Es teh manis segar, cocok untuk cuaca panas.'),
  Makanan('Ayam Bakar', 20000, 'Ayam bakar dengan sambal kecap pedas manis.'),
  Makanan('Sate Ayam', 18000, 'Sate ayam 10 tusuk dengan bumbu kacang.'),
  Makanan('Bakso Sapi', 13000, 'Bakso sapi kenyal dengan kuah kaldu hangat.'),
];

class Kontak {
  final String nama;
  final String telepon;
  final String email;

  const Kontak(this.nama, this.telepon, this.email);
}

const daftarKontak = [
  Kontak('Andi Pratama', '0812-1111-2222', 'andi.pratama@example.com'),
  Kontak('Bunga Lestari', '0813-3333-4444', 'bunga.lestari@example.com'),
  Kontak('Candra Wijaya', '0857-5555-6666', 'candra.wijaya@example.com'),
  Kontak('Dewi Anggraini', '0821-7777-8888', 'dewi.anggraini@example.com'),
  Kontak('Eko Saputra', '0819-9999-0000', 'eko.saputra@example.com'),
  Kontak('Fitri Handayani', '0838-1212-3434', 'fitri.handayani@example.com'),
];

String formatRupiah(int nilai) {
  final s = nilai.toString();
  final buf = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    final sisa = s.length - i;
    buf.write(s[i]);
    if (sisa > 1 && sisa % 3 == 1) buf.write('.');
  }
  return 'Rp ${buf.toString()}';
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Praktikum 2 - Daftar Kontak',
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: const KontakListPage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 32,
                child: Icon(Icons.person, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      '[NAMA]',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('[NIM]'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Menu')),
      body: ListView.builder(
        itemCount: daftarMenu.length,
        itemBuilder: (context, index) {
          final item = daftarMenu[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.restaurant),
                title: Text(item.nama),
                subtitle: Text(formatRupiah(item.harga)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(makanan: item),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final Makanan makanan;

  const DetailPage({super.key, required this.makanan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(makanan.nama)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.restaurant_menu, size: 80),
            const SizedBox(height: 16),
            Text(makanan.nama, style: const TextStyle(fontSize: 24)),
            Text(formatRupiah(makanan.harga)),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(makanan.deskripsi, textAlign: TextAlign.center),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}

class KontakListPage extends StatelessWidget {
  const KontakListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Kontak')),
      body: ListView.builder(
        itemCount: daftarKontak.length,
        itemBuilder: (context, index) {
          final k = daftarKontak[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: CircleAvatar(child: Text(k.nama[0].toUpperCase())),
              title: Text(k.nama),
              subtitle: Text(k.telepon),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KontakDetailPage(kontak: k),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class KontakDetailPage extends StatelessWidget {
  final Kontak kontak;

  const KontakDetailPage({super.key, required this.kontak});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(kontak.nama)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 40,
                child: Text(
                  kontak.nama[0].toUpperCase(),
                  style: const TextStyle(fontSize: 32),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _barisInfo('Nama', kontak.nama),
            _barisInfo('Telepon', kontak.telepon),
            _barisInfo('Email', kontak.email),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Kembali'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _barisInfo(String label, String nilai) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(nilai, style: const TextStyle(fontSize: 16)),
          const Divider(),
        ],
      ),
    );
  }
}
