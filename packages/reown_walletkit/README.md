# **Reown - WalletKit Flutter**

<img src="https://raw.githubusercontent.com/reown-com/reown_flutter/refs/heads/develop/assets/reown_logo.jpg" height="100"> <img src="https://raw.githubusercontent.com/reown-com/reown_flutter/refs/heads/develop/assets/walletkit_logo_long.png" height="100">

Reown is the onchain UX platform that provides toolkits built on top of the WalletConnect Network that enable builders to create onchain user experiences that make digital ownership effortless, intuitive, and secure.

The WalletKit SDK streamlines the integration process, making it easier for wallet developers to include authentication and transaction signing features.

Read more about it on our [website](https://reown.com)

## Documentation

For a full reference please check the [Official Documentation](https://docs.reown.com/walletkit/flutter/installation)

## Example

Please check the [example](https://github.com/reown-com/reown_flutter/tree/master/packages/reown_walletkit/example) folder for the example.

## Installation

Add `reown_walletkit` to your `pubspec.yaml`:

```yaml
dependencies:
  reown_walletkit: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Quick Start

### Initialization

```dart
import 'package:reown_walletkit/reown_walletkit.dart';

final walletKit = await ReownWalletKit.createInstance(
  projectId: 'YOUR_PROJECT_ID',
  metadata: PairingMetadata(
    name: 'My Wallet',
    description: 'My Wallet App',
    url: 'https://mywallet.com',
    icons: ['https://mywallet.com/icon.png'],
  ),
);
```

### Pairing

To pair with a dApp, use the `pair` method with a WalletConnect URI:

```dart
final pairingInfo = await walletKit.pair(uri: Uri.parse(wcUri));
```

## Session Management

### Handling Session Proposals

Listen for incoming session proposals from dApps:

```dart
walletKit.onSessionProposal.subscribe((SessionProposalEvent? event) {
  if (event != null) {
    final proposal = event.params;
    // Display proposal to user and handle approval/rejection
    print('Received proposal from: ${proposal.proposer.metadata.name}');
  }
});
```

### Approving Sessions

Approve a session proposal with specified namespaces:

```dart
final response = await walletKit.approveSession(
  id: proposal.id,
  namespaces: {
    'eip155': Namespace(
      accounts: ['eip155:1:0x1234...', 'eip155:137:0x1234...'],
      methods: ['eth_sendTransaction', 'personal_sign', 'eth_signTypedData'],
      events: ['chainChanged', 'accountsChanged'],
    ),
  },
);
```

### Rejecting Sessions

Reject a session proposal:

```dart
await walletKit.rejectSession(
  id: proposal.id,
  reason: Errors.getSdkError(Errors.USER_REJECTED),
);
```

### Updating Sessions

Update session namespaces (e.g., when user adds a new account):

```dart
await walletKit.updateSession(
  topic: session.topic,
  namespaces: updatedNamespaces,
);
```

### Extending Sessions

Extend a session's expiry time:

```dart
await walletKit.extendSession(topic: session.topic);
```

### Disconnecting Sessions

Disconnect from a session:

```dart
await walletKit.disconnectSession(
  topic: session.topic,
  reason: Errors.getSdkError(Errors.USER_DISCONNECTED),
);
```

### Getting Active Sessions

Retrieve all active sessions:

```dart
final sessions = walletKit.getActiveSessions();
for (final entry in sessions.entries) {
  print('Session topic: ${entry.key}');
  print('Peer: ${entry.value.peer.metadata.name}');
}
```

## Request Handling

### Registering Request Handlers

Register handlers for specific methods:

```dart
walletKit.registerRequestHandler(
  chainId: 'eip155:1',
  method: 'personal_sign',
  handler: (String topic, dynamic params) async {
    // Handle the signing request
    // Return the signature
    return '0xsignature...';
  },
);
```

### Listening for Session Requests

Listen for incoming session requests:

```dart
walletKit.onSessionRequest.subscribe((SessionRequestEvent? event) {
  if (event != null) {
    final request = event.params;
    print('Method: ${request.method}');
    print('Params: ${request.params}');
    // Handle the request
  }
});
```

### Responding to Requests

Respond to a session request:

```dart
// Success response
await walletKit.respondSessionRequest(
  topic: request.topic,
  response: JsonRpcResponse(
    id: request.id,
    result: '0xsignature...',
  ),
);

// Error response
await walletKit.respondSessionRequest(
  topic: request.topic,
  response: JsonRpcResponse(
    id: request.id,
    error: JsonRpcError(code: -32000, message: 'User rejected'),
  ),
);
```

## Event Management

### Registering Event Emitters

Register event emitters for session namespaces:

```dart
walletKit.registerEventEmitter(
  chainId: 'eip155:1',
  event: 'accountsChanged',
);
```

### Emitting Session Events

Emit events to connected dApps (e.g., account change):

```dart
await walletKit.emitSessionEvent(
  topic: session.topic,
  chainId: 'eip155:1',
  event: SessionEventParams(
    name: 'accountsChanged',
    data: ['0xnewAddress...'],
  ),
);
```

### Listening for Session Events

```dart
walletKit.onSessionDelete.subscribe((SessionDelete? event) {
  if (event != null) {
    print('Session deleted: ${event.topic}');
  }
});

walletKit.onSessionExpire.subscribe((SessionExpire? event) {
  if (event != null) {
    print('Session expired: ${event.topic}');
  }
});
```

## WalletConnect Pay

`ReownWalletKit` includes built-in support for WalletConnect Pay, enabling your wallet to process crypto payments. The `WalletConnectPay` client is automatically initialized during `ReownWalletKit.init()`.

### Accessing the Pay Client

You can access the `WalletConnectPay` instance directly:

```dart
final payClient = walletKit.pay;
```

### Payment Link Detection

Detect if a URI is a payment link before processing:

```dart
if (walletKit.isPaymentLink(uri)) {
  // Handle as payment. See [Get Payment Options] section
} else {
  // Handle as regular WalletConnect pairing
  await walletKit.pair(uri: Uri.parse(uri));
}
```

#### Get Payment Options

```dart
final response = await walletKit.getPaymentOptions(
  request: GetPaymentOptionsRequest(
    paymentLink: 'https://pay.walletconnect.com/pay_123',
    accounts: ['eip155:1:0x...', 'eip155:137:0x...'], // Wallet's CAIP-10 accounts
    includePaymentInfo: true,
  ),
);

print('Payment ID: ${response.paymentId}');
print('Options available: ${response.options.length}');
if (response.info != null) {
  print('Amount: ${response.info!.amount.formatAmount()}');
  print('Merchant: ${response.info!.merchant.name}');
}
```

#### Get Required Payment Actions

```dart
final actions = await walletKit.getRequiredPaymentActions(
  request: GetRequiredPaymentActionsRequest(
    optionId: 'option-id',
    paymentId: 'payment-id',
  ),
);

// Process each action (e.g., sign transactions)
for (final action in actions) {
  final walletRpc = action.walletRpc;
  print('Chain ID: ${walletRpc.chainId}');
  print('Method: ${walletRpc.method}');
  // Sign the transaction using your wallet SDK
}
```

#### Confirm Payment

```dart
final confirmResponse = await walletKit.confirmPayment(
  request: ConfirmPaymentRequest(
    paymentId: 'payment-id',
    optionId: 'option-id',
    signatures: ['0x...', '0x...'], // Signatures from wallet actions
    collectedData: [
      CollectDataFieldResult(id: 'fullName', value: 'John Doe'),
      CollectDataFieldResult(id: 'dob', value: '1990-01-01'),
    ], // Optional: if data collection was required
    maxPollMs: 60000, // Maximum polling time in milliseconds
  ),
);

print('Payment Status: ${confirmResponse.status}');
print('Is Final: ${confirmResponse.isFinal}');
```

### Complete Payment Flow Example

Here's a complete example of processing a payment:

```dart
class PaymentService {
  final ReownWalletKit walletKit;

  PaymentService(this.walletKit);

  /// Process a payment from a payment link (e.g., after scanning QR code)
  Future<void> processPayment(String paymentLink) async {
    try {
      // Step 1: Get payment options
      final accounts = await getWalletAccounts(); // Your wallet accounts
      final optionsResponse = await walletKit.getPaymentOptions(
        request: GetPaymentOptionsRequest(
          paymentLink: paymentLink,
          accounts: accounts,
          includePaymentInfo: true,
        ),
      );

      if (optionsResponse.options.isEmpty) {
        throw Exception('No payment options available');
      }

      // Step 2: Collect additional data if required (KYB/KYC)
      final collectedData = <CollectDataFieldResult>[];
      if (optionsResponse.collectData != null) {
        for (final field in optionsResponse.collectData!.fields) {
          // Collect data from user (e.g., full name, date of birth)
          // Example: collectedData.add(CollectDataFieldResult(id: field.id, value: userInput));
        }
      }

      // Step 3: Select payment option (or let user choose)
      PaymentOption selectedOption = optionsResponse.options.first;
      final paymentId = optionsResponse.paymentId;
      final optionId = selectedOption.id;

      // Step 4: Get required payment actions (if not already in the option)
      List<Action> actions = selectedOption.actions;
      if (actions.isEmpty) {
        actions = await walletKit.getRequiredPaymentActions(
          request: GetRequiredPaymentActionsRequest(
            optionId: optionId,
            paymentId: paymentId,
          ),
        );
      }

      // Step 5: Execute wallet actions and collect signatures
      final signatures = <String>[];
      for (final action in actions) {
        // Sign the transaction using your wallet SDK
        // Example: signatures.add(await signTransaction(action.walletRpc));
      }

      // Step 6: Confirm payment with polling
      ConfirmPaymentResponse confirmResponse = await walletKit.confirmPayment(
        request: ConfirmPaymentRequest(
          paymentId: paymentId,
          optionId: optionId,
          signatures: signatures,
          collectedData: collectedData.isNotEmpty ? collectedData : null,
          maxPollMs: 60000, // Maximum polling time in milliseconds
        ),
      );

      // Step 7: Poll until final status (if needed)
      while (!confirmResponse.isFinal && confirmResponse.pollInMs != null) {
        await Future.delayed(Duration(milliseconds: confirmResponse.pollInMs!));
        confirmResponse = await walletKit.confirmPayment(
          request: ConfirmPaymentRequest(
            paymentId: paymentId,
            optionId: optionId,
            signatures: signatures,
            collectedData: collectedData.isNotEmpty ? collectedData : null,
            maxPollMs: 60000,
          ),
        );
      }

      // Handle final payment status
      switch (confirmResponse.status) {
        case PaymentStatus.succeeded:
          print('Payment succeeded!');
          break;
        case PaymentStatus.failed:
          throw Exception('Payment failed');
        case PaymentStatus.expired:
          throw Exception('Payment expired');
        case PaymentStatus.requires_action:
          throw Exception('Payment requires additional action');
        case PaymentStatus.processing:
          // Should not happen if isFinal is true
          break;
      }
    } catch (e) {
      print('Payment error: $e');
      rethrow;
    }
  }

  Future<List<String>> getWalletAccounts() async {
    // Return your wallet's CAIP-10 formatted accounts
    // Example: ['eip155:1:0x1234...', 'eip155:137:0x5678...']
    return [];
  }
}
```

### Example Implementation

For a complete example implementation with UI components showing the full payment flow, see the [reown_walletkit example](https://github.com/reown-com/reown_flutter/tree/master/packages/reown_walletkit/example/lib/walletconnect_pay).

The example demonstrates:
- Payment link detection and processing
- Payment options retrieval with UI
- Data collection for compliance (KYB/KYC)
- Payment details display
- Transaction signing and confirmation
- Payment status polling and result display

### Direct Access

You can also access the underlying `WalletConnectPay` instance directly if needed:

```dart
final payClient = walletKit.pay;
// Use payClient methods directly
final response = await payClient.getPaymentOptions(request: request);
```