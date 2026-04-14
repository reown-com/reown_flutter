# WalletKit Example Wallet

An example wallet built using Flutter.

## To Run

`flutter run --dart-define=PROJECT_ID=xxx`

## E2E Testing with Maestro

The wallet has Maestro E2E tests for WalletConnect Pay flows. Test flows are shared across RN, Kotlin, and Flutter wallet samples and live in the [WalletConnect/actions](https://github.com/WalletConnect/actions) repo.

### Prerequisites

1. Install Maestro CLI:
   ```bash
   curl -Ls "https://get.maestro.mobile.dev" | bash
   ```
2. Have an Android emulator running

### Setup

1. Copy `.env.maestro.example` to `.env.maestro` (in repo root) and fill in merchant secrets:
   ```bash
   cp .env.maestro.example .env.maestro
   ```

2. Download test flows from WalletConnect/actions:
   ```bash
   ./scripts/setup-maestro-pay-tests.sh
   ```

3. Build and install APK with test mode enabled and a funded wallet:
   ```bash
   cd packages/reown_walletkit/example
   flutter build apk --flavor internal \
     --dart-define="PROJECT_ID=<your-project-id>" \
     --dart-define="ENABLE_TEST_MODE=true" \
     --dart-define="TEST_WALLET_PRIVATE_KEY=<funded-hex-private-key>" \
     --release --target-platform android-x64 --split-per-abi
   adb install -r build/app/outputs/flutter-apk/app-x86_64-internal-release.apk
   ```

   `TEST_WALLET_PRIVATE_KEY` is a build-time param baked into the APK (like Kotlin's `BuildConfig` approach), not a Maestro env var. The `0x` prefix is stripped automatically if present.

### Running Tests

Run all pay tests:
```bash
APP_ID=com.walletconnect.flutterwallet.internal ./scripts/run-maestro-pay-tests.sh
```

Run a single test:
```bash
APP_ID=com.walletconnect.flutterwallet.internal ./scripts/run-maestro-pay-tests.sh pay_single_option_nokyc.yaml
```

Use Maestro Studio to inspect test IDs:
```bash
maestro studio
```

### Test Mode

When built with `ENABLE_TEST_MODE=true`, the scan modal shows a text input field instead of camera/paste options, allowing tests to paste WalletConnect Pay URLs directly.

### CI

The CI workflow (`.github/workflows/ci_e2e_pay_tests.yml`) runs Pay E2E on:
1. Android (`ubuntu-16core`) using an emulator
2. iOS (`macos-26-xlarge`) using a simulator

For each platform lane it:
1. Builds a test-mode wallet binary with a funded test wallet
2. Downloads shared Maestro Pay flows via
   `WalletConnect/actions/maestro/pay-tests`
3. Runs pay-tagged Maestro tests on emulator/simulator
4. Uploads only debug output (never APK/IPA)