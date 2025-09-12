import 'package:example/providers/payment_info_provider.dart';
import 'package:example/providers/reown_pos_provider.dart';
import 'package:example/widgets/dtc_abort_button.dart';
import 'package:example/widgets/dtc_app_bar.dart';
import 'package:example/widgets/dtc_card.dart';
import 'package:example/widgets/dtc_footer.dart';
import 'package:example/widgets/dtc_header.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reown_pos/reown_pos.dart';
import 'package:reown_pos/utils/errors.dart';
//

class PaymentScreen extends ConsumerStatefulWidget {
  const PaymentScreen({super.key});

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  Uri? _uri;
  late final IReownPos _posInstance;

  @override
  void initState() {
    super.initState();
    _posInstance = ref.read(reownPosProvider);
    // [ReownPos SDK API] 5. subscribe to events to update the UI accordingli
    _posInstance.onPosEvent.subscribe(_onPosEvent);
  }

  @override
  void dispose() {
    _posInstance.onPosEvent.unsubscribe(_onPosEvent);
    super.dispose();
  }

  void _onPosEvent(PosEvent event) {
    if (event is QrReadyEvent && mounted) {
      print(event.uri);
      setState(() => _uri = event.uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final paymentInfo = ref.watch(paymentInfoProvider);
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
                      // Screen header
                      DtcHeader(
                        title: 'Scan to Pay',
                        description: 'Step 5: Customer scans QR',
                      ),
                      Text('Recipient: ${paymentInfo.recipient}'),
                      const SizedBox(height: 32),
                      // QR
                      SizedBox.square(
                        dimension: 250.0,
                        child: Visibility(
                          visible: _uri != null,
                          child: QrImageView(
                            data: _uri.toString(),
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
                      ),
                      const SizedBox(height: 32),
                      // Transaction Status Indicators
                      _EventsListWidget(),
                      const SizedBox(height: 32),
                      // Payment Details Card
                      _PaymentInfoWidget(),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: DtcRestartButton(),
                      ),
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
    // [ReownPos SDK API] 5. subscribe to events to update the UI accordingli
    _posInstance.onPosEvent.subscribe(_onPosEvent);
  }

  @override
  void dispose() {
    _posInstance.onPosEvent.unsubscribe(_onPosEvent);
    super.dispose();
  }

  void _onPosEvent(PosEvent event) {
    print(event.toString());
    if (event is QrReadyEvent) {
      // Used on the main widget to render the QR Code
    } else if (event is ConnectRejectedEvent) {
      _showDialogEvent(event.runtimeType.toString(), 'User rejected session');
    } else if (event is ConnectFailedEvent) {
      _showDialogEvent(event.runtimeType.toString(), event.message);
    } else if (event is ConnectedEvent) {
      //
    } else if (event is PaymentRequestedEvent) {
      //
    } else if (event is PaymentRequestFailedEvent) {
      final PosApiError apiError = event.apiError;
      final String message = event.message;
      final String fullErrorMessage = event.fullError ?? '';
      print(fullErrorMessage);
      _showDialogEvent('Error', 'code: ${apiError.name}\nmessage: $message');
    } else if (event is PaymentRequestRejectedEvent) {
      _showDialogEvent(event.runtimeType.toString(), 'User rejected payment');
    } else if (event is PaymentBroadcastedEvent) {
      //
    } else if (event is PaymentFailedEvent) {
      _showDialogEvent(event.runtimeType.toString(), event.message);
    } else if (event is PaymentSuccessfulEvent) {
      _showDialogEvent(event.runtimeType.toString(), event.txHash);
    } else if (event is DisconnectedEvent) {
      //
    }
    _eventsPool.add(event);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_eventsPool.isEmpty) {
      return SizedBox.shrink();
    }
    final currentEvent = _eventsPool.last;
    return Column(
      children: [
        _bulletPointStatus(
          text: 'Scan QR, waiting for wallet connection...',
          isLoading: currentEvent is QrReadyEvent,
          isActive: _eventsPool.any((event) => event is ConnectedEvent),
          // you can be more specific if handled the proper error event, such as ConnectRejectedEvent
          isFailed: _eventsPool.any((event) => event is PosErrorEvent),
        ),
        _bulletPointStatus(
          text: 'Sending transaction...',
          isLoading: currentEvent is ConnectedEvent,
          isActive: _eventsPool.any((event) => event is PaymentRequestedEvent),
          // you can be more specific if handled the proper error event, such as PaymentRejectedEvent
          isFailed: _eventsPool.any((event) => event is PosErrorEvent),
        ),
        _bulletPointStatus(
          text: 'Confirming transaction...',
          isLoading: currentEvent is PaymentRequestedEvent,
          isActive: _eventsPool.any(
            (event) => event is PaymentBroadcastedEvent,
          ),
          // you can be more specific if handled the proper error event, such as PaymentFailedEvent
          isFailed: _eventsPool.any((event) => event is PosErrorEvent),
        ),
        _bulletPointStatus(
          text: 'Checking the transaction status...',
          isLoading: currentEvent is PaymentBroadcastedEvent,
          isActive: _eventsPool.any((event) => event is PaymentSuccessfulEvent),
          isFailed: _eventsPool.any((event) => event is PosErrorEvent),
        ),
      ],
    );
  }

  Widget _bulletPointStatus({
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

  void _showDialogEvent(String title, String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [DtcRestartButton()],
        );
      },
    );
  }
}

class _PaymentInfoWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentInfo = ref.watch(paymentInfoProvider);
    return DtcCard(
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
            '${paymentInfo.token.symbol.toUpperCase()} on ${paymentInfo.token.network.name}',
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
    );
  }
}
