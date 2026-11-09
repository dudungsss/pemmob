import 'package:flutter/material.dart';

void main() {
  runApp(const TabungKuApp());
}

class TabungKuApp extends StatelessWidget {
  const TabungKuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RingkasanPage(),
    );
  }
}

class RingkasanPage extends StatelessWidget {
  const RingkasanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar halaman ringkasan tabungan.
      appBar: AppBar(
        title: const Text('Ringkasan Tabungan'),
        centerTitle: true,
      ),

      // SingleChildScrollView digunakan agar layout tidak overflow
      // ketika ditampilkan pada layar yang lebih kecil.
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),

          // Column utama untuk menyusun seluruh isi halaman secara vertikal.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // =========================
              // KARTU RINGKASAN TABUNGAN
              // =========================
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),

                  // Column untuk menyusun informasi tabungan.
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tabungan Laptop Baru',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Row untuk menampilkan saldo dan target berdampingan.
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Saldo'),
                                SizedBox(height: 4),
                                Text(
                                  'Rp 2.500.000',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('Target'),
                                SizedBox(height: 4),
                                Text(
                                  'Rp 5.000.000',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // =========================
              // MENU KATEGORI
              // =========================

              // Row untuk menyusun tiga menu secara horizontal.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Expanded membuat setiap menu mendapat ruang yang sama.
                  Expanded(
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.savings),
                        ),
                        const Text('Menabung'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.money_off),
                        ),
                        const Text('Tarik'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.history),
                        ),
                        const Text('Riwayat'),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // =========================
              // DAFTAR TRANSAKSI
              // =========================
              const Text(
                'Transaksi Terakhir',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              // Item transaksi pertama.
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.add_circle_outline),
                      const SizedBox(width: 12),

                      // Expanded mencegah teks mendorong nominal keluar layar.
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Menabung',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text('05 November 2026'),
                          ],
                        ),
                      ),

                      const Text(
                        '+ Rp 500.000',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),

              // Item transaksi kedua.
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.remove_circle_outline),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tarik Tabungan',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text('03 November 2026'),
                          ],
                        ),
                      ),
                      const Text(
                        '- Rp 100.000',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),

              // Item transaksi ketiga.
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.add_circle_outline),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Menabung',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text('01 November 2026'),
                          ],
                        ),
                      ),
                      const Text(
                        '+ Rp 250.000',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
