import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/i_key_service.dart';
import 'package:reown_walletkit_wallet/pages/secret_keys_page.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_radius.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';
import 'package:reown_walletkit_wallet/theme/theme_provider.dart';
import 'package:reown_walletkit_wallet/widgets/custom_button.dart';
import 'package:reown_walletkit_wallet/widgets/recover_from_seed.dart';
import 'package:toastification/toastification.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _keysService = GetIt.I<IKeyService>();

  Future<void> _onDeleteData() async {
    final walletKit = GetIt.I<IWalletKitService>().walletKit;
    await walletKit.core.storage.deleteAll();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Storage cleared'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  Future<void> _onRestoreFromSeed() async {
    final mnemonic = await GetIt.I<IBottomSheetService>().queueBottomSheet(
      widget: RecoverFromSeed(),
    );
    if (mnemonic is String) {
      await _keysService.clearAll();
      await _keysService.restoreWallet(mnemonicOrPrivate: mnemonic);
      await _keysService.loadKeys();
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            content: Text('Wallet restored. App will close.'),
          );
        },
      );
      if (!kDebugMode) {
        exit(0);
      } else {
        setState(() {});
      }
    }
  }

  Future<void> _onRegenerateSeed() async {
    await _keysService.regenerateStoredWallet();
    await _keysService.loadKeys();
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Text('Wallet restored. App will close.'),
        );
      },
    );
    if (!kDebugMode) {
      exit(0);
    } else {
      setState(() {});
    }
  }

  Future<void> _onCreateNewWallet() async {
    final response = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            'This will delete the current wallet and create a new one',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Proceed'),
            ),
          ],
        );
      },
    );
    if (response == true) {
      await _keysService.clearAll();
      await _keysService.createRandomWallet();
      await _keysService.loadKeys();
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            content: Text('New wallet created. App will close.'),
          );
        },
      );
      if (!kDebugMode) {
        exit(0);
      } else {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ThemeSwitch(),
                  _SecretKeysRow(),
                  _DeviceData(),
                  _Metadata(),
                  _Buttons(
                    onDeleteData: _onDeleteData,
                    onRestoreFromSeed: _onRestoreFromSeed,
                    onRegenerateSeed: _onRegenerateSeed,
                    onCreateNewWallet: _onCreateNewWallet,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ThemeSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = GetIt.I<ThemeProvider>();
    final colors = context.colors;
    return ListenableBuilder(
      listenable: themeProvider,
      builder: (context, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s3, vertical: AppSpacing.s2),
          child: Row(
            children: [
              Icon(
                themeProvider.isDark ? Icons.dark_mode : Icons.light_mode,
                color: colors.textPrimary,
                size: 20.0,
              ),
              const SizedBox(width: AppSpacing.s2),
              Expanded(
                child: Text(
                  'Dark mode',
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Switch(
                value: themeProvider.isDark,
                activeColor: colors.accent,
                onChanged: (_) => themeProvider.toggleTheme(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SecretKeysRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const SecretKeysPage()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s3, vertical: AppSpacing.s3),
        child: Row(
          children: [
            Icon(Icons.key, color: colors.textPrimary, size: 20.0),
            const SizedBox(width: AppSpacing.s2),
            Expanded(
              child: Text(
                'Secret Keys & Phrases',
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: colors.textSecondary,
              size: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}

class _Metadata extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final walletKit = GetIt.I<IWalletKitService>().walletKit;
    final nativeLink = walletKit.metadata.redirect?.native;
    final universalLink = walletKit.metadata.redirect?.universal;
    final linkMode = walletKit.metadata.redirect?.linkMode;
    return Column(
      children: [
        const SizedBox(height: AppSpacing.s5),
        Divider(height: 1.0, color: colors.divider),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox.square(dimension: AppSpacing.s5),
              _DataContainer(
                title: 'Redirect',
                data:
                    'Native: $nativeLink\nUniversal: $universalLink\nLink Mode: $linkMode',
              ),
              const SizedBox.square(dimension: 10.0),
              FutureBuilder(
                future: ReownCoreUtils.getPackageName(),
                builder: (_, snapshot) {
                  return Text(
                    snapshot.data ?? '',
                    style: TextStyle(color: colors.textSecondary),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DeviceData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final walletKit = GetIt.I<IWalletKitService>().walletKit;
    return Column(
      children: [
        const SizedBox(height: AppSpacing.s5),
        Divider(height: 1.0, color: colors.divider),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: AppSpacing.s2,
                  top: AppSpacing.s3,
                  left: 10.0,
                ),
                child: Text(
                  'Device info',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: colors.textPrimary,
                  ),
                ),
              ),
              FutureBuilder<String>(
                future: walletKit.core.crypto.getClientId(),
                builder: (context, snapshot) {
                  return _DataContainer(
                    title: 'Client ID',
                    data: snapshot.data ?? '',
                  );
                },
              ),
              const SizedBox(height: AppSpacing.s3),
              FutureBuilder<PackageInfo>(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox.shrink();
                  }
                  final v = snapshot.data!.version;
                  final b = snapshot.data!.buildNumber;
                  const f = String.fromEnvironment('FLUTTER_APP_FLAVOR');
                  return _DataContainer(
                    title: 'App version',
                    data: '$v-$f ($b) - SDK v$packageVersion',
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Buttons extends StatelessWidget {
  final VoidCallback onRestoreFromSeed;
  final VoidCallback onRegenerateSeed;
  final VoidCallback onCreateNewWallet;
  final VoidCallback onDeleteData;
  const _Buttons({
    required this.onRestoreFromSeed,
    required this.onRegenerateSeed,
    required this.onCreateNewWallet,
    required this.onDeleteData,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      children: [
        const SizedBox(height: AppSpacing.s5),
        Divider(height: 1.0, color: colors.divider),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.s3),
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.s2),
              TextButton(
                onPressed: onDeleteData,
                child: Text(
                  'Clear local storage',
                  style: TextStyle(color: colors.textPrimary),
                ),
              ),
              const SizedBox(height: AppSpacing.s3),
              Row(
                children: [
                  CustomButton(
                    type: CustomButtonType.valid,
                    onTap: onRestoreFromSeed,
                    child: Center(
                      child: Text(
                        'Import Wallet',
                        style: TextStyle(
                          color: colors.onAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.s3),
              Row(
                children: [
                  CustomButton(
                    type: CustomButtonType.normal,
                    onTap: onRegenerateSeed,
                    child: Center(
                      child: Text(
                        'Regenerate current wallet',
                        style: TextStyle(
                          color: colors.onAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.s3),
              Row(
                children: [
                  CustomButton(
                    type: CustomButtonType.invalid,
                    onTap: onCreateNewWallet,
                    child: Center(
                      child: Text(
                        'Create new random wallet',
                        style: TextStyle(
                          color: colors.onAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DataContainer extends StatefulWidget {
  const _DataContainer({
    required this.title,
    required this.data,
    this.blurred = false,
    this.height,
  });
  final String title;
  final String data;
  final bool blurred;
  final double? height;

  @override
  State<_DataContainer> createState() => __DataContainerState();
}

class __DataContainerState extends State<_DataContainer> {
  late bool blurred;

  @override
  void initState() {
    super.initState();
    blurred = widget.blurred;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final blurValue = blurred ? 5.0 : 0.0;
    return GestureDetector(
      onTap: () => Clipboard.setData(ClipboardData(text: widget.data)).then(
        (_) => toastification.show(
          title: Text('${widget.title} copied'),
          context: context,
          autoCloseDuration: Duration(seconds: 2),
          alignment: Alignment.bottomCenter,
        ),
      ),
      onLongPress: () => setState(() {
        blurred = false;
      }),
      onLongPressUp: () => setState(() {
        blurred = widget.blurred;
      }),
      child: Container(
        height: widget.height,
        decoration: BoxDecoration(
          color: colors.neutrals.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        padding: const EdgeInsets.all(AppSpacing.s3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(width: AppSpacing.s2),
                Icon(Icons.copy, size: 14.0, color: colors.textSecondary),
              ],
            ),
            ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: blurValue,
                sigmaY: blurValue,
                tileMode: TileMode.decal,
              ),
              child: Text(
                widget.data,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                  color: colors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
