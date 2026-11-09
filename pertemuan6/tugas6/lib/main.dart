import 'package:flutter/material.dart';

import 'models/teknologi.dart';
import 'pages/detail_page.dart';
import 'pages/not_found_page.dart';
import 'pages/shell_page.dart';
import 'services/theme_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final isDarkMode = await ThemeService.getDarkMode();

  final colorIndex = await ThemeService.getColorIndex();

  runApp(MyApp(initialDarkMode: isDarkMode, initialColorIndex: colorIndex));
}

class MyApp extends StatefulWidget {
  final bool initialDarkMode;

  final int initialColorIndex;

  const MyApp({
    super.key,
    required this.initialDarkMode,
    required this.initialColorIndex,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const List<Color> pilihanWarna = [
    Colors.indigo,
    Colors.teal,
    Colors.deepOrange,
    Colors.pink,
  ];

  late ThemeMode _themeMode;

  late int _colorIndex;

  @override
  void initState() {
    super.initState();

    _themeMode = widget.initialDarkMode ? ThemeMode.dark : ThemeMode.light;

    _colorIndex = widget.initialColorIndex;
  }

  ThemeData _buatTema(Color seed, Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: seed,
      brightness: brightness,
      appBarTheme: const AppBarTheme(centerTitle: true),
    );
  }

  Future<void> _ubahTemaGelap(bool value) async {
    setState(() {
      _themeMode = value ? ThemeMode.dark : ThemeMode.light;
    });

    await ThemeService.saveDarkMode(value);
  }

  Future<void> _ubahWarnaTema(int index) async {
    setState(() {
      _colorIndex = index;
    });

    await ThemeService.saveColorIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    final seedColor = pilihanWarna[_colorIndex];

    return MaterialApp(
      title: 'Katalog Teknologi',
      debugShowCheckedModeBanner: false,

      theme: _buatTema(seedColor, Brightness.light),

      darkTheme: _buatTema(seedColor, Brightness.dark),

      themeMode: _themeMode,

      initialRoute: '/',

      routes: {
        '/': (_) => ShellPage(
          isDarkMode: _themeMode == ThemeMode.dark,
          colorIndex: _colorIndex,
          pilihanWarna: pilihanWarna,
          onDarkModeChanged: _ubahTemaGelap,
          onColorChanged: _ubahWarnaTema,
        ),
      },

      onGenerateRoute: (settings) {
        if (settings.name == '/detail') {
          final teknologi = settings.arguments as Teknologi;

          return MaterialPageRoute(
            builder: (_) => DetailPage(teknologi: teknologi),
            settings: settings,
          );
        }

        return null;
      },

      onUnknownRoute: (_) {
        return MaterialPageRoute(builder: (_) => const NotFoundPage());
      },
    );
  }
}
