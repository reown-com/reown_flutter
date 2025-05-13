import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:reown_appkit/reown_appkit.dart';

import 'package:reown_appkit_dapp/utils/constants.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
    required this.appKitModal,
    required this.reinitialize,
    this.linkMode = false,
    this.socials = false,
  });

  final ReownAppKitModal appKitModal;
  final Function(String storageKey, bool value) reinitialize;
  final bool linkMode;
  final bool socials;

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 12.0,
      color: ReownAppKitModalTheme.colorsOf(context).foreground100,
    );
    final textStyleBold = textStyle.copyWith(
      fontWeight: FontWeight.bold,
    );
    final redirect = widget.appKitModal.appKit!.metadata.redirect;
    return Center(
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: StyleConstants.maxWidth,
        ),
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Visibility(
                visible: !widget.appKitModal.isConnected,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              'non-EVM\nSession Proposal',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: ReownAppKitModalTheme.colorsOf(context)
                                    .foreground100,
                                fontWeight: !widget.linkMode
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                          Switch(
                            value: widget.linkMode,
                            onChanged: (value) {
                              widget.reinitialize(
                                'appkit_sample_linkmode',
                                value,
                              );
                            },
                          ),
                          Expanded(
                            child: Text(
                              'Link Mode\nonly EVM',
                              style: TextStyle(
                                color: ReownAppKitModalTheme.colorsOf(context)
                                    .foreground100,
                                fontWeight: widget.linkMode
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              'Without Socials',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: ReownAppKitModalTheme.colorsOf(context)
                                    .foreground100,
                                fontWeight: !widget.socials
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                          Semantics(
                            label: 'With Socials Switch ${widget.socials}',
                            // toggled: widget.socials,
                            checked: widget.socials,
                            child: Switch(
                              value: widget.socials,
                              onChanged: (value) {
                                widget.reinitialize(
                                  'appkit_sample_socials',
                                  value,
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'With Socials',
                              style: TextStyle(
                                color: ReownAppKitModalTheme.colorsOf(context)
                                    .foreground100,
                                fontWeight: widget.socials
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Wrap(
                      //   runAlignment: WrapAlignment.end,
                      //   crossAxisAlignment: WrapCrossAlignment.end,
                      //   alignment: WrapAlignment.end,
                      //   children: [
                      //     ...ReownAppKitModalNetworks.getAllSupportedNetworks()
                      //         .map((network) {
                      //       return Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         mainAxisSize: MainAxisSize.min,
                      //         children: [
                      //           Expanded(
                      //             child: Text(
                      //               '${network.name} (${NamespaceUtils.getNamespaceFromChain(network.chainId)}${network.isTestNetwork ? ', test' : ''})',
                      //               textAlign: TextAlign.end,
                      //               style: TextStyle(
                      //                 color: ReownAppKitModalTheme.colorsOf(
                      //                         context)
                      //                     .foreground100,
                      //                 fontWeight: !widget.linkMode
                      //                     ? FontWeight.bold
                      //                     : FontWeight.normal,
                      //               ),
                      //             ),
                      //           ),
                      //           Switch(
                      //             value: true,
                      //             onChanged: (value) {
                      //               //
                      //             },
                      //           ),
                      //           Expanded(child: SizedBox()),
                      //         ],
                      //       );
                      //     }),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: StyleConstants.linear16),
            // const Divider(height: 1.0, color: Colors.black12),
            // const SizedBox(height: StyleConstants.linear8),
            Visibility(
              visible: !widget.appKitModal.isConnected,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30.0,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        elevation: WidgetStateProperty.all(0.0),
                        backgroundColor: WidgetStateProperty.all<Color>(
                          ReownAppKitModalTheme.colorsOf(context).accenGlass010,
                        ),
                        foregroundColor: WidgetStateProperty.all<Color>(
                          ReownAppKitModalTheme.colorsOf(context).foreground100,
                        ),
                      ),
                      onPressed: () async {
                        await widget.appKitModal.appKit!.core.storage
                            .deleteAll();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Storage cleared'),
                          duration: Duration(seconds: 1),
                        ));
                      },
                      child: Text(
                        'CLEAR STORAGE',
                        style: TextStyle(fontSize: 10.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: StyleConstants.linear8),
            Text(
              'Redirect metadata:',
              style: textStyleBold,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Native: ', style: textStyle),
                Expanded(
                  child: Text('${redirect?.native}', style: textStyleBold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Universal: ', style: textStyle),
                Expanded(
                  child: Text('${redirect?.universal}', style: textStyleBold),
                ),
              ],
            ),
            Row(
              children: [
                Text('Link Mode: ', style: textStyle),
                Text('${redirect?.linkMode}', style: textStyleBold),
              ],
            ),
            FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox.shrink();
                }
                final v = snapshot.data!.version;
                final b = snapshot.data!.buildNumber;
                const f = String.fromEnvironment('FLUTTER_APP_FLAVOR');
                // return Text('App Version: $v-$f ($b) - SDK v$packageVersion');
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('App Version: ', style: textStyle),
                    Expanded(
                      child: Text(
                        '$v-$f ($b) - SDK v$packageVersion',
                        style: textStyleBold,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: StyleConstants.linear8),
            FutureBuilder(
              future: ReownCoreUtils.getPackageName(),
              builder: (_, snapshot) {
                return Text(
                  snapshot.data ?? '',
                  style: textStyleBold,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
