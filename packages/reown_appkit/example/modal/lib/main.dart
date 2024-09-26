import 'package:flutter/material.dart';
import 'package:reown_appkit_example/home_page.dart';
import 'package:reown_appkit_example/services/deep_link_handler.dart';
import 'package:reown_appkit_example/utils/constants.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DeepLinkHandler.initListener();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  bool _isDarkMode = false;
  ReownAppKitModalThemeData? _themeData;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        final platformDispatcher = View.of(context).platformDispatcher;
        final platformBrightness = platformDispatcher.platformBrightness;
        _isDarkMode = platformBrightness == Brightness.dark;
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    if (mounted) {
      setState(() {
        final platformDispatcher = View.of(context).platformDispatcher;
        final platformBrightness = platformDispatcher.platformBrightness;
        _isDarkMode = platformBrightness == Brightness.dark;
      });
    }
    super.didChangePlatformBrightness();
  }

  Future<List<Object>> _initDeps() async {
    final deps = await Future.wait([
      SharedPreferences.getInstance(),
      ReownCoreUtils.getPackageName(),
    ]);
    return deps;
  }

  @override
  Widget build(BuildContext context) {
    return ReownAppKitModalTheme(
      isDarkMode: _isDarkMode,
      themeData: _themeData,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: StringConstants.pageTitle,
        home: FutureBuilder<List<Object>>(
          future: _initDeps(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MyHomePage(
                prefs: snapshot.data!.first as SharedPreferences,
                bundleId: snapshot.data!.last as String,
                toggleTheme: () => _toggleTheme(),
                toggleBrightness: () => _toggleBrightness(),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  void _toggleTheme() => setState(() {
        _themeData = (_themeData == null) ? _customTheme : null;
      });

  void _toggleBrightness() => setState(() {
        _isDarkMode = !_isDarkMode;
      });

  ReownAppKitModalThemeData get _customTheme => ReownAppKitModalThemeData(
        lightColors: ReownAppKitModalColors.lightMode.copyWith(
          accent100: const Color.fromARGB(255, 30, 59, 236),
          background100: const Color.fromARGB(255, 161, 183, 231),
          // Main Modal's background color
          background125: const Color.fromARGB(255, 206, 221, 255),
          background175: const Color.fromARGB(255, 237, 241, 255),
          inverse100: const Color.fromARGB(255, 233, 237, 236),
          inverse000: const Color.fromARGB(255, 22, 18, 19),
          // Main Modal's text
          foreground100: const Color.fromARGB(255, 22, 18, 19),
          // Secondary Modal's text
          foreground150: const Color.fromARGB(255, 22, 18, 19),
        ),
        darkColors: ReownAppKitModalColors.darkMode.copyWith(
          accent100: const Color.fromARGB(255, 161, 183, 231),
          background100: const Color.fromARGB(255, 30, 59, 236),
          // Main Modal's background color
          background125: const Color.fromARGB(255, 12, 23, 99),
          background175: const Color.fromARGB(255, 78, 103, 230),
          inverse100: const Color.fromARGB(255, 22, 18, 19),
          inverse000: const Color.fromARGB(255, 233, 237, 236),
          // Main Modal's text
          foreground100: const Color.fromARGB(255, 233, 237, 236),
          // Secondary Modal's text
          foreground150: const Color.fromARGB(255, 233, 237, 236),
        ),
        radiuses: ReownAppKitModalRadiuses.square,
      );
}
