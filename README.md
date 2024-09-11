# **Reown - Flutter**

The communications protocol for web3, Reown brings the ecosystem together by enabling hundreds of wallets and apps to securely connect and interact. This repository contains Flutter implementation of WalletConnect protocol for Flutter applications.

## SDK Chart

| [Core SDK](packages/reown_core) | [Sign SDK](packages/reown_sign) | [WalletKit](packages/reown_walletkit) | [AppKit](packages/reown_appkit) |
|--------------------------|---------------------------|--------------------------------|--------------------------|
| 1.0.0                    | 1.0.0                     | 1.0.0                          | 1.0.0                    |

## License

Reown is released under the Apache 2.0 license. [See LICENSE](/LICENSE) for details.

### Run

1. Run `sh scripts/generate_all.sh` in the root folder to generate dependencies.
2. Run `cd packages/reown_walletkit/example`
3. Run `flutter run --dart-define=PROJECT_ID=0123... --flavor internal --debug`

You can add your own keys for testing purposes as follows:

`--dart-define=ETH_SECRET_KEY=your mnemonic phrase....`

`--dart-define=KADENA_SECRET_KEY=5fgQC1.........`

`--dart-define=KADENA_ADDRESS=5fgQC1.........`

`--dart-define=SOLANA_SECRET_KEY=5fgQC1.........`

`--dart-define=SOLANA_ADDRESS=DbfmtKwL.........`

`--dart-define=POLKADOT_MNEMONIC=your mnemonic phrase....`

`--dart-define=POLKADOT_ADDRESS=DbfmtKwL.........`
