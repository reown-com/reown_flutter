## 1.1.0

- Bump yttrium-wcpay to 0.10.60 (Android) / YttriumWrapper 0.10.59 (iOS).
- ConfirmPaymentRequest: new `data` field for wallet RPC results — elements may be plain strings or JSON objects (e.g. TRON's raw_data_hex + signature payload). `signatures` is deprecated and used as fallback when `data` is null.
- Fixed jniLibs pickFirsts to reference libuniffi_yttrium_wcpay.so.

## 1.0.2

- Sanitized quoted Windows OS version strings returned by WalletconnectPayUtils.getOS().

## 1.0.1

- Added WebView-based payment data collection
- Added per-option payment data collection
- Fixed WalletConnect Pay metadata handling
- Yttrium updates

## 1.0.0

- Official Flutter plugin for WalletConnect Pay

