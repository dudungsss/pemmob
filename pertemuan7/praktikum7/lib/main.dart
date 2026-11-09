import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'models/kegiatan.dart';
import 'pages/form_kegiatan_page.dart';
import 'pages/shell_page.dart';
import 'state/pengaturan.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID');
  await pengaturan.muat();
  runApp(const TabungKuApp());
}

class TabungKuApp extends StatelessWidget {
  const TabungKuApp({super.key});

  ThemeData _tema(Brightness brightness) {
    final gelap = brightness == Brightness.dark;

    final scheme = ColorScheme.fromSeed(
      seedColor: pengaturan.warnaUtama,
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: gelap
          ? const Color(0xFF101715)
          : const Color(0xFFF5FAF8),
      appBarTheme: AppBarTheme(
        backgroundColor: gelap
            ? const Color(0xFF101715)
            : const Color(0xFFF5FAF8),
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: scheme.onSurface,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),
      cardTheme: CardThemeData(
        color: scheme.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: BorderSide(color: scheme.outlineVariant.withOpacity(0.4)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: scheme.primary, width: 1.8),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pengaturan,
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TabungKu',
        theme: _tema(Brightness.light),
        darkTheme: _tema(Brightness.dark),
        themeMode: pengaturan.modeGelap ? ThemeMode.dark : ThemeMode.light,
        home: const ShellPage(),
        onGenerateRoute: (settings) {
          if (settings.name == '/form') {
            final data = settings.arguments;

            return MaterialPageRoute<void>(
              builder: (_) =>
                  FormKegiatanPage(kegiatan: data is Kegiatan ? data : null),
            );
          }
          return null;
        },
      ),
    );
  }
}
