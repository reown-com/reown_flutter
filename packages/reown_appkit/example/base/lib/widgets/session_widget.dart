import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_appkit_dapp/utils/constants.dart';
import 'package:reown_appkit_dapp/utils/crypto/eip155.dart';
import 'package:reown_appkit_dapp/utils/crypto/helpers.dart';
import 'package:reown_appkit_dapp/utils/crypto/polkadot.dart';
import 'package:reown_appkit_dapp/utils/crypto/solana.dart';
import 'package:reown_appkit_dapp/utils/string_constants.dart';
import 'package:reown_appkit_dapp/widgets/method_dialog.dart';

class SessionWidget extends StatefulWidget {
  const SessionWidget({
    super.key,
    required this.sessionTopic,
    required this.appKitModal,
  });

  final String sessionTopic;
  final ReownAppKitModal appKitModal;

  @override
  SessionWidgetState createState() => SessionWidgetState();
}

class SessionWidgetState extends State<SessionWidget> {
  late IReownAppKit _appKit;
  late SessionData _session;

  @override
  void initState() {
    super.initState();
    _appKit = widget.appKitModal.appKit!;
    _session = _appKit.sessions.get(widget.sessionTopic)!;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      Text(
        '${StringConstants.sessionTopic}${_session.topic}',
      ),
    ];

    // Get all of the accounts
    final List<String> namespaceAccounts = [];

    // Loop through the namespaces, and get the accounts
    for (final Namespace namespace in _session.namespaces.values) {
      namespaceAccounts.addAll(namespace.accounts);
    }

    // Loop through the namespace accounts and build the widgets
    for (final String namespaceAccount in namespaceAccounts) {
      children.add(
        _buildAccountWidget(
          namespaceAccount,
        ),
      );
    }

    // Add a delete button
    children.add(
      Container(
        width: double.infinity,
        height: StyleConstants.linear48,
        margin: const EdgeInsets.symmetric(
          vertical: StyleConstants.linear8,
        ),
        child: ElevatedButton(
          onPressed: () async {
            await _appKit.disconnectSession(
              topic: _session.topic,
              reason: Errors.getSdkError(
                Errors.USER_DISCONNECTED,
              ).toSignError(),
            );
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.red,
            ),
          ),
          child: const Text(
            StringConstants.delete,
            style: StyleConstants.buttonText,
          ),
        ),
      ),
    );

    children.add(const SizedBox(height: 20.0));
    return ListView(
      children: children,
    );
  }

  Widget _buildAccountWidget(String namespaceAccount) {
    final chainId = NamespaceUtils.getChainFromAccount(namespaceAccount);
    final account = NamespaceUtils.getAccount(namespaceAccount);
    final namespace = NamespaceUtils.getNamespaceFromChain(
      chainId,
    );
    final chainData = ReownAppKitModalNetworks.getNetworkById(
      namespace,
      chainId.split(':').last,
    );

    final List<Widget> children = [
      Text(
        chainData!.name,
        style: StyleConstants.subtitleText,
      ),
      const SizedBox(
        height: StyleConstants.linear8,
      ),
      Text(
        account,
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: StyleConstants.linear8,
      ),
      const Text(
        StringConstants.methods,
        style: StyleConstants.subtitleText,
      ),
    ];

    children.addAll(_buildChainMethodButtons(chainData, account));

    children.add(const Divider());

    if (chainId != 'eip155:11155111') {
      children.add(const Text('Connect to Sepolia to Test'));
    }
    children.addAll(_buildSepoliaButtons(account, chainId));

    children.addAll([
      const SizedBox(
        height: StyleConstants.linear8,
      ),
      const Text(
        StringConstants.events,
        style: StyleConstants.subtitleText,
      ),
    ]);
    children.addAll(_buildChainEventsTiles(chainData));

    // final ChainMetadata
    return Container(
      width: double.infinity,
      // height: StyleConstants.linear48,
      padding: const EdgeInsets.all(
        StyleConstants.linear8,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: StyleConstants.linear8,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            StyleConstants.linear8,
          ),
        ),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  List<Widget> _buildChainMethodButtons(
    ReownAppKitModalNetworkInfo chainMetadata,
    String address,
  ) {
    final List<Widget> buttons = [];
    // Add Methods
    final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
      chainMetadata.chainId,
    );
    for (final String method in getChainMethods(namespace)) {
      final namespaces = _session.namespaces[namespace];
      final supported = namespaces?.methods.contains(method) ?? false;
      buttons.add(
        Container(
          width: double.infinity,
          height: StyleConstants.linear48,
          margin: const EdgeInsets.symmetric(
            vertical: StyleConstants.linear8,
          ),
          child: ElevatedButton(
            onPressed: supported
                ? () async {
                    final future = callChainMethod(
                      method,
                      chainMetadata,
                      address,
                    );
                    MethodDialog.show(context, method, future);
                    _launchWallet();
                  }
                : null,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (states) => states.contains(MaterialState.disabled)
                    ? Colors.grey
                    : Colors.blue,
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    StyleConstants.linear8,
                  ),
                ),
              ),
            ),
            child: Text(
              method,
              style: StyleConstants.buttonText,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return buttons;
  }

  Future<dynamic> callChainMethod(
    String method,
    ReownAppKitModalNetworkInfo chainMetadata,
    String address,
  ) {
    final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
      chainMetadata.chainId,
    );
    switch (namespace) {
      case 'eip155':
        return EIP155.callMethod(
          appKit: _appKit,
          topic: _session.topic,
          method: method,
          chainData: chainMetadata,
          address: address,
        );
      case 'polkadot':
        return Polkadot.callMethod(
          appKit: _appKit,
          topic: _session.topic,
          method: method,
          chainData: chainMetadata,
          address: address,
        );
      case 'solana':
        return Solana.callMethod(
          appKit: _appKit,
          topic: _session.topic,
          method: method,
          chainData: chainMetadata,
          address: address,
        );
      // case ChainType.kadena:
      //   return Kadena.callMethod(
      //     appKit: _appKit,
      //     topic: _session.topic,
      //     method: method.toKadenaMethod()!,
      //     chainId: chainMetadata.chainId,
      //     address: address.toLowerCase(),
      //   );
      default:
        throw 'Unimplemented';
    }
  }

  void _launchWallet() {
    if (kIsWeb) return;
    _appKit.redirectToWallet(
      topic: _session.topic,
      redirect: _session.peer.metadata.redirect,
    );
  }

  List<Widget> _buildSepoliaButtons(String address, String chainId) {
    final List<Widget> buttons = [];
    final enabled = chainId == 'eip155:11155111';
    buttons.add(
      Container(
        width: double.infinity,
        height: StyleConstants.linear48,
        margin: const EdgeInsets.symmetric(
          vertical: StyleConstants.linear8,
        ),
        child: ElevatedButton(
          onPressed: enabled
              ? () async {
                  final future = EIP155.callSmartContract(
                    appKit: _appKit,
                    topic: _session.topic,
                    address: address,
                    action: 'read',
                  );
                  MethodDialog.show(context, 'Test Contract (Read)', future);
                }
              : null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.disabled)) {
                return StyleConstants.grayColor;
              }
              return Colors.orange;
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  StyleConstants.linear8,
                ),
              ),
            ),
          ),
          child: const Text(
            'Test Contract (Read)',
            style: StyleConstants.buttonText,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
    buttons.add(
      Container(
        width: double.infinity,
        height: StyleConstants.linear48,
        margin: const EdgeInsets.symmetric(
          vertical: StyleConstants.linear8,
        ),
        child: ElevatedButton(
          onPressed: enabled
              ? () async {
                  final future = EIP155.callSmartContract(
                    appKit: _appKit,
                    topic: _session.topic,
                    address: address,
                    action: 'write',
                  );
                  MethodDialog.show(context, 'Test Contract (Write)', future);
                  _launchWallet();
                }
              : null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.disabled)) {
                return StyleConstants.grayColor;
              }
              return Colors.orange;
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  StyleConstants.linear8,
                ),
              ),
            ),
          ),
          child: const Text(
            'Test Contract (Write)',
            style: StyleConstants.buttonText,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );

    return buttons;
  }

  List<Widget> _buildChainEventsTiles(ReownAppKitModalNetworkInfo chainData) {
    final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
      chainData.chainId,
    );
    final List<Widget> values = [];
    for (final String event in getChainEvents(namespace)) {
      values.add(
        Container(
          width: double.infinity,
          height: StyleConstants.linear48,
          margin: const EdgeInsets.symmetric(
            vertical: StyleConstants.linear8,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(
                StyleConstants.linear8,
              ),
            ),
          ),
          child: Center(
            child: Text(
              event,
              style: StyleConstants.buttonText,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return values;
  }
}
