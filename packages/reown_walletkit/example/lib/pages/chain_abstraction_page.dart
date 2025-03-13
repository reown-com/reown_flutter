import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/evm_service.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/models/chain_data.dart';
import 'package:reown_walletkit_wallet/widgets/custom_button.dart';

class DetailsAndExecute extends StatefulWidget {
  const DetailsAndExecute({super.key, required this.uiFieldsCompat});
  final UiFieldsCompat uiFieldsCompat;

  @override
  State<DetailsAndExecute> createState() => _DetailsAndExecuteState();
}

class _DetailsAndExecuteState extends State<DetailsAndExecute> {
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
      appBar: AppBar(title: const Text('Review Transaction')),
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
                        const TextSpan(
                          text: 'Paying on ',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text:
                              '${ChainsDataList.eip155Chains.firstWhere((e) => e.chainId == uiFields.routeResponse.initialTransaction.chainId).name} ',
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        WidgetSpan(
                          child: Image.network(
                            width: 20.0,
                            height: 20.0,
                            ChainsDataList.eip155Chains
                                .firstWhere((e) =>
                                    e.chainId ==
                                    uiFields.routeResponse.initialTransaction
                                        .chainId)
                                .logo,
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
                        const TextSpan(
                          text: 'Balance on ',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text:
                              '${ChainsDataList.eip155Chains.firstWhere((e) => e.chainId == uiFields.routeResponse.initialTransaction.chainId).name} ',
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        WidgetSpan(
                          child: Image.network(
                            width: 20.0,
                            height: 20.0,
                            ChainsDataList.eip155Chains
                                .firstWhere((e) =>
                                    e.chainId ==
                                    uiFields.routeResponse.initialTransaction
                                        .chainId)
                                .logo,
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
                            const TextSpan(
                              text: 'Bridging from ',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '${ChainsDataList.eip155Chains.firstWhere((e) => e.chainId == from.chainId).name} ',
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            WidgetSpan(
                              child: Image.network(
                                width: 20.0,
                                height: 20.0,
                                ChainsDataList.eip155Chains
                                    .firstWhere(
                                        (e) => e.chainId == from.chainId)
                                    .logo,
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
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     const Text('App:'),
              //     // Text(estimatedFees),
              //   ],
              // ),
              // const Divider(height: 20.0, thickness: 0.5),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     const Text('Network:'),
              //     Text(
              //       uiFields.initial.transaction.chainId,
              //       style: const TextStyle(
              //         fontSize: 14.0,
              //         color: Colors.black,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox.square(dimension: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Estimated fees:'),
                  Text(estimatedFees),
                ],
              ),
              // Text('(${uiFields.localTotal.formatted})'),
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
                            Navigator.of(context).pop();
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
    final List<TxnDetailsCompat> route = uiFields.route;

    final evmService = GetIt.I.get<EVMService>(instanceName: chainId);
    final initialSignature = evmService.signHash(
      initial.transactionHashToSign,
    );
    final isValidSignature = evmService.isValidSignature(
      initial.transactionHashToSign,
      initialSignature,
    );
    if (isValidSignature) {
      final initialPrimitive = initialSignature.toPrimitiveSignature();
      final routePrimitives = route.map((r) {
        final rSignature = evmService.signHash(r.transactionHashToSign);
        return rSignature.toPrimitiveSignature();
      }).toList();
      try {
        final walletKit = GetIt.I<IWalletKitService>().walletKit;
        final response = await walletKit.execute(
          uiFields: uiFields,
          initialTxnSig: initialPrimitive,
          routeTxnSigs: routePrimitives,
        );
        Navigator.of(context).pop(response);
      } on Exception catch (e) {
        Navigator.of(context).pop(e);
      }
    } else {
      Navigator.of(context).pop(Exception('Invalid signature'));
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
