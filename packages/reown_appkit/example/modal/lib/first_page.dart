import 'package:flutter/material.dart';
import 'package:reown_appkit_example/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:reown_appkit/reown_appkit.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({
    super.key,
    required this.toggleTheme,
    required this.toggleBrightness,
  });

  final VoidCallback toggleTheme;
  final VoidCallback toggleBrightness;

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  Future<List<Object>> _initDeps() async {
    final deps = await Future.wait([
      SharedPreferences.getInstance(),
      ReownCoreUtils.getPackageName(),
    ]);
    return deps;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Object>>(
          future: _initDeps(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return MyHomePage(
                          prefs: snapshot.data!.first as SharedPreferences,
                          bundleId: snapshot.data!.last as String,
                          toggleBrightness: widget.toggleBrightness,
                          toggleTheme: widget.toggleTheme,
                        );
                      },
                    ),
                  );
                },
                child: const Text('Go to home page'),
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
}
