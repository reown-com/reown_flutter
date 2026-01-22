import 'package:flutter/material.dart' hide Action;
import 'package:walletconnect_pay/walletconnect_pay.dart';

void main() {
  runApp(const WalletConnectPayExampleApp());
}

class WalletConnectPayExampleApp extends StatelessWidget {
  const WalletConnectPayExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WalletConnect Pay Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3396FF)),
        useMaterial3: true,
      ),
      home: const PaymentPage(),
    );
  }
}

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  static const wcpApiKey = String.fromEnvironment('WCP_API_KEY');

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late final WalletConnectPay _payClient;
  bool _isInitialized = false;
  bool _isLoading = false;
  String? _error;

  final _paymentLinkController = TextEditingController();
  final _accountsController = TextEditingController(
    text: 'eip155:137:0xD6d146ec0FA91C790737cFB4EE3D7e965a51c340',
  );

  PaymentOptionsResponse? _paymentOptions;
  PaymentOption? _selectedOption;

  @override
  void initState() {
    super.initState();
    _initSdk();
  }

  @override
  void dispose() {
    _paymentLinkController.dispose();
    _accountsController.dispose();
    super.dispose();
  }

  Future<void> _initSdk() async {
    _payClient = WalletConnectPay(apiKey: PaymentPage.wcpApiKey);
    try {
      final success = await _payClient.init();
      setState(() => _isInitialized = success);
    } on PayInitializeError catch (e) {
      setState(() => _error = 'Init failed [${e.code}]: ${e.message}');
    }
  }

  Future<void> _getPaymentOptions() async {
    final link = _paymentLinkController.text.trim();
    final accounts = _accountsController.text
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    if (link.isEmpty || accounts.isEmpty) {
      setState(() => _error = 'Enter payment link and accounts');
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await _payClient.getPaymentOptions(
        request: GetPaymentOptionsRequest(
          paymentLink: link,
          accounts: accounts,
          includePaymentInfo: true,
        ),
      );
      setState(() {
        _paymentOptions = response;
        _isLoading = false;
      });
    } on GetPaymentOptionsError catch (e) {
      setState(() {
        _error = 'code: ${e.code}\nmessage: ${e.message}';
        _isLoading = false;
      });
    }
  }

  Future<void> _selectOption(PaymentOption option) async {
    setState(() {
      _selectedOption = option;
      _isLoading = true;
    });

    try {
      List<Action> actions = option.actions;
      if (actions.isEmpty) {
        actions = await _payClient.getRequiredPaymentActions(
          request: GetRequiredPaymentActionsRequest(
            optionId: option.id,
            paymentId: _paymentOptions!.paymentId,
          ),
        );
      }
      setState(() => _isLoading = false);

      if (mounted) {
        final confirm = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Confirm Payment'),
            content: Text('${actions.length} action(s) to sign'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Confirm'),
              ),
            ],
          ),
        );
        if (confirm == true) _confirmPayment(actions);
      }
    } on GetRequiredActionsError catch (e) {
      setState(() {
        _error = 'code: ${e.code}\nmessage: ${e.message}';
        _isLoading = false;
      });
    }
  }

  Future<void> _confirmPayment(List<Action> actions) async {
    setState(() => _isLoading = true);

    try {
      final signatures = actions.map((_) => '0xsimulated').toList();
      var response = await _payClient.confirmPayment(
        request: ConfirmPaymentRequest(
          paymentId: _paymentOptions!.paymentId,
          optionId: _selectedOption!.id,
          signatures: signatures,
        ),
      );

      setState(() => _isLoading = false);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Payment ${response.status.name}'),
            backgroundColor: response.status == PaymentStatus.succeeded
                ? Colors.green
                : Colors.red,
          ),
        );
      }
    } on ConfirmPaymentError catch (e) {
      setState(() {
        _error = 'code: ${e.code}\nmessage: ${e.message}';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WalletConnect Pay')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : !_isInitialized
          ? Center(child: Text(_error ?? 'Initializing...'))
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                TextField(
                  controller: _paymentLinkController,
                  decoration: const InputDecoration(
                    labelText: 'Payment Link',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _accountsController,
                  decoration: const InputDecoration(
                    labelText: 'Accounts (CAIP-10, comma-separated)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: _getPaymentOptions,
                  child: const Text('Get Payment Options'),
                ),
                if (_error != null) ...[
                  const SizedBox(height: 12),
                  Text(_error!, style: const TextStyle(color: Colors.red)),
                ],
                if (_paymentOptions != null) ...[
                  const SizedBox(height: 24),
                  if (_paymentOptions!.info != null)
                    _PaymentInfoCard(info: _paymentOptions!.info!),
                  const SizedBox(height: 16),
                  ..._paymentOptions!.options.map(
                    (opt) => _PaymentOptionCard(
                      option: opt,
                      isSelected: _selectedOption?.id == opt.id,
                      onTap: () => _selectOption(opt),
                    ),
                  ),
                ],
              ],
            ),
    );
  }
}

class _PaymentInfoCard extends StatelessWidget {
  const _PaymentInfoCard({required this.info});

  final PaymentInfo info;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              info.merchant.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              info.amount.formatAmount(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text('Status: ${info.status.name}'),
          ],
        ),
      ),
    );
  }
}

class _PaymentOptionCard extends StatelessWidget {
  const _PaymentOptionCard({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  final PaymentOption option;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? Theme.of(context).colorScheme.primaryContainer : null,
      child: ListTile(
        title: Text(option.amount.formatAmount()),
        subtitle: Text('ETA: ${option.etaSeconds}s'),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
