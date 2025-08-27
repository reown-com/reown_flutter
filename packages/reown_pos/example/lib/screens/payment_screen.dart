import 'package:collection/collection.dart';
import 'package:example/providers/available_networks_provider.dart';
import 'package:example/providers/payment_info_provider.dart';
import 'package:example/providers/reown_pos_provider.dart';
import 'package:example/widgets/dtc_app_bar.dart';
import 'package:example/widgets/dtc_card.dart';
import 'package:example/widgets/dtc_footer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter_wc/qr_flutter_wc.dart';
import 'package:reown_pos/i_reown_pos.dart';
import 'package:reown_pos/models/events.dart';
//

class PaymentScreen extends ConsumerStatefulWidget {
  const PaymentScreen({super.key});

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  Uri? _uri;

  @override
  void initState() {
    super.initState();
    ref.read(reownPosProvider).onPosEvent.subscribe(_onPosEvent);
  }

  void _onPosEvent(PosEvent event) {
    if (event is QrReadyEvent) {
      setState(() => _uri = event.uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final networkSelected = ref
        .read(availableNetworksProvider)
        .firstWhereOrNull((network) => network.selected);
    final paymentInfo = ref.watch(paymentInfoProvider);
    // final paymentInfoNotifier = ref.read(paymentInfoProvider.notifier);
    return Scaffold(
      backgroundColor: const Color(0xFF4CAF50),
      appBar: const DtcAppBar(),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Text(
                        'Scan to Pay',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Step 5: Customer scans QR',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      SizedBox.square(
                        dimension: 250.0,
                        child: QrImageView(
                          data: _uri?.toString() ?? '',
                          version: QrVersions.auto,
                          errorCorrectionLevel: QrErrorCorrectLevel.L,
                          eyeStyle: const QrEyeStyle(
                            eyeShape: QrEyeShape.circle,
                            color: Colors.black,
                          ),
                          dataModuleStyle: const QrDataModuleStyle(
                            dataModuleShape: QrDataModuleShape.circle,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Transaction Status Indicators
                      _EventsListWidget(),
                      const SizedBox(height: 32),
                      // Payment Details Card
                      DtcCard(
                        child: Column(
                          children: [
                            Text(
                              '\$${paymentInfo.amount}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${paymentInfo.token.toUpperCase()} on ${networkSelected!.name}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Network fee: \$0.05',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: DtcFooter(),
    );
  }
}

class _EventsListWidget extends ConsumerStatefulWidget {
  @override
  ConsumerState<_EventsListWidget> createState() => __EventsListWidgetState();
}

class __EventsListWidgetState extends ConsumerState<_EventsListWidget> {
  late final IReownPos _posInstance;
  final List<PosEvent> _eventsPool = [];

  @override
  void initState() {
    super.initState();
    _posInstance = ref.read(reownPosProvider);
    _posInstance.onPosEvent.subscribe(_onPosEvent);
  }

  void _onPosEvent(PosEvent event) {
    if (event is QrReadyEvent) {
      //
    } else if (event is ConnectRejectedEvent) {
      //
    } else if (event is ConnectFailedEvent) {
      //
    } else if (event is ConnectedEvent) {
      //
    } else if (event is PaymentRequestedEvent) {
      //
    } else if (event is PaymentBroadcastedEvent) {
      //
    } else if (event is PaymentRejectedEvent) {
      //
    } else if (event is PaymentFailedEvent) {
      //
    } else if (event is PaymentSuccessfulEvent) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(event.runtimeType.toString()),
            content: Text('${event.receipt}:\n${event.txHash}'),
            actions: [
              TextButton(
                onPressed: () {
                  ref.read(paymentInfoProvider.notifier).clear();
                  Navigator.of(
                    context,
                  ).popUntil((route) => route.settings.name == '/');
                },
                child: Text('Great!'),
              ),
            ],
          );
        },
      );
    } else if (event is DisconnectedEvent) {
      //
    } else if (event is ErrorEvent) {
      //
    }
    _eventsPool.add(event);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // _eventsPool = [
    //   QrReadyEvent(
    //     Uri.parse(
    //       'wc:3ff40e98ea015f10ceffe97d924e8910393fb937ed5969be8ce1105c6cd81476@2?relay-protocol=irn&symKey=074a348c386729671b7ee197741c22c6202ca1e1cfb1ebdada13ec3d36349956&methods=wc_sessionPropose%2Cwc_sessionRequest&expiryTimestamp=1756298705',
    //     ),
    //   ),
    //   ConnectedEvent(),
    //   PaymentRequestedEvent(),
    //   PaymentBroadcastedEvent(),
    //   PaymentSuccessfulEvent('', ''),
    //   PaymentFailedEvent(''),
    // ];
    //
    if (_eventsPool.isEmpty) {
      return SizedBox.shrink();
    }
    final currentEvent = _eventsPool.last;
    debugPrint('current event $currentEvent');
    return Column(
      children: [
        _buildStatusItem(
          text: 'Scan QR, waiting for wallet connection...',
          isLoading: currentEvent is QrReadyEvent,
          isActive: _eventsPool.any((event) => event is ConnectedEvent),
          isFailed: _eventsPool.any((event) => event is ErrorEvent),
        ),
        _buildStatusItem(
          text: 'Sending transaction...',
          isLoading: currentEvent is ConnectedEvent,
          isActive: _eventsPool.any((event) => event is PaymentRequestedEvent),
          isFailed: _eventsPool.any((event) => event is ErrorEvent),
        ),
        _buildStatusItem(
          text: 'Confirming transaction...',
          isLoading: currentEvent is PaymentRequestedEvent,
          isActive: _eventsPool.any(
            (event) => event is PaymentBroadcastedEvent,
          ),
          isFailed: _eventsPool.any((event) => event is ErrorEvent),
        ),
        _buildStatusItem(
          text: 'Checking the transaction status...',
          isLoading: currentEvent is PaymentBroadcastedEvent,
          isActive: _eventsPool.any((event) => event is PaymentSuccessfulEvent),
          isFailed: _eventsPool.any((event) => event is ErrorEvent),
        ),
      ],
    );
  }

  Widget _buildStatusItem({
    required String text,
    required bool isActive,
    required bool isLoading,
    required bool isFailed,
  }) {
    return Row(
      children: [
        // Status dot
        Visibility(
          visible: (isActive || !isLoading) && !isFailed,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: isActive ? Colors.green : Colors.black12,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Visibility(
          visible: isLoading && !isFailed,
          child: SizedBox.square(
            dimension: 8,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              color: Colors.green,
            ),
          ),
        ),
        Visibility(
          visible: isFailed,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Status text
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
