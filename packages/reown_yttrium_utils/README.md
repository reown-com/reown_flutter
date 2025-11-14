# Reown Yttrium

A Flutter plugin that provides blockchain interaction capabilities through the Reown platform, built on top of the WalletConnect Network. This plugin is part of the Yttrium ecosystem, a cross-platform library designed for working with smart accounts in the Ethereum ecosystem.

## Overview

Reown Yttrium is a powerful Flutter plugin that enables seamless blockchain interactions in your Flutter applications. It provides essential abstractions and primitives for Wallets and DApps to interact with and implement smart account functionality. A primary goal is to enable externally owned account (EOA) wallets to offer advanced features such as batch transactions and transaction sponsorship to their users.

## Features

- ERC20 token balance checking
- EIP-1559 transaction fee estimation
- Transaction preparation and execution
- Smart account support
- Cross-platform support (iOS and Android)
- Built on the WalletConnect Network

## Standards Support

The plugin implements the following Ethereum standards:
- ERC-4337 (in development)
- ERC-7702 (in development)

## Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  reown_yttrium_utils: ^0.0.1
```

## Platform Requirements

- iOS: 13.0 or higher
- Android: API level 21 or higher

## Usage

### Initialization

First, initialize the plugin with your project ID and pulse metadata:

```dart
final yttriumUtils = ReownYttriumUtils();

await yttriumUtils.init(
  projectId: 'your_project_id',
  pulseMetadata: pulseMetadata,
);
```

### Check ERC20 Token Balance

```dart
final balance = await yttriumUtils.erc20TokenBalance(
  chainId: 'chain_id',
  token: 'token_address',
  owner: 'owner_address',
);
```

### Estimate Transaction Fees

```dart
final fees = await yttriumUtils.estimateFees(
  chainId: 'chain_id',
);
```

### Prepare Transaction

```dart
final preparedTx = await yttriumUtils.prepareDetailed(
  chainId: 'chain_id',
  from: 'from_address',
  call: call,
  localCurrency: currency,
);
```

### Execute Transaction

```dart
final executionDetails = await yttriumUtils.execute(
  uiFields: uiFields,
  routeTxnSigs: routeTxnSigs,
  initialTxnSig: initialTxnSig,
);
```

## Architecture

This Flutter plugin is built on top of the Yttrium core library, which is written in Rust and provides the following architecture:

```
Core Rust Library
    ↓
Native Library (iOS/Android)
    ↓
Flutter Plugin
```

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Support

For support, please visit:
- [Reown Flutter Repository](https://github.com/reown-com/reown_flutter)
- [Yttrium Core Repository](https://github.com/reown-com/yttrium)

