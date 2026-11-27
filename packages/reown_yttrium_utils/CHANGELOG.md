## 0.0.4

- iOS: add Swift Package Manager support. The plugin now ships `ios/reown_yttrium_utils/Package.swift` and still ships the podspec, so apps work with either dependency manager.
- iOS: bumped Yttrium Utils to 0.10.59 (YttriumUtilsWrapper pod and Swift package), the same Yttrium version `walletconnect_pay` uses. Swift Package Manager resolves one Yttrium version per app.

## 0.0.3

- Bumped Yttrium Utils to 0.10.58 (Android) / 0.10.57 (iOS).
- Raised the minimum Android SDK to 23 to align with `reown_core`'s
  `flutter_secure_storage` v10 dependency.

## 0.0.2

- LICENSE UPDATE

## 0.0.1

- Initial release with methods:
  - erc20TokenBalance()
  - estimateFees()
  - prepareDetailed()
  - execute()
