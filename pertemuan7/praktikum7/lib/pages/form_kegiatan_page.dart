import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/db_helper.dart';
import '../models/kegiatan.dart';
import '../utils/format.dart';

class FormKegiatanPage extends StatefulWidget {
  final Kegiatan? kegiatan;

  const FormKegiatanPage({super.key, this.kegiatan});

  @override
  State<FormKegiatanPage> createState() => _FormKegiatanPageState();
}

class _FormKegiatanPageState extends State<FormKegiatanPage> {
  final _form = GlobalKey<FormState>();
  final _judul = TextEditingController();
  final _nominal = TextEditingController();

  final _kategoriList = const [
    'Makan',
    'Transport',
    'Belajar',
    'Hiburan',
    'Lainnya',
  ];

  late DateTime _tanggal;

  Tipe _tipe = Tipe.tanpa;
  String _kategori = 'Makan';
  bool _menyimpan = false;

  @override
  void initState() {
    super.initState();

    final kegiatan = widget.kegiatan;

    _tanggal = kegiatan == null
        ? DateTime.now()
        : DateTime.parse(kegiatan.tanggal);

    if (kegiatan != null) {
      _judul.text = kegiatan.judul;

      _nominal.text = kegiatan.nominal == 0 ? '' : kegiatan.nominal.toString();

      _tipe = kegiatan.tipe;

      if (_kategoriList.contains(kegiatan.kategori)) {
        _kategori = kegiatan.kategori;
      }
    }
  }

  @override
  void dispose() {
    _judul.dispose();
    _nominal.dispose();
    super.dispose();
  }

  Future<void> _pilihTanggal() async {
    final tanggal = await showDatePicker(
      context: context,
      initialDate: _tanggal,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100, 12, 31),
    );

    if (tanggal != null && mounted) {
      setState(() => _tanggal = tanggal);
    }
  }

  Future<void> _simpan() async {
    if (!_form.currentState!.validate()) return;

    setState(() => _menyimpan = true);

    final kegiatan = Kegiatan(
      id: widget.kegiatan?.id,
      judul: _judul.text.trim(),
      tanggal: tanggalKey(_tanggal),
      selesai: widget.kegiatan?.selesai ?? false,
      tipe: _tipe,
      nominal: _tipe == Tipe.tanpa ? 0 : int.parse(_nominal.text.trim()),
      kategori: _tipe == Tipe.pengeluaran ? _kategori : '-',
    );

    try {
      if (widget.kegiatan == null) {
        await DbHelper.tambah(kegiatan);
      } else {
        await DbHelper.ubah(kegiatan);
      }

      if (!mounted) return;
      Navigator.pop(context);
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan kegiatan: $error')),
      );

      setState(() => _menyimpan = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final edit = widget.kegiatan != null;
    final warna = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(edit ? 'Ubah Kegiatan' : 'Kegiatan Baru')),

      body: Form(
        key: _form,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 30),
          children: [
            Text(
              'Detail kegiatan',
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 5),
            Text(
              'Isi informasi kegiatan yang ingin dicatat.',
              style: Theme.of(context).textTheme.bodySmall,
            ),

            const SizedBox(height: 18),

            TextFormField(
              controller: _judul,
              textCapitalization: TextCapitalization.sentences,
              maxLength: 100,
              decoration: const InputDecoration(
                labelText: 'Nama kegiatan',
                hintText: 'Contoh: Beli makan siang',
                prefixIcon: Icon(Icons.edit_note_rounded),
              ),
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return 'Nama kegiatan wajib diisi';
                }
                return null;
              },
            ),

            const SizedBox(height: 12),

            Material(
              color: warna.surface,
              borderRadius: BorderRadius.circular(14),
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: _pilihTanggal,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: warna.outlineVariant),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_month_rounded, color: warna.primary),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tanggal kegiatan',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              formatTanggal(_tanggal),
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right_rounded),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'Apakah kegiatan ini melibatkan uang?',
              style: Theme.of(context).textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),

            const SizedBox(height: 12),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SegmentedButton<Tipe>(
                showSelectedIcon: false,
                segments: const [
                  ButtonSegment(value: Tipe.tanpa, label: Text('Tidak')),
                  ButtonSegment(
                    value: Tipe.pemasukan,
                    label: Text('Pemasukan'),
                  ),
                  ButtonSegment(
                    value: Tipe.pengeluaran,
                    label: Text('Pengeluaran'),
                  ),
                ],
                selected: {_tipe},
                onSelectionChanged: (nilai) {
                  setState(() => _tipe = nilai.first);
                },
              ),
            ),

            if (_tipe != Tipe.tanpa) ...[
              const SizedBox(height: 22),
              TextFormField(
                controller: _nominal,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Nominal (Rp)',
                  hintText: 'Contoh: 15000',
                  prefixIcon: Icon(Icons.payments_outlined),
                ),
                validator: (text) {
                  if (_tipe == Tipe.tanpa) return null;

                  final nilai = int.tryParse(text?.trim() ?? '');

                  if (nilai == null || nilai <= 0) {
                    return 'Isi nominal berupa angka lebih dari 0';
                  }

                  return null;
                },
              ),
            ],

            if (_tipe == Tipe.pengeluaran) ...[
              const SizedBox(height: 24),
              Text(
                'Kategori pengeluaran',
                style: Theme.of(context).textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.w800),
              ),

              const SizedBox(height: 12),

              Wrap(
                spacing: 9,
                runSpacing: 8,
                children: _kategoriList.map((kategori) {
                  return ChoiceChip(
                    label: Text(kategori),
                    selected: kategori == _kategori,
                    onSelected: (_) {
                      setState(() => _kategori = kategori);
                    },
                  );
                }).toList(),
              ),
            ],

            const SizedBox(height: 20),

            Text(
              'Tip: kegiatan yang belum selesai tetap dihitung dalam laporan.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),

      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 14),
          child: SizedBox(
            height: 52,
            child: FilledButton.icon(
              onPressed: _menyimpan ? null : _simpan,
              icon: Icon(
                _menyimpan ? Icons.hourglass_top_rounded : Icons.check_rounded,
              ),
              label: Text(_menyimpan ? 'Menyimpan...' : 'Simpan Kegiatan'),
            ),
          ),
        ),
      ),
    );
  }
}
