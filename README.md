# **Reown - Flutter**

The communications protocol for web3, Reown brings the ecosystem together by enabling hundreds of wallets and apps to securely connect and interact. This repository contains Flutter implementation of WalletConnect protocol for Flutter applications.

## SDK Chart

| [Core SDK](packages/reown_core) | [Sign SDK](packages/reown_sign) | [WalletKit](packages/reown_walletkit) | [AppKit](packages/reown_appkit) |
|---------------------------------|---------------------------------|---------------------------------------|---------------------------------|
| 1.0.4                           | 1.0.4                           | 1.0.3                                 | 1.0.1                           |

## License

Reown is released under the Apache 2.0 license. [See LICENSE](/LICENSE) for details.

### To try this repo out

```
1. git clone https://github.com/reown-com/reown_flutter.git
2. cd reown_flutter
3. sh scripts/generate_all.sh
```

### Run WalletKit Sample

1. Run `cd packages/reown_walletkit/example`
2. Run `flutter run --dart-define="PROJECT_ID=0123..." --flavor internal`

You can add your own keys for testing purposes as follows:

`--dart-define=ETH_SECRET_KEY=your mnemonic phrase....`

`--dart-define=KADENA_SECRET_KEY=5fgQC1.........`

`--dart-define=KADENA_ADDRESS=5fgQC1.........`

`--dart-define=SOLANA_SECRET_KEY=5fgQC1.........`

`--dart-define=SOLANA_ADDRESS=DbfmtKwL.........`

`--dart-define=POLKADOT_MNEMONIC=your mnemonic phrase....`

`--dart-define=POLKADOT_ADDRESS=DbfmtKwL.........`

_NB: WalletKit sample is intended to be used just as an explanatory project_


### Run AppKit Sample

1. Run `cd packages/reown_appkit/example/base`
2. Run `flutter run --dart-define="PROJECT_ID=0123..." --flavor internal`

### Test Sample Dapp and Wallet

- Sample Wallet:
  - [Sample Wallet for iOS](https://testflight.apple.com/join/Uv0XoBuD)
  - [Sample Wallet for Android](https://appdistribution.firebase.dev/i/2b8b3dce9e2831cd)
- AppKit DApp:
  - [AppKit Dapp for iOS](https://testflight.apple.com/join/6aRJSllc)
  - [AppKit Dapp for Android](https://appdistribution.firebase.dev/i/2c6573f6956fa7b5)