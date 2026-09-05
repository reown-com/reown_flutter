## 1.5.0

- Added Stellar TVF support: compute the transaction hash from signed `stellar_signXDR` envelopes (V0, V1 and fee-bump) and extract `tx_hash` from `stellar_signAndSubmitXDR` responses.

## 1.4.0

- Upgraded `flutter_secure_storage` to `^10.0.0`. Existing data stored via the
  deprecated Android `EncryptedSharedPreferences` (v9.x) is migrated
  automatically to the new custom-cipher storage on first access; no action is
  required from integrators.
- Disabled the Android `resetOnError` option so a read/decrypt error no longer
  wipes the entire shared secure-storage backing store.
- **Breaking (Android):** `flutter_secure_storage` v10 raises the minimum
  Android SDK to 23.

## 1.3.8

- Dependency updates

## 1.3.7

- Minor improvements

## 1.3.6

- Analytics enhancements

## 1.3.3

- Security Improvements

## 1.3.1

- Bug fixes

## 1.3.0

- LICENSE UPDATE

## 1.2.1

- Minor improvements

## 1.2.0

- New relay methods for latency improvements

## 1.1.7

- Minor update

## 1.1.6+1

- General security improvements and verify API V4 readiness

## 1.1.5

- Link Mode enhancements

## 1.1.4+1

- Dependency updates

## 1.1.4

- Dependency updates

## 1.1.3

- Minor improvements

## 1.1.2

- General security improvements and verify API V4 readiness

## 1.1.1

- Minor changes

## 1.1.0

- Update to flutter version 3.24.5
- Dependency updates
- Important bug fixes

## 1.0.4

- Minor change
  
## 1.0.3

- Better logs

## 1.0.1

- Minor change

## 1.0.0

- Initial release.