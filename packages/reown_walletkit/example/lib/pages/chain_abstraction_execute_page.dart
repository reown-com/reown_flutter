import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/evm_service.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/models/chain_data.dart';
import 'package:reown_walletkit_wallet/widgets/custom_button.dart';

class ChainAbstractionDetailsAndExecute extends StatefulWidget {
  const ChainAbstractionDetailsAndExecute({
    super.key,
    required this.uiFieldsCompat,
  });
  final UiFieldsCompat uiFieldsCompat;

  @override
  State<ChainAbstractionDetailsAndExecute> createState() =>
      _ChainAbstractionDetailsAndExecuteState();
}

class _ChainAbstractionDetailsAndExecuteState
    extends State<ChainAbstractionDetailsAndExecute> {
  late final UiFieldsCompat uiFields;
  bool _executing = false;

  @override
  void initState() {
    super.initState();
    uiFields = widget.uiFieldsCompat;
  }

  List<FundingMetadataCompat> get fundingFrom {
    return uiFields.routeResponse.metadata.fundingFrom;
  }

  String get estimatedFees {
    return uiFields.localTotal.formattedAlt;
  }

  String get bridgeFee {
    return uiFields.bridge.first.localFee.formattedAlt;
  }

  String get fundingAmount {
    return uiFields.routeResponse.metadata.initialTransaction.amount;
  }

  String get recipient {
    return uiFields.routeResponse.metadata.initialTransaction.transferTo;
  }

  @override
  Widget build(BuildContext context) {
    final walletKit = GetIt.I<IWalletKitService>().walletKit;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: const Text('Review Transaction'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Paying on ',
                          style: TextStyle(
                            fontSize: 14.0,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                        TextSpan(
                          text:
                              '${ChainsDataList.eip155Chains.firstWhere((e) => e.chainId == uiFields.routeResponse.initialTransaction.chainId).name} ',
                          style: TextStyle(
                            fontSize: 14.0,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        WidgetSpan(
                          child: CachedNetworkImage(
                            width: 20.0,
                            height: 20.0,
                            imageUrl: ChainsDataList.eip155Chains
                                .firstWhere((e) =>
                                    e.chainId ==
                                    uiFields.routeResponse.initialTransaction
                                        .chainId)
                                .logo,
                            errorWidget: (context, url, error) =>
                                const SizedBox.shrink(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text('${_formattedStringBalance(fundingAmount)} USDC'),
                ],
              ),
              const Divider(height: 20.0, thickness: 0.5),
              Text(
                'To:\n$recipient',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 12.0),
              ),
              const SizedBox.square(dimension: 8.0),
              Text(
                'Orchestration id:\n${uiFields.routeResponse.orchestrationId}',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 12.0),
              ),
              const SizedBox.square(dimension: 40.0),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Source of funds',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox.square(dimension: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Balance on ',
                          style: TextStyle(
                            fontSize: 14.0,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                        TextSpan(
                          text:
                              '${ChainsDataList.eip155Chains.firstWhere((e) => e.chainId == uiFields.routeResponse.initialTransaction.chainId).name} ',
                          style: TextStyle(
                            fontSize: 14.0,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        WidgetSpan(
                          child: CachedNetworkImage(
                            width: 20.0,
                            height: 20.0,
                            imageUrl: ChainsDataList.eip155Chains
                                .firstWhere((e) =>
                                    e.chainId ==
                                    uiFields.routeResponse.initialTransaction
                                        .chainId)
                                .logo,
                            errorWidget: (context, url, error) =>
                                const SizedBox.shrink(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder(
                    future: walletKit.erc20TokenBalance(
                      chainId:
                          uiFields.routeResponse.initialTransaction.chainId,
                      token: uiFields.routeResponse.metadata.initialTransaction
                          .tokenContract,
                      owner: uiFields.routeResponse.initialTransaction.from,
                    ),
                    builder: (_, snapshot) {
                      final balance = _formattedStringBalance(
                        snapshot.data ?? '0',
                      );
                      return Text('$balance USDC');
                    },
                  ),
                ],
              ),
              const SizedBox.square(dimension: 8.0),
              Column(
                children: fundingFrom.map((from) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Bridging from ',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '${ChainsDataList.eip155Chains.firstWhere((e) => e.chainId == from.chainId).name} ',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            WidgetSpan(
                              child: CachedNetworkImage(
                                width: 20.0,
                                height: 20.0,
                                imageUrl: ChainsDataList.eip155Chains
                                    .firstWhere(
                                        (e) => e.chainId == from.chainId)
                                    .logo,
                                errorWidget: (context, url, error) =>
                                    const SizedBox.shrink(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${_formattedStringBalance(from.amount)} ${from.symbol}',
                        textAlign: TextAlign.end,
                      )
                    ],
                  );
                }).toList(),
              ),
              const Divider(height: 20.0, thickness: 0.5),
              const SizedBox.square(dimension: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Estimated fees:'),
                  Text(estimatedFees),
                ],
              ),
              const Divider(height: 20.0, thickness: 0.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Bridge fees:'),
                  Text(bridgeFee),
                ],
              ),
              const Divider(height: 20.0, thickness: 0.5),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Execution:'),
                  Text('Fast (~20 sec)'),
                ],
              ),
              const Expanded(child: SizedBox.shrink()),
              Column(
                children: [
                  Row(
                    children: [
                      CustomButton(
                        type: CustomButtonType.normal,
                        onTap: _executing ? null : () => _execute(),
                        child: Center(
                          child: _executing
                              ? CircularProgressIndicator.adaptive(
                                  backgroundColor: Colors.white,
                                )
                              : Text(
                                  'Execute',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          child: const Text('Reject'),
                          onPressed: () {
                            final error = Errors.getSdkError(
                              Errors.USER_REJECTED,
                            ).toSignError();
                            Navigator.of(context).pop(error);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _execute() async {
    setState(() => _executing = true);
    final TxnDetailsCompat initial = uiFields.initial;
    final String chainId = initial.transaction.chainId;

    try {
      final evmService = GetIt.I.get<EVMService>(instanceName: chainId);
      final executeResponse = await evmService.chainAbstractionExecuteHandler(
        uiFields,
      );
      Navigator.of(context).pop(executeResponse);
    } catch (_) {
      final error = Errors.getSdkError(
        Errors.MALFORMED_REQUEST_PARAMS,
      ).toSignError();
      Navigator.of(context).pop(error);
    }
  }

  String _formattedStringBalance(String rawBalance, [int? decimals]) {
    return _formattedBalance(BigInt.parse(rawBalance), decimals);
  }

  String _formattedBalance(BigInt rawBalance, [int? decimals]) {
    final d = uiFields.routeResponse.metadata.initialTransaction.decimals;
    final balance = rawBalance / BigInt.from(10).pow(decimals ?? d);
    return balance.toStringAsFixed(4);
  }
}
