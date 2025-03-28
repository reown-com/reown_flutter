import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reown_appkit/modal/utils/core_utils.dart';
import 'package:reown_appkit_example/services/contracts/aave_contract.dart';
import 'package:reown_appkit_example/services/contracts/arb_aave_contract.dart';
import 'package:reown_appkit_example/services/contracts/contract.dart';
import 'package:reown_appkit_example/services/contracts/usdt_contract.dart';
import 'package:reown_appkit_example/services/contracts/wct_contract.dart';

import 'package:reown_appkit_example/utils/styles.dart';

import 'package:reown_appkit/reown_appkit.dart';

import 'package:reown_appkit_example/utils/constants.dart';
import 'package:reown_appkit_example/services/methods_service.dart';
import 'package:reown_appkit_example/widgets/method_dialog.dart';
import 'package:toastification/toastification.dart';

class SessionWidget extends StatefulWidget {
  const SessionWidget({super.key, required this.appKit});

  final ReownAppKitModal appKit;

  @override
  SessionWidgetState createState() => SessionWidgetState();
}

class SessionWidgetState extends State<SessionWidget> {
  @override
  Widget build(BuildContext context) {
    final session = widget.appKit.session!;
    String iconImage = '';
    if ((session.peer?.metadata.icons ?? []).isNotEmpty) {
      iconImage = session.peer?.metadata.icons.first ?? '';
    }
    final List<Widget> children = [
      const SizedBox(height: 8.0),
      Row(
        children: [
          if (iconImage.isNotEmpty)
            Row(
              children: [
                CircleAvatar(
                  radius: 18.0,
                  backgroundImage: NetworkImage(
                    iconImage,
                    headers: CoreUtils.getAPIHeaders(
                      widget.appKit.appKit!.core.projectId,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
              ],
            ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    session.connectedWalletName ?? '',
                    style: ReownAppKitModalTheme.getDataOf(context)
                        .textStyles
                        .paragraph600
                        .copyWith(
                          color: ReownAppKitModalTheme.colorsOf(context)
                              .foreground100,
                        ),
                  ),
                ),
                Visibility(
                  visible: !session.sessionService.isMagic,
                  child: IconButton(
                    onPressed: () {
                      widget.appKit.launchConnectedWallet();
                    },
                    icon: const Icon(Icons.open_in_new),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 8.0),
      // TOPIC LABEL
      Visibility(
        visible: session.topic != null,
        child: Column(
          children: [
            Text(
              StringConstants.sessionTopic,
              style: ReownAppKitModalTheme.getDataOf(context)
                  .textStyles
                  .small600
                  .copyWith(
                    color:
                        ReownAppKitModalTheme.colorsOf(context).foreground100,
                  ),
            ),
            Text(
              '${session.topic}',
              style: ReownAppKitModalTheme.getDataOf(context)
                  .textStyles
                  .small400
                  .copyWith(
                    color:
                        ReownAppKitModalTheme.colorsOf(context).foreground100,
                  ),
            ),
          ],
        ),
      ),
      Column(
        children: _buildSupportedChainsWidget(
          widget.appKit.selectedChain!.chainId,
        ),
      ),
      const SizedBox(height: StyleConstants.linear8),
    ];

    // Get current active account
    final chainId = widget.appKit.selectedChain!.chainId;
    final namespace = NamespaceUtils.getNamespaceFromChain(chainId);
    final accounts = session.getAccounts(namespace: namespace) ?? [];
    final chainsNamespaces = NamespaceUtils.getChainsFromAccounts(accounts);
    if (chainsNamespaces.contains('$namespace:$chainId')) {
      final account = accounts.firstWhere(
        (account) => account.contains('$namespace:$chainId'),
      );
      children.add(_buildAccountWidget(account));
    }
    children.add(
      Column(
        children: [
          const SizedBox.square(dimension: 8.0),
          Text(
            'Stored session:',
            style: ReownAppKitModalTheme.getDataOf(context)
                .textStyles
                .small600
                .copyWith(
                  color: ReownAppKitModalTheme.colorsOf(context).foreground100,
                ),
          ),
          InkWell(
            onTap: () => Clipboard.setData(
              ClipboardData(
                text: jsonEncode(widget.appKit.session?.toMap()),
              ),
            ).then(
              (_) => toastification.show(
                title: Text(StringConstants.copiedToClipboard),
                context: context,
                autoCloseDuration: Duration(seconds: 2),
                alignment: Alignment.bottomCenter,
              ),
            ),
            child: Text(
              const JsonEncoder.withIndent('     ')
                  .convert(widget.appKit.session?.toMap()),
              style: ReownAppKitModalTheme.getDataOf(context)
                  .textStyles
                  .small400
                  .copyWith(
                    color:
                        ReownAppKitModalTheme.colorsOf(context).foreground100,
                  ),
            ),
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Column(children: children),
    );
  }

  Widget _buildAccountWidget(String account) {
    final chainId = NamespaceUtils.getChainFromAccount(account);
    // final chainMetadata = ChainDataWrapper.getChainMetadataFromChain(
    //   chainId.split(':').first,
    //   chainId.split(':').last,
    // );

    final List<Widget> children = [
      Text(
        widget.appKit.selectedChain?.name ?? 'Unsupported chain',
        style: ReownAppKitModalTheme.getDataOf(context)
            .textStyles
            .title600
            .copyWith(
              color: ReownAppKitModalTheme.colorsOf(context).foreground100,
            ),
      ),
      const SizedBox(height: StyleConstants.linear8),
      Text(
        NamespaceUtils.getAccount(account),
        style: ReownAppKitModalTheme.getDataOf(context)
            .textStyles
            .small400
            .copyWith(
              color: ReownAppKitModalTheme.colorsOf(context).foreground100,
            ),
      ),
    ];

    children.addAll([
      const SizedBox(height: StyleConstants.linear8),
      Text(
        StringConstants.methods,
        style: ReownAppKitModalTheme.getDataOf(context)
            .textStyles
            .paragraph600
            .copyWith(
              color: ReownAppKitModalTheme.colorsOf(context).foreground100,
            ),
      ),
    ]);
    children.addAll(_buildChainMethodButtons(account));

    children.addAll([
      const SizedBox(height: StyleConstants.linear8),
      Text(
        StringConstants.events,
        style: ReownAppKitModalTheme.getDataOf(context)
            .textStyles
            .paragraph600
            .copyWith(
              color: ReownAppKitModalTheme.colorsOf(context).foreground100,
            ),
      ),
    ]);
    children.add(_buildChainEventsTiles(chainId));

    return Container(
      padding: const EdgeInsets.all(StyleConstants.linear8),
      margin: const EdgeInsets.symmetric(vertical: StyleConstants.linear8),
      decoration: BoxDecoration(
        border: Border.all(
            color: ReownAppKitModalTheme.colorsOf(context).accent100),
        borderRadius: const BorderRadius.all(
          Radius.circular(StyleConstants.linear8),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }

  List<Widget> _buildChainMethodButtons(String address) {
    // Add Methods
    final chainId = NamespaceUtils.getChainFromAccount(address);
    final namespace = NamespaceUtils.getNamespaceFromChain(chainId);
    final approvedMethods = widget.appKit.getApprovedMethods(
      namespace: namespace,
    );
    if ((approvedMethods ?? []).isEmpty) {
      return [
        Text(
          'No methods approved',
          style: ReownAppKitModalTheme.getDataOf(context)
              .textStyles
              .small400
              .copyWith(
                color: ReownAppKitModalTheme.colorsOf(context).foreground100,
              ),
        )
      ];
    }
    final usableMethods = SupportedMethods.values.map((e) => e.name).toList();
    //
    final List<Widget> children = [];
    for (final method in (approvedMethods ?? <String>[])) {
      final implemented = usableMethods.contains(method);
      children.add(
        Container(
          height: StyleConstants.linear40,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: StyleConstants.linear8),
          child: ElevatedButton(
            onPressed: implemented
                ? () async {
                    widget.appKit.launchConnectedWallet();
                    final future = callChainMethod(method);
                    MethodDialog.show(context, method, future);
                  }
                : null,
            style: buttonStyle(context),
            child: Text(method),
          ),
        ),
      );
    }

    if (namespace == 'eip155') {
      children.addAll(_addSmartContractButtons());
    }

    return children;
  }

  List<Widget> _addSmartContractButtons() {
    final List<Widget> children = [];
    children.add(const Divider());
    final chainInfo = widget.appKit.selectedChain!;

    late final SmartContract smartContract;
    if (chainInfo.chainId == '11155111') {
      smartContract = SepoliaAAVEContract();
    } else if (chainInfo.chainId == '42161') {
      smartContract = ArbitrumAAVEContract();
    } else if (chainInfo.chainId == '10') {
      smartContract = WCTOPETHContract();
    } else if (chainInfo.chainId == '1') {
      smartContract = ERC20USDTContract();
    } else {
      return children;
    }

    children.add(
      Text('Test ${smartContract.name}', textAlign: TextAlign.center),
    );

    children.addAll([
      Container(
        height: StyleConstants.linear40,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: StyleConstants.linear8),
        child: ElevatedButton(
          onPressed: () async {
            final future = MethodsService.callSmartContract(
              appKitModal: widget.appKit,
              smartContract: smartContract,
              action: 'read',
            );
            MethodDialog.show(
              context,
              'Read on ${smartContract.name}',
              future,
            );
          },
          style: buttonStyle(context),
          child: Text('Read on ${smartContract.name}'),
        ),
      ),
      Visibility(
        visible: chainInfo.chainId != '10',
        child: Container(
          height: StyleConstants.linear40,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: StyleConstants.linear8),
          child: ElevatedButton(
            onPressed: () async {
              widget.appKit.launchConnectedWallet();
              final future = MethodsService.callSmartContract(
                appKitModal: widget.appKit,
                smartContract: smartContract,
                action: 'write',
              );
              MethodDialog.show(
                context,
                'Write on ${smartContract.name}',
                future,
              );
            },
            style: buttonStyle(context),
            child: Text('Write on ${smartContract.name}'),
          ),
        ),
      ),
    ]);

    return children;
  }

  List<Widget> _buildSupportedChainsWidget(String chainId) {
    List<Widget> children = [];
    children.addAll(
      [
        const SizedBox(height: StyleConstants.linear8),
        Text(
          'Session chains:',
          style: ReownAppKitModalTheme.getDataOf(context)
              .textStyles
              .small600
              .copyWith(
                color: ReownAppKitModalTheme.colorsOf(context).foreground100,
              ),
        ),
      ],
    );
    final namespace = NamespaceUtils.getNamespaceFromChain(chainId);
    final approvedChains = widget.appKit.getApprovedChains(
      namespace: namespace,
    );
    children.add(
      Text(
        (approvedChains ?? []).join(', '),
        style: ReownAppKitModalTheme.getDataOf(context)
            .textStyles
            .small400
            .copyWith(
              color: ReownAppKitModalTheme.colorsOf(context).foreground100,
            ),
      ),
    );
    return children;
  }

  Widget _buildChainEventsTiles(String chainId) {
    // Add Events
    final namespace = NamespaceUtils.getNamespaceFromChain(chainId);
    final approvedEvents = widget.appKit.getApprovedEvents(
      namespace: namespace,
    );
    if ((approvedEvents ?? []).isEmpty) {
      return Text(
        'No events approved',
        style: ReownAppKitModalTheme.getDataOf(context)
            .textStyles
            .small400
            .copyWith(
              color: ReownAppKitModalTheme.colorsOf(context).foreground100,
            ),
      );
    }
    final List<Widget> children = [];
    for (final event in (approvedEvents ?? [])) {
      children.add(
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: StyleConstants.linear8,
            horizontal: StyleConstants.linear8,
          ),
          padding: const EdgeInsets.all(StyleConstants.linear8),
          decoration: BoxDecoration(
            border: Border.all(
              color: ReownAppKitModalTheme.colorsOf(context).accent100,
            ),
            borderRadius: borderRadius(context),
          ),
          child: Text(
            event,
            style: ReownAppKitModalTheme.getDataOf(context)
                .textStyles
                .small400
                .copyWith(
                  color: ReownAppKitModalTheme.colorsOf(context).foreground100,
                ),
          ),
        ),
      );
    }

    return Wrap(
      children: children,
    );
  }

  Future<dynamic> callChainMethod(String method) {
    final session = widget.appKit.session!;
    final chainId = widget.appKit.selectedChain!.chainId;
    final namespace = NamespaceUtils.getNamespaceFromChain(chainId);
    final address = session.getAddress(namespace)!;
    return MethodsService.callMethod(
      appKitModal: widget.appKit,
      topic: session.topic ?? '',
      method: method,
      chainId: widget.appKit.selectedChain!.chainId,
      address: address,
    );
  }
}
