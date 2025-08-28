# ReownPos SDK

A Flutter SDK for implementing Point of Sale (POS) cryptocurrency payments using the Reown ecosystem. This SDK enables merchants to accept crypto payments by generating QR codes that customers can scan with their Reown wallet.

## Features

- **Multi-chain Support**: Support for major EVM networks (Ethereum, Polygon, BSC, Avalanche, Arbitrum, Optimism, Base, Fantom, Cronos, Polygon zkEVM, Sepolia)
- **QR Code Generation**: Automatic QR code generation for wallet connections
- **Event-driven Architecture**: Real-time payment status updates through events
- **Secure Transactions**: Built-in transaction validation and status checking
- **Easy Integration**: Simple API for Flutter applications

## Getting Started

### Prerequisites

- Flutter 3.0 or higher
- A Reown project ID (get one from [Reown](https://reown.com))
- Supported EVM-compatible networks

### Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  reown_pos: ^0.0.1 // At the moment of writing this docs
```

## Usage

### 1. Create the SDK instance

```dart
import 'package:reown_pos/reown_pos.dart';
import 'package:reown_pos/models/pos_models.dart';

// Create metadata for your merchant application
final metadata = Metadata(
  merchantName: 'Your Store Name',
  description: 'Secure Crypto Payment Terminal',
  url: 'https://yourstore.com',
  logoIcon: 'https://yourstore.com/logo.png',
);

// Initialize ReownPos instance
final reownPos = ReownPos(
  projectId: 'your_project_id_here',
  deviceId: 'unique_device_id',
  metadata: metadata,
);
```

### 2. Configure Supported Tokens (and Networks)

```dart
// Define the tokens you want to accept
final tokens = [
  PosToken(
    network: PosNetwork.ethereum,
    symbol: 'USDC',
    address: '0xA0b86a33E6441b8c4C1C1b8Bc4C1C1b8Bc4C1C1b8', // USDC contract address
  ),
  PosToken(
    network: PosNetwork.polygon,
    symbol: 'MATIC',
    address: '0x0000000000000000000000000000000000000000', // Native token
  ),
];

// Set the tokens (this automatically configures supported networks)
reownPos.setTokens(tokens: tokens);
```

### 3. Initialize the SDK

```dart
// Initialize the SDK (this starts the core services)
await reownPos.init();
```

### 4. Create Payment Intent

```dart
// Create a payment intent
final paymentIntent = PaymentIntent(
  token: '0xA0b86a33E6441b8c4C1C1b8Bc4C1C1b8Bc4C1C1b8', // Token contract address
  amount: '25.50', // Amount as string
  chainId: 'eip155:1', // Ethereum mainnet
  recipient: '0xYourMerchantAddress', // Your wallet address
);

// Create the payment intent (this generates QR code)
await reownPos.createPaymentIntent(
  paymentIntents: [paymentIntent],
);
```

### 5. Handle Events

Subscribe to events to track the payment flow:

```dart
// Subscribe to POS events
reownPos.onPosEvent.subscribe((event) {
  if (event is QrReadyEvent) {
    // QR code is ready - display it to customer
    print('QR Code ready: ${event.uri}');
  } else if (event is ConnectedEvent) {
    // Customer connected their wallet
    print('Wallet connected');
  } else if (event is PaymentRequestedEvent) {
    // Payment request sent to wallet
    print('Payment requested');
  } else if (event is PaymentSuccessfulEvent) {
    // Payment successful
    print('Payment successful! TX Hash: ${event.txHash}');
  } else if (event is PaymentFailedEvent) {
    // Payment failed
    print('Payment failed: ${event.message}');
  } else if (event is PaymentRejectedEvent) {
    // Customer rejected payment
    print('Payment rejected by customer');
  }
});
```

### 6. Complete Example

Here's a complete example of a payment screen:

```dart
class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Uri? qrUri;
  String status = 'Waiting for connection...';

  @override
  void initState() {
    super.initState();
    
    // Subscribe to events
    reownPos.onPosEvent.subscribe(_onPosEvent);
    
    // Create payment intent
    _createPayment();
  }

  void _createPayment() async {
    final paymentIntent = PaymentIntent(
      token: '0xA0b86a33E6441b8c4C1C1b8Bc4C1C1b8Bc4C1C1b8',
      amount: '25.50',
      chainId: 'eip155:1',
      recipient: '0xYourMerchantAddress',
    );

    await reownPos.createPaymentIntent(
      paymentIntents: [paymentIntent],
    );
  }

  void _onPosEvent(PosEvent event) {
    setState(() {
      if (event is QrReadyEvent) {
        qrUri = event.uri;
        status = 'Scan QR code with your wallet';
      } else if (event is ConnectedEvent) {
        status = 'Wallet connected, processing payment...';
      } else if (event is PaymentSuccessfulEvent) {
        status = 'Payment successful! TX: ${event.txHash}';
      } else if (event is PaymentFailedEvent) {
        status = 'Payment failed: ${event.message}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crypto Payment')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (qrUri != null)
              QrImageView(
                data: qrUri.toString(),
                size: 250,
              ),
            SizedBox(height: 20),
            Text(status),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    reownPos.dispose();
    super.dispose();
  }
}
```

## Supported Networks

The SDK currently supports EVM networks

## Event Types

- `QrReadyEvent` - QR code is ready for scanning
- `ConnectedEvent` - Customer wallet connected
- `ConnectRejectedEvent` - Connection rejected by customer
- `ConnectFailedEvent` - Connection failed
- `PaymentRequestedEvent` - Payment request sent to wallet
- `PaymentBroadcastedEvent` - Transaction broadcasted to network
- `PaymentSuccessfulEvent` - Payment confirmed on blockchain
- `PaymentFailedEvent` - Payment failed
- `PaymentRejectedEvent` - Payment rejected by customer
- `DisconnectedEvent` - Session disconnected

## Error Handling

The SDK provides comprehensive error handling through events. Always subscribe to events to handle:

- Connection failures
- Payment rejections
- Transaction failures
- Network issues

## Cleanup

Don't forget to dispose of the SDK when you're done:

```dart
@override
void dispose() {
  reownPos.dispose();
  super.dispose();
}
```

## Additional Information

For more detailed examples, check the `/example` folder in this package. The example demonstrates a complete payment flow with UI components and state management.

## Contributing

Contributions are welcome! Please feel free to submit issues and pull requests.

## License

This package is licensed under the terms specified in the LICENSE file.
