# walletconnect_pay

A Flutter plugin for integrating WalletConnect Pay — enabling merchants, PSPs, and wallets to embed crypto payments into their Flutter apps.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Installation](#installation)
- [Quick Start](#quick-start)
  - [Initialization](#initialization)
  - [Get Payment Options](#get-payment-options)
  - [Get Required Payment Actions](#get-required-payment-actions)
  - [Confirm Payment](#confirm-payment)
- [API Reference](#api-reference)
- [Models](#models)
- [Error Handling](#error-handling)
- [Platform Support](#platform-support)
- [Examples](#examples)
- [License](#license)

## Introduction

`walletconnect_pay` is a Flutter plugin that provides a complete payment SDK for integrating WalletConnect Pay into Flutter applications. It enables merchants, payment service providers (PSPs), and wallets to accept crypto and stablecoin payments across multiple assets and blockchain networks.

This SDK simplifies:
- Checkout / eCommerce crypto payments
- Point-of-Sale (POS) solutions
- Built-in wallet integration

## Features

- ✅ Accept any stablecoin or crypto asset via wallets
- ✅ Cross-platform support (iOS, Android)
- ✅ Payment status tracking with polling support
- ✅ Data collection for compliance (KYB/KYC)
- ✅ Support for multiple blockchain networks
- ✅ Type-safe models with Freezed

## Installation

Add `walletconnect_pay` to your `pubspec.yaml`:

```yaml
dependencies:
  walletconnect_pay: ^0.0.1
```

Then run:

```bash
flutter pub get
```

### Platform Setup

#### iOS

Add the following to your `ios/Podfile`:

```ruby
platform :ios, '13.0'
```

#### Android

Ensure your `android/app/build.gradle` has:

```gradle
android {
    minSdkVersion 23
}
```

## Quick Start

### Initialization

First, initialize the `WalletConnectPay` client with your app ID and client ID or just API key:

```dart
import 'package:walletconnect_pay/walletconnect_pay.dart';

// Initialize WalletConnect Pay. Either apiKey or appId must be passed
final payClient = WalletConnectPay(
  apiKey: 'YOUR_API_KEY', // Optional
  appId: 'YOUR_APP_ID', // Optional
  clientId: 'OPTIONAL_CLIENT_ID', // Optional
  baseUrl: 'https://api.pay.walletconnect.com', // Optional
);

// Initialize the SDK
try {
  await payClient.init();
} on PayInitializeError catch (e) {
  // Handle initialization error
}
```

### Get Payment Options 

Retrieve available payment options for a payment link:

```dart
final request = GetPaymentOptionsRequest(
  paymentLink: 'https://pay.walletconnect.com/pay_123',
  accounts: ['eip155:1:0x...', 'eip155:137:0x...'], // User's wallet CAIP-10 accounts
  includePaymentInfo: true, // Include payment details in response
);

final response = await payClient.getPaymentOptions(request: request);

// Access payment information
print('Payment ID: ${response.paymentId}');
print('Options available: ${response.options.length}');

if (response.info != null) {
  print('Amount: ${response.info!.amount.formatAmount()}');
  print('Status: ${response.info!.status}');
  print('Merchant: ${response.info!.merchant.name}');
}

// Check if data collection is required
if (response.collectData != null) {
  print('Data collection required: ${response.collectData!.fields.length} fields');
}
```

### Get Required Payment Actions

Get the required wallet actions (e.g., transactions to sign) for a selected payment option:

```dart
final actionsRequest = GetRequiredPaymentActionsRequest(
  optionId: response.options.first.id, // Or whatever other option chosen by the user
  paymentId: response.paymentId,
);
final actions = await payClient.getRequiredPaymentActions(
  request: actionsRequest,
);

// Process each action (e.g., sign transactions)
for (final action in actions) {
  final walletRpc = action.walletRpc;
  print('Chain ID: ${walletRpc.chainId}');
  print('Method: ${walletRpc.method}');
  print('Params: ${walletRpc.params}');
  
  // Sign the transaction using your wallet SDK
  // final signature = await signTransaction(walletRpc);
}
```

### Confirm Payment

Confirm a payment with signatures and optional collected data:

```dart
final confirmRequest = ConfirmPaymentRequest(
  paymentId: response.paymentId,
  optionId: response.options.first.id,
  signatures: ['0x...', '0x...'], // Signatures from wallet actions
  collectedData: [
    CollectDataFieldResult(
      id: 'fullName',
      value: 'John Doe',
    ),
    CollectDataFieldResult(
      id: 'dob',
      value: '1990-01-01',
    ),
  ], // Optional: if data collection was required
  maxPollMs: 60000, // Optional: max polling time in milliseconds
);

final confirmResponse = await payClient.confirmPayment(request: confirmRequest);

print('Payment Status: ${confirmResponse.status}');
print('Is Final status: ${confirmResponse.isFinal}');

if (!confirmResponse.isFinal && confirmResponse.pollInMs != null) {
  // Poll again after the specified interval
  await Future.delayed(Duration(milliseconds: confirmResponse.pollInMs!));
  // Re-confirm or check status
}
```

## API Reference

### WalletConnectPay

The main class for interacting with the WalletConnect Pay SDK.

#### Constructor

```dart
WalletConnectPay({
  String? apiKey,
  String? appId,
  String? clientId,
  String? baseUrl,
})
```

- `apiKey`: Optional WalletConnect Pay API key
- `appId`: Optional WalletConnect app ID
- `clientId`: Optional client identifier
- `baseUrl`: Optional base URL for the API. Defaults to `https://api.pay.walletconnect.com` if not provided

#### Methods

##### `Future<bool> init()`

Initializes the SDK. Returns `true` on success, throws an exception on failure.

##### `Future<PaymentOptionsResponse> getPaymentOptions({required GetPaymentOptionsRequest request})`

Retrieves available payment options for a payment link.

##### `Future<List<Action>> getRequiredPaymentActions({required GetRequiredPaymentActionsRequest request})`

Gets the required wallet actions for a payment option.

##### `Future<ConfirmPaymentResponse> confirmPayment({required ConfirmPaymentRequest request})`

Confirms a payment with signatures and optional collected data.

## Models

### GetPaymentOptionsRequest

```dart
GetPaymentOptionsRequest({
  required String paymentLink,
  required List<String> accounts,
  @Default(false) bool includePaymentInfo,
})
```

### PaymentOptionsResponse

```dart
PaymentOptionsResponse({
  required String paymentId,
  PaymentInfo? info,
  required List<PaymentOption> options,
  CollectDataAction? collectData,
})
```

### PaymentInfo

```dart
PaymentInfo({
  required PaymentStatus status,
  required PayAmount amount,
  required int expiresAt,
  required MerchantInfo merchant,
  BuyerInfo? buyer,
})
```

### PaymentOption

```dart
PaymentOption({
  required String id,
  required String account,
  required PayAmount amount,
  @JsonKey(name: 'etaS') required int etaSeconds,
  required List<Action> actions,
})
```

### ConfirmPaymentRequest

```dart
ConfirmPaymentRequest({
  required String paymentId,
  required String optionId,
  required List<String> signatures,
  List<CollectDataFieldResult>? collectedData,
  int? maxPollMs,
})
```

### ConfirmPaymentResponse

```dart
ConfirmPaymentResponse({
  required PaymentStatus status,
  required bool isFinal,
  int? pollInMs,
})
```

### PaymentStatus

```dart
enum PaymentStatus {
  requires_action,
  processing,
  succeeded,
  failed,
  expired,
}
```

## Error Handling

The SDK throws specific exception types for different error scenarios:

- `PayInitializeError`: Initialization failures
- `GetPaymentOptionsError`: Errors when fetching payment options
- `GetRequiredActionError`: Errors when getting required actions
- `ConfirmPaymentError`: Errors when confirming payment

All errors extend `PlatformException` and include:
- `code`: Error code
- `message`: Error message
- `details`: Additional error details
- `stacktrace`: Stack trace

Example error handling:

```dart
try {
  final response = await payClient.getPaymentOptions(request: request);
} on GetPaymentOptionsError catch (e) {
  print('Error code: ${e.code}');
  print('Error message: ${e.message}');
  // Handle error
} catch (e) {
  print('Unexpected error: $e');
}
```

## Platform Support

- ✅ iOS 13.0+
- ✅ Android API 23+

## Examples

For a complete example implementation, see the [example](./example/lib/) folder

## License

See [LICENSE](LICENSE) file for details.