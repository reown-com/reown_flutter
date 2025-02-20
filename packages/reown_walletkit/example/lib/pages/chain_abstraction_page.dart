import 'package:flutter/material.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/widgets/custom_button.dart';

class DetailsAndExecute extends StatefulWidget {
  const DetailsAndExecute({super.key, required this.uiFieldsCompat});
  final UiFieldsCompat uiFieldsCompat;

  @override
  State<DetailsAndExecute> createState() => _DetailsAndExecuteState();
}

class _DetailsAndExecuteState extends State<DetailsAndExecute> {
  late final UiFieldsCompat uiFields;

  @override
  void initState() {
    super.initState();
    uiFields = widget.uiFieldsCompat;
  }

  List<FundingMetadataCompat> get fundingFrom {
    return uiFields.routeResponse.metadata.fundingFrom;
  }

  InitialTransactionMetadataCompat get initialTransaction {
    return uiFields.routeResponse.metadata.initialTransaction;
  }

  String get initialTxHash {
    return uiFields.initial.transactionHashToSign;
  }

  String get estimatedFees {
    return uiFields.localTotal.formattedAlt;
  }

  String get bridgeFee {
    // return uiFields.localBridgeTotal.formattedAlt
    return uiFields.bridge.first.localFee.formattedAlt;
  }

  String get payingAmount {
    return uiFields.routeResponse.metadata.initialTransaction.amount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Review Transaction')),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'orchestrationId\n${uiFields.routeResponse.orchestrationId}',
                textAlign: TextAlign.center,
              ),
              const SizedBox.square(dimension: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Paying'),
                  Text('${_formattedStringBalance(payingAmount)} USDC'),
                ],
              ),
              const Divider(height: 20.0, thickness: 0.5),
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
                              uiFields.routeResponse.initialTransaction.chainId,
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder(
                    future: YttriumDart.instance.erc20TokenBalance(
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
                              text: from.chainId,
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
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
              // Text('(${uiFields.localBridgeTotal.formatted})'),
              const Divider(height: 20.0, thickness: 0.5),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Execution:'),
                  Text('Fast (~20 sec)'),
                ],
              ),
              // const Divider(height: 20.0, thickness: 0.5),
              // Text(uiFields.localRouteTotal.formattedAlt),
              // Text(uiFields.localRouteTotal.formatted),
              const Expanded(child: SizedBox.shrink()),
              Column(
                children: [
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: ElevatedButton(
                  //         onPressed: _execute,
                  //         child: const Text('Execute'),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Row(
                    children: [
                      CustomButton(
                        type: CustomButtonType.normal,
                        onTap: _execute,
                        child: const Center(
                          child: Text(
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
    // final response = await YttriumDart.instance.execute(
    //   uiFields: null,
    //   routeTxnSigs: [],
    //   initialTxnSig: null,
    // );
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
