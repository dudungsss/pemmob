import 'package:flutter/material.dart';

import 'pages/detail_produk_page.dart';
import 'pages/shell_page.dart';
import 'models/produk.dart';
import 'theme/theme_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await muatTema();
  themeMode.addListener(simpanTema);
  seedColor.addListener(simpanTema);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([themeMode, seedColor]),
      builder: (context, _) {
        return MaterialApp(
          title: 'Katalog Produk',
          debugShowCheckedModeBanner: false,
          theme: buatTema(seedColor.value, Brightness.light),
          darkTheme: buatTema(seedColor.value, Brightness.dark),
          themeMode: themeMode.value,
          initialRoute: '/',
          routes: {'/': (_) => const ShellPage()},
          onGenerateRoute: (settings) {
            if (settings.name == '/detail') {
              final produk = settings.arguments as Produk;
              return MaterialPageRoute(
                builder: (_) => DetailProdukPage(produk: produk),
                settings: settings,
              );
            }
            return null;
          },
        );
      },
    );
  }
}
