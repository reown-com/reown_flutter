# ReownPos SDK

A Flutter SDK for implementing Point of Sale (POS) cryptocurrency payments using the Reown ecosystem. This SDK enables merchants to accept crypto payments by generating QR codes that customers can scan with their Reown wallet.

## Features

- **Multi-token Support**: Support for major stablecoins
- **Event-driven Architecture**: Real-time payment status updates through events
- **Secure Transactions**: Built-in transaction validation and status checking
- **Easy Integration**: Simple API for Flutter applications

## Getting Started

### Prerequisites

- Flutter 3.0 or higher
- A Reown project ID (get one from [Reown](https://reown.com))

### Installation

Add the package to your `pubspec.yaml` using the git repository (as the SDK is not yet published):

```yaml
dependencies:
  reown_pos:
    git:
      url: https://github.com/reown-com/reown_flutter.git
      path: packages/reown_pos
```

## Usage

### 1. Create the SDK instance

```dart
import 'package:reown_pos/reown_pos.dart';

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
    network: PosNetwork(name: 'Ethereum', chainId: 'eip155:1'),
    symbol: 'USDC',
    standard: 'erc20', // Token standard (erc20 for EVM tokens)
    address: '0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48', // USDC contract address on Ethereum
  ),
  PosToken(
    network: PosNetwork(name: 'Polygon', chainId: 'eip155:137'),
    symbol: 'USDC',
    standard: 'erc20',
    address: '0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174', // USDC contract address on Polygon
  ),
];

// Set the tokens (this automatically configures supported networks)
reownPos.setTokens(tokens: tokens);

// Your configured tokens can be then accessed with
final myConfiguredTokens = reownPos.configuredTokens;
```

### 3. Subscribe to events

```dart
// Subscribe to events to update the UI accordingly
reownPos.onPosEvent.subscribe(_onPosEvent);
```

### 4. Initialize the SDK

```dart
// Initialize the SDK (this starts the core services)
await reownPos.init();
```

### 5. Create Payment Intent

```dart
// Create a payment intent
final paymentIntent = PaymentIntent(
  token: PosToken(
    network: PosNetwork(name: 'Ethereum', chainId: 'eip155:1'),
    symbol: 'USDC',
    standard: 'erc20',
    address: '0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48',
  ),
  amount: '25.50', // Amount as string (e.g., "12.5")
  recipient: '0xYourMerchantAddress', // Your wallet address
);

// Create the payment intent (this generates QR code)
await reownPos.createPaymentIntent(
  paymentIntents: [paymentIntent],
);
```

### 6. Handle Events

Subscribe to events to track the payment flow:

```dart
void _onPosEvent(PosEvent event) {
  if (event is QrReadyEvent) {
    // When payment intent is created and connection with the relay is established, this event will contain the pairing URI to create the QR.
    // You can use your own QR Widget but `QrImageView(data: uri)` Widget is available for you to use.
    status += '1. Scan QR code with your wallet';
  } else if (event is ConnectRejectedEvent) {
    // User rejected the wallet connection
    status += '\n2. User rejected session';
  } else if (event is ConnectFailedEvent) {
    // Connection failed with error message
    status += '\n2. Connection failed: ${event.message}';
  } else if (event is ConnectedEvent) {
    // Customer connected their wallet upon scanning the QR code with the pairing URI
    status += '\n2. Connected!';
  } else if (event is PaymentRequestedEvent) {
    // Payment has been sent to the wallet for user approval
    status += '\n3. Requesting payment...';
  } else if (event is PaymentRequestRejectedEvent) {
    // User rejected the payment request
    status += '\n3. User rejected payment.';
  } else if (event is PaymentBroadcastedEvent) {
    // User approved the payment and transaction was broadcasted
    status += '\n4. Payment broadcasted, waiting confirmation...';
  } else if (event is PaymentFailedEvent) {
    // Payment failed with error message
    status += '\n4. Payment failed: ${event.message}';
  } else if (event is PaymentSuccessfulEvent) {
    // Payment has been confirmed on the blockchain
    status += '\n4. Payment successful!. Hash: ${event.txHash}';
  } else if (event is DisconnectedEvent) {
    // Session disconnected
    status += '\n5. Disconnected';
  }
}
```

### 7. Restart and Abort

The SDK provides a `restart()` function to handle payment flow interruptions and restarts:

```dart
// Abort current payment and restart the flow
await reownPos.restart();

// Full restart with reinitialization (clears all state)
await reownPos.restart(reinit: true);
```

**Use cases:**
- **Abort ongoing payment**: When a customer wants to cancel or restart the payment process
- **Payment completion**: After a successful or failed payment to prepare for the next transaction
- **Error recovery**: When you need to reset the SDK state due to errors
- **Full reset**: Use `reinit: true` to completely clear the instance and require calling `init()` and `setTokens()` again

**What happens during restart:**
- Completes any pending status checks
- Clears the current payment intent
- Expires previous pairings
- Aborts ongoing connection attempts
- Optionally clears all configuration when `reinit: true`

### 8. Complete and Working Example

Here's a complete example of a payment screen:

```dart
class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  PosEvent? _event;
  String status = '';
  late final IReownPos reownPos;

  @override
  void initState() {
    super.initState();
    // [ReownPos SDK API] 1. Construct your ReownPos instance
    final metadata = Metadata(
      merchantName: 'DTC Pay',
      description: 'Secure Crypto Payment Terminal',
      url: 'https://appkit-lab.reown.com',
      logoIcon: 'https://avatars.githubusercontent.com/u/179229932',
    );
    reownPos = ReownPos(
      projectId: '50f81661a58229027394e0a19e9db752',
      deviceId: "sample_pos_device_${DateTime.now().microsecondsSinceEpoch}",
      metadata: metadata,
    );
    // [ReownPos SDK API] 2. call setTokens to construct namespaces with your supported tokens and network
    reownPos.setTokens(
      tokens: [
        // USDC on Sepolia
        PosToken(
          network: PosNetwork(name: 'Sepolia ETH', chainId: 'eip155:11155111'),
          symbol: 'USDC',
          standard: 'erc20',
          address: '0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238',
        ),
      ],
    );

    // [ReownPos SDK API] 3. Subscribe to events
    reownPos.onPosEvent.subscribe(_onPosEvent);

    // [ReownPos SDK API] 4. initialize ReownPos SDK. Can be awaited if needed
    reownPos.init().then((_) {
      // [ReownPos SDK API] 5. create a payment intent with the PaymentIntent. Can be awaited if needed
      reownPos.createPaymentIntent(
        paymentIntents: [
          PaymentIntent(
            token: reownPos.configuredTokens.first,
            amount: '1.50',
            recipient: '0xD6d146ec0FA91C790737cFB4EE3D7e965a51c340',
          ),
        ],
      );
    });
  }

  void _onPosEvent(PosEvent event) {
    setState(() {
      if (event is QrReadyEvent) {
        status += '1. Scan QR code with your wallet';
      } else if (event is ConnectRejectedEvent) {
        status += '\n2. User rejected session';
      } else if (event is ConnectFailedEvent) {
        status += '\n2. Connection failed: ${event.message}';
      } else if (event is ConnectedEvent) {
        status += '\n2. Connected!';
      } else if (event is PaymentRequestedEvent) {
        status += '\n3. Requesting payment...';
      } else if (event is PaymentRequestRejectedEvent) {
        status += '\n3. User rejected payment.';
      } else if (event is PaymentBroadcastedEvent) {
        status += '\n4. Payment broadcasted, waiting confirmation...';
      } else if (event is PaymentFailedEvent) {
        status += '\n4. Payment failed: ${event.message}';
      } else if (event is PaymentSuccessfulEvent) {
        status += '\n4. Payment successful!. Hash: ${event.txHash}';
      } else if (event is DisconnectedEvent) {
        status += '\n5. Disconnected';
      }
      _event = event;
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
            (_event is QrReadyEvent)
                ? QrImageView(
                    data: (_event as QrReadyEvent).uri.toString(),
                    size: 250,
                  )
                : SizedBox.shrink(),
            SizedBox(height: 20),
            Padding(padding: const EdgeInsets.all(8.0), child: Text(status)),
          ],
        ),
      ),
    );
  }
}
```


## Event Types

- `QrReadyEvent` - QR code is ready for scanning
- `ConnectedEvent` - Customer wallet connected
- `ConnectRejectedEvent` - Connection rejected by customer
- `ConnectFailedEvent` - Connection failed
- `PaymentRequestedEvent` - Payment request sent to wallet
- `PaymentRequestRejectedEvent` - Payment request rejected by customer
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

## Additional Information

For more detailed examples, check the `/example` folder in this package. The example demonstrates a complete payment flow with UI components and state management.

### Model Structure

The SDK uses the following key models:

- **`PaymentIntent`**: Contains the token (with network info), amount, and recipient address
- **`PosToken`**: Represents a token with network, symbol, standard, and contract address
- **`PosNetwork`**: Defines a blockchain network with name and chain ID
- **`Metadata`**: Merchant information for the wallet connection


## Contributing

Contributions are welcome! Please feel free to submit issues and pull requests.

## License

This package is licensed under the terms specified in the LICENSE file.
