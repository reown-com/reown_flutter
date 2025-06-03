# **Reown - Flutter**

The communications protocol for web3, Reown brings the ecosystem together by enabling hundreds of wallets and apps to securely connect and interact. This repository contains Flutter implementation of WalletConnect protocol for Flutter applications.

## Published SDKs

https://pub.dev/publishers/reown.com/packages

## Documentation

AppKit: https://docs.reown.com/appkit/flutter/core/installation

WalletKit: https://docs.reown.com/walletkit/flutter/installation

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

The wallet will generate a random keys for evm, solana, polkadot, kadena, tron and cosmos

You will be able to restore your own key if wanted

_NB: WalletKit sample is intended to be used just as an explanatory project_

You can also download our Flutter Sample Wallet at:
  - [Testflight for iOS](https://testflight.apple.com/join/Uv0XoBuD)
  - [Firebase App Distribution for Android](https://appdistribution.firebase.dev/i/8e6452c6bbd68911)

### Run AppKit Sample

1. Run `cd packages/reown_appkit/example/base`
2. Run `flutter run --dart-define="PROJECT_ID=0123..." --flavor internal`


You can also download our Flutter Sample Dapp at:
  - [Testflight for iOS](https://testflight.apple.com/join/6aRJSllc)
  - [Firebase App Distribution for Android](https://appdistribution.firebase.dev/i/52c9b87bbf5fbe01)
