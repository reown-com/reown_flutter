// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:reown_appkit/reown_appkit.dart';

import 'package:reown_appkit/version.dart' as apkt_v;

import 'package:reown_sign/version.dart' as sign_v;
import 'package:reown_core/version.dart' as core_v;

class DebugDrawer extends StatefulWidget {
  const DebugDrawer({
    super.key,
    required this.toggleOverlay,
    required this.toggleBrightness,
    required this.toggleTheme,
    required this.appKitModal,
  });
  final VoidCallback toggleOverlay;
  final VoidCallback toggleBrightness;
  final VoidCallback toggleTheme;
  final ReownAppKitModal appKitModal;

  @override
  State<DebugDrawer> createState() => _DebugDrawerState();
}

class _DebugDrawerState extends State<DebugDrawer> with WidgetsBindingObserver {
  late SharedPreferences prefs;
  bool _analyticsValue = false;
  bool _emailWalletValue = false;
  bool _siweAuthValue = false;
  bool _analyticsValueBkp = false;
  bool _emailWalletValueBkp = false;
  bool _siweAuthValueBkp = false;
  bool _hasUpdates = false;

  @override
  void didChangePlatformBrightness() {
    if (mounted) {
      setState(() {});
    }
    super.didChangePlatformBrightness();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SharedPreferences.getInstance().then((instance) {
        setState(() {
          prefs = instance;
          _analyticsValue = prefs.getBool('appkit_analytics') ?? true;
          _analyticsValueBkp = _analyticsValue;
          _emailWalletValue = prefs.getBool('appkit_email_wallet') ?? true;
          _emailWalletValueBkp = _emailWalletValue;
          _siweAuthValue = prefs.getBool('appkit_siwe_auth') ?? true;
          _siweAuthValueBkp = _siweAuthValue;
        });
      });
    });
  }

  void _updateValue(String key, bool value) async {
    await prefs.setBool(key, value);
    _hasUpdates = true;
    setState(() {});
  }

  Future<void> _restore() async {
    await prefs.setBool('appkit_analytics', _analyticsValueBkp);
    await prefs.setBool('appkit_email_wallet', _emailWalletValueBkp);
    await prefs.setBool('appkit_siwe_auth', _siweAuthValueBkp);
  }

  @override
  Widget build(BuildContext context) {
    final isCustom = ReownAppKitModalTheme.isCustomTheme(context);
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.logo_dev_rounded,
                    color:
                        ReownAppKitModalTheme.colorsOf(context).foreground100,
                  ),
                  title: const Text('Analytics view'),
                  titleTextStyle: TextStyle(
                    color:
                        ReownAppKitModalTheme.colorsOf(context).foreground100,
                  ),
                  onTap: () {
                    widget.toggleOverlay();
                  },
                ),
                ListTile(
                  leading: isCustom
                      ? Icon(
                          Icons.yard,
                          color: ReownAppKitModalTheme.colorsOf(context)
                              .foreground100,
                        )
                      : Icon(
                          Icons.yard_outlined,
                          color: ReownAppKitModalTheme.colorsOf(context)
                              .foreground100,
                        ),
                  title: isCustom
                      ? const Text('Custom theme')
                      : const Text('Default theme'),
                  titleTextStyle: TextStyle(
                    color:
                        ReownAppKitModalTheme.colorsOf(context).foreground100,
                  ),
                  trailing: Switch(
                    value: isCustom,
                    activeColor:
                        ReownAppKitModalTheme.colorsOf(context).accent100,
                    onChanged: (value) {
                      widget.toggleTheme();
                    },
                  ),
                ),
                ListTile(
                  leading: ReownAppKitModalTheme.maybeOf(context)?.isDarkMode ??
                          false
                      ? Icon(
                          Icons.dark_mode_outlined,
                          color: ReownAppKitModalTheme.colorsOf(context)
                              .foreground100,
                        )
                      : Icon(
                          Icons.light_mode_outlined,
                          color: ReownAppKitModalTheme.colorsOf(context)
                              .foreground100,
                        ),
                  title: ReownAppKitModalTheme.maybeOf(context)?.isDarkMode ??
                          false
                      ? const Text('Dark theme')
                      : const Text('Light theme'),
                  titleTextStyle: TextStyle(
                    color:
                        ReownAppKitModalTheme.colorsOf(context).foreground100,
                  ),
                  trailing: Switch(
                    value: ReownAppKitModalTheme.maybeOf(context)?.isDarkMode ??
                        false,
                    activeColor:
                        ReownAppKitModalTheme.colorsOf(context).accent100,
                    onChanged: (value) {
                      widget.toggleBrightness();
                    },
                  ),
                ),
                const SizedBox.square(dimension: 10.0),
                const Divider(height: 1.0, indent: 12.0, endIndent: 12.0),
                const SizedBox.square(dimension: 10.0),
                Center(
                  child: Text(
                    'Will require app to restart',
                    style: TextStyle(
                      color:
                          ReownAppKitModalTheme.colorsOf(context).foreground100,
                    ),
                  ),
                ),
                const SizedBox.square(dimension: 10.0),
                ListTile(
                  leading: Icon(
                    Icons.speaker_notes_rounded,
                    color:
                        ReownAppKitModalTheme.colorsOf(context).foreground100,
                  ),
                  title: const Text('Analytics'),
                  titleTextStyle: TextStyle(
                    color:
                        ReownAppKitModalTheme.colorsOf(context).foreground100,
                  ),
                  trailing: Switch(
                    value: _analyticsValue,
                    activeColor:
                        ReownAppKitModalTheme.colorsOf(context).accent100,
                    onChanged: (value) {
                      _analyticsValue = value;
                      _updateValue('appkit_analytics', value);
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.email_rounded,
                    color:
                        ReownAppKitModalTheme.colorsOf(context).foreground100,
                  ),
                  title: const Text('Email & Socials'),
                  titleTextStyle: TextStyle(
                    color:
                        ReownAppKitModalTheme.colorsOf(context).foreground100,
                  ),
                  trailing: Switch(
                    value: _emailWalletValue,
                    activeColor:
                        ReownAppKitModalTheme.colorsOf(context).accent100,
                    onChanged: (value) {
                      _emailWalletValue = value;
                      _updateValue('appkit_email_wallet', value);
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.account_balance_wallet,
                    color:
                        ReownAppKitModalTheme.colorsOf(context).foreground100,
                  ),
                  title: const Text('1-CA + SIWE'),
                  titleTextStyle: TextStyle(
                    color:
                        ReownAppKitModalTheme.colorsOf(context).foreground100,
                  ),
                  trailing: Switch(
                    value: _siweAuthValue,
                    activeColor:
                        ReownAppKitModalTheme.colorsOf(context).accent100,
                    onChanged: (value) {
                      _siweAuthValue = value;
                      _updateValue('appkit_siwe_auth', value);
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Redirect:',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Native: ',
                      style: TextStyle(fontSize: 12.0),
                    ),
                    Expanded(
                      child: Text(
                        '${widget.appKitModal.appKit!.metadata.redirect?.native}',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: ReownAppKitModalTheme.colorsOf(context)
                              .foreground100,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Universal: ',
                      style: TextStyle(fontSize: 12.0),
                    ),
                    Expanded(
                      child: Text(
                        '${widget.appKitModal.appKit!.metadata.redirect?.universal}',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: ReownAppKitModalTheme.colorsOf(context)
                              .foreground100,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Link Mode: ',
                      style: TextStyle(fontSize: 12.0),
                    ),
                    Text(
                      '${widget.appKitModal.appKit!.metadata.redirect?.linkMode}',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: ReownAppKitModalTheme.colorsOf(context)
                            .foreground100,
                      ),
                    ),
                  ],
                ),
                const Divider(height: 10.0),
                FutureBuilder(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    final versionText =
                        '${snapshot.data?.packageName} v${snapshot.data?.version ?? ''} (${snapshot.data?.buildNumber})\n'
                        'AppKit v${apkt_v.packageVersion}\n'
                        'Sign v${sign_v.packageVersion}\n'
                        'Core v${core_v.packageVersion}';
                    return InkWell(
                      onTap: () => Clipboard.setData(ClipboardData(
                        text: versionText,
                      )),
                      child: Text(
                        versionText,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: ReownAppKitModalTheme.colorsOf(context)
                              .foreground100,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox.square(dimension: 10.0),
          const Divider(height: 1.0, indent: 12.0, endIndent: 12.0),
          ListTile(
            leading: Icon(
              Icons.close,
              color: ReownAppKitModalTheme.colorsOf(context).foreground100,
            ),
            title: const Text('Close'),
            titleTextStyle: TextStyle(
              color: ReownAppKitModalTheme.colorsOf(context).foreground100,
            ),
            onTap: () {
              if (_hasUpdates) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: const Text(
                          'Application will be closed to make changes'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            _restore().then((value) => Navigator.pop(context));
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            exit(0);
                          },
                          child: const Text('Ok'),
                        )
                      ],
                    );
                  },
                );
              } else {
                // restore and pop
                _restore().then((value) => Navigator.pop(context));
              }
            },
          ),
        ],
      ),
    );
  }
}
