# AGENTS.md

This file provides guidance to AI agents when working with code in this repository.

## AI Skills

When writing or modifying Flutter/Dart code in this repository, use the **flutter-coding** skill located at:
- `.claude/skills/flutter-coding/SKILL.md` - Core patterns, validation checklist, and Flutter/Dart best practices

This skill encodes project-specific conventions including interface-based design, freezed models, event-driven architecture, code generation patterns, and testing practices aligned with official Flutter guidelines.

## Project Overview

**Reown Flutter** is a Flutter/Dart SDK implementing the WalletConnect protocol for multi-platform applications. Reown (formerly WalletConnect) is the communications protocol for web3, bringing the ecosystem together by enabling hundreds of wallets and apps to securely connect and interact.

### Key Information
- **Repository**: https://github.com/reown-com/reown_flutter
- **Published Packages**: https://pub.dev/publishers/reown.com/packages
- **Documentation**: 
  - AppKit: https://docs.reown.com/appkit/flutter/core/installation
  - WalletKit: https://docs.reown.com/walletkit/flutter/installation
- **License**: Apache 2.0

### Tech Stack
- **Dart**: 3.8.0+ with null safety
- **Flutter**: 1.10.0+ for cross-platform UI
- **Platforms**: Android, iOS, Web, macOS, Linux, Windows
- **Cryptography**: ed25519_edwards, x25519, pinenacl, crypto, pointycastle
- **Networking**: http, web_socket_channel, connectivity_plus
- **Storage**: flutter_secure_storage, shared_preferences
- **UI Components**: flutter_svg, cached_network_image, custom_sliding_segmented_control, shimmer
- **Blockchain**: web3dart, eth_sig_util_plus, bs58
- **Code Generation**: build_runner, freezed, json_serializable
- **Testing**: flutter_test, mockito, flutter_lints

### Multi-Chain Support
- EVM chains (Ethereum, Polygon, Arbitrum, Optimism, etc.)
- Solana
- Polkadot
- Kadena
- Tron
- Cosmos

## Repository Structure

This is a **monorepo** containing multiple Flutter packages organized in a layered architecture:

```
reown_flutter/
├── packages/
│   ├── reown_core/          # Foundation layer
│   ├── reown_sign/          # Sign protocol implementation
│   ├── reown_walletkit/     # Wallet-side implementation
│   ├── reown_appkit/        # Full-featured UI toolkit
│   ├── reown_yttrium/       # Chain abstraction layer (early access)
│   ├── reown_yttrium_utils/ # Yttrium utilities
│   ├── reown_cli/           # Command-line tool
│   ├── walletconnect_pay/   # Payment protocol
│   └── pos_client/          # Point of sale SDK
├── scripts/                 # Build and utility scripts
├── .github/                 # CI/CD workflows
└── assets/                  # Shared assets
```

### Package Dependencies

The packages follow a dependency hierarchy:

**Independent packages** (no internal reown dependencies):
- **reown_yttrium**: Chain abstraction layer (ERC-4337, ERC-7702 support)
- **walletconnect_pay**: Payment protocol implementation
- **reown_cli**: Command-line tool
- **pos_client**: Point of sale SDK

**Dependent chain**:

1. **reown_core** (Foundation)
   - Depends on: `reown_yttrium`
   - Provides: networking, cryptography, storage, message serialization

2. **reown_sign** (Protocol Layer)
   - Depends on: `reown_core`
   - Provides: Sign protocol implementation, session management

3. **reown_appkit** (DApp Side)
   - Depends on: `reown_core`, `reown_sign`
   - Provides: Full UI toolkit with modals, QR codes, WebView support

4. **reown_walletkit** (Wallet Side)
   - Depends on: `reown_core`, `reown_sign`, `walletconnect_pay`
   - Provides: Wallet-side WalletConnect functionality

Note: `reown_appkit` and `reown_walletkit` are independent of each other.

### Package Details

#### reown_core
Foundation layer with:
- Networking: WebSocket via `web_socket_channel`, HTTP client
- Cryptography: ed25519, x25519, pointycastle
- Secure storage: `flutter_secure_storage` with fallback to `shared_preferences`
- Connectivity detection: `connectivity_plus`
- MessagePack serialization: `msgpack_dart`
- Pairing and session management
- Expiration tracking

#### reown_sign
Sign protocol implementation:
- Uses `web3dart` for EVM chain interactions
- `freezed` for immutable models
- Session proposal, request, and approval handling
- Auth protocol support
- Namespace management

#### reown_walletkit
Wallet implementation:
- Orchestrates `reown_core` networking and `reown_sign` protocol
- Provides wallet-side WalletConnect functionality
- Key management and signing
- Multi-chain wallet support

#### reown_appkit
Full-featured UI toolkit:
- Coinbase Wallet SDK integration
- WebView support for WalletConnect
- QR code generation (`qr_flutter_wc`)
- Comprehensive modal components
- Asset caching (`cached_network_image`)
- Shimmer loading effects

#### reown_yttrium
Chain abstraction layer (early access):
- Smart account functionality (ERC-4337, ERC-7702)
- Native platform plugins (Android/iOS)
- `freezed` for immutable models
- `eth_sig_util_plus` for signature utilities

#### walletconnect_pay
Payment protocol plugin:
- Crypto and stablecoin payment acceptance
- Multi-blockchain network support
- Native platform plugins (Android/iOS)
- `freezed` for immutable models

#### reown_cli
Command-line tool:
- Flutter project scaffolding with AppKit SDK integration
- Project generation and setup automation

#### pos_client
Point of Sale SDK:
- Cryptocurrency payment acceptance for POS systems
- QR code generation for payment requests
- Event-driven architecture
- Depends on `reown_core` and `reown_sign` at runtime

## Key Commands

### Setup and Generation

```bash
# Generate all packages (run from root)
sh scripts/generate_all.sh

# Generate a specific package
cd packages/reown_core
sh generate_files.sh

# Clean all packages
sh scripts/clean_all.sh
```

### Development

```bash
# Convert to local dependencies (for monorepo development)
sh scripts/convert_to_local_deps.sh

# Convert back to pub.dev dependencies
sh scripts/convert_to_pub_deps.sh

# Resolve dependencies for a specific package or example app
cd packages/reown_appkit/example/base
flutter pub get

# Run WalletKit example
cd packages/reown_walletkit/example
flutter run --dart-define="PROJECT_ID=0123..." --flavor internal

# Run AppKit example
cd packages/reown_appkit/example/base
flutter run --dart-define="PROJECT_ID=0123..." --flavor internal
```

### Testing

```bash
# Run tests for a specific package
cd packages/reown_core
flutter test

# Run all tests
flutter test --reporter expanded
```

### Code Quality

```bash
# Format code
dart format .

# Analyze code
flutter analyze

# Run linter
dart run flutter_lints
```

### Publishing

Packages are published via GitHub Actions workflow (`.github/workflows/publish-packages.yml`):

1. Manual trigger via `workflow_dispatch`
2. Select which packages to publish
3. Workflow handles:
   - Dependency version updates
   - Code generation
   - Publishing to pub.dev
   - Creating PR with updates

**Publishing Order** (due to dependencies):

Independent packages (run in parallel):
- `reown_yttrium`
- `walletconnect_pay`
- `reown_cli`
- `pos_client`

Dependent chain:
1. `reown_yttrium` → `reown_core` (core depends on yttrium)
2. `reown_core` → `reown_sign` (sign depends on core)
3. `reown_sign` → `reown_appkit` (appkit depends on core, sign)
4. `reown_sign` + `walletconnect_pay` → `reown_walletkit` (walletkit depends on core, sign, walletconnect_pay)

Note: `reown_appkit` and `reown_walletkit` are independent and can be published in parallel after `reown_sign`.

## Architecture Overview

### Layered Architecture

```
┌─────────────────────────────────────┐
│   reown_appkit (UI Toolkit)        │
│   reown_walletkit (Wallet)          │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│   reown_sign (Protocol)             │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│   reown_core (Foundation)            │
│   - Networking                       │
│   - Cryptography                     │
│   - Storage                          │
│   - Pairing                          │
└─────────────────────────────────────┘
```

### Core Components

#### Networking Layer
- **RelayClient**: WebSocket-based relay communication
- **HttpWrapper**: HTTP client for REST APIs
- **MessageTracker**: Tracks sent/received messages
- **HeartBeat**: Connection health monitoring

#### Cryptography
- **Crypto**: Key generation, encryption, signing
- **KeyChain**: Secure key storage
- **Pairing**: Secure pairing establishment

#### Storage
- **SecureStore**: Encrypted storage with `flutter_secure_storage`
- **SharedPrefsStores**: Fallback storage
- **GenericStore**: Type-safe storage abstraction

#### Protocol
- **SignClient**: Sign protocol client
- **SignEngine**: Protocol state machine
- **SessionStore**: Session persistence
- **Expirer**: Automatic expiration handling

### Design Patterns

- **Interface-based Design**: Public APIs defined via interfaces
- **Dependency Injection**: Constructor-based DI
- **Event-driven**: Uses `event` package for reactive programming
- **Immutable Models**: `freezed` for data classes
- **Code Generation**: `build_runner` for JSON serialization and freezed

## Development Notes

### Code Generation

Most packages use code generation:
- **Freezed**: Immutable data classes with union types
- **json_serializable**: JSON serialization/deserialization
- **build_runner**: Orchestrates code generation

**Important**: Always run `generate_files.sh` after modifying:
- Models with `@freezed` or `@JsonSerializable`
- Files importing generated code

### Dependency Management

**Local Development**:
- Packages use `path: ../package_name/` for internal dependencies
- Use `convert_to_local_deps.sh` to switch to local paths

**Publishing**:
- Packages use version constraints: `^1.2.3`
- Use `convert_to_pub_deps.sh` before publishing
- Publishing workflow automatically updates dependencies

### Version Management

- Each package has its own version in `pubspec.yaml`
- Follow semantic versioning (MAJOR.MINOR.PATCH)
- Breaking changes require major version bump
- Dependencies use caret constraints (`^`) for flexibility

### Testing Strategy

- **Unit Tests**: Test business logic in isolation
- **Widget Tests**: Test UI components
- **Integration Tests**: End-to-end flows (using Maestro)
- **Mocking**: Use `mockito` for dependencies

### Platform-Specific Code

- **Android**: Native code in `android/` directories
- **iOS**: Native code in `ios/` directories
- **Platform Channels**: Used for native functionality (e.g., `walletconnect_pay`)

### Yttrium Native Dependencies

Several packages depend on **Yttrium**, a Rust-based library that provides chain abstraction and payment functionality. Yttrium is consumed differently on each platform:

**Native Dependency Locations:**

| Package | iOS (CocoaPods) | Android (Gradle) |
|---------|-----------------|------------------|
| `reown_yttrium` | `packages/reown_yttrium/ios/reown_yttrium.podspec` → `YttriumWrapper` | `packages/reown_yttrium/android/build.gradle` |
| `reown_yttrium_utils` | `packages/reown_yttrium_utils/ios/reown_yttrium_utils.podspec` → `YttriumUtilsWrapper` | `packages/reown_yttrium_utils/android/build.gradle` |
| `walletconnect_pay` | `packages/walletconnect_pay/ios/walletconnect_pay.podspec` → `YttriumWrapper` | `packages/walletconnect_pay/android/build.gradle` → `yttrium-wcpay` |

**Yttrium Releases:** https://github.com/reown-com/yttrium/releases

**IMPORTANT:** iOS and Android use different Yttrium artifacts with potentially different versions. Always ensure both platforms are using compatible versions that include the required API features.

### Updating Yttrium Versions

#### Step 1: Update Android (Gradle)

Edit the `build.gradle` file for the relevant package and change the version in the `implementation` line:

| Package | File | Dependency |
|---------|------|------------|
| `reown_yttrium` | `packages/reown_yttrium/android/build.gradle` | `com.github.reown-com.yttrium:yttrium:X.Y.Z` |
| `reown_yttrium_utils` | `packages/reown_yttrium_utils/android/build.gradle` | `com.github.reown-com.yttrium:yttrium-utils:X.Y.Z` |
| `walletconnect_pay` | `packages/walletconnect_pay/android/build.gradle` | `com.github.reown-com.yttrium:yttrium-wcpay:X.Y.Z` |

Android artifacts are hosted on **JitPack** and are usually available immediately after a GitHub release.

#### Step 2: Update iOS (CocoaPods)

Edit the podspec file for the relevant package and change the version in the `s.dependency` line:

| Package | File | Dependency |
|---------|------|------------|
| `reown_yttrium` | `packages/reown_yttrium/ios/reown_yttrium.podspec` | `YttriumWrapper` |
| `reown_yttrium_utils` | `packages/reown_yttrium_utils/ios/reown_yttrium_utils.podspec` | `YttriumUtilsWrapper` |
| `walletconnect_pay` | `packages/walletconnect_pay/ios/walletconnect_pay.podspec` | `YttriumWrapper` |

**IMPORTANT:** iOS pods must be published to CocoaPods trunk before they can be used. Always verify the version is available before updating:

```bash
# Check available versions on trunk
pod trunk info YttriumWrapper
pod trunk info YttriumUtilsWrapper
```

#### Step 3: Run Pod Install (iOS)

After updating podspecs, reinstall pods in the example app:

```bash
cd packages/reown_walletkit/example/ios
rm Podfile.lock
pod repo update          # Force refresh the local spec cache
pod install
```

**Common Pitfalls:**
- If `pod install` can't find the new version, run `pod repo update` first to refresh the local CocoaPods spec cache. The `--repo-update` flag on `pod install` does not always fully refresh the CDN cache.
- iOS and Android use different Yttrium artifacts with potentially different versions. Always ensure both platforms are using compatible versions that include the required API features.
- If a feature works on Android but not iOS (or vice versa), check that both platforms are using the same Yttrium version.

#### Step 4: Update Dart Models (if API changed)

If the Yttrium/Pay API adds new fields, update the corresponding Dart model in `packages/walletconnect_pay/lib/models/walletconnect_pay_models.dart` and regenerate:

```bash
cd packages/walletconnect_pay
sh generate_files.sh
```

### Local Yttrium Development

To test local Yttrium builds before publishing:

#### Android

1. Build Yttrium locally and publish to Maven local (`~/.m2/repository`)
2. In the example app's `build.gradle` (`packages/reown_walletkit/example/android/app/build.gradle`), exclude the published artifact and add your local one:

```gradle
configurations.all {
    exclude group: 'com.github.reown-com.yttrium', module: 'yttrium-utils'
}

dependencies {
    implementation 'com.github.reown-com:yttrium-utils:unspecified'
}
```

**Note:** The local Maven artifact uses a different group ID (`com.github.reown-com`) than the published one (`com.github.reown-com.yttrium`). A simple `resolutionStrategy.force` won't work because the group IDs differ.

#### iOS

1. In the Yttrium repo, modify the podspec (e.g. `YttriumUtilsWrapper.podspec`) to use local paths:

```ruby
spec.source = { :path => "." }
spec.vendored_frameworks = "target/ios-utils/libyttrium-utils.xcframework"
spec.source_files = "platforms/swift/Sources/YttriumUtils/**/*.swift"
```

2. In the example app's Podfile (`packages/reown_walletkit/example/ios/Podfile`), add a local pod override:

```ruby
pod 'YttriumUtilsWrapper', :path => '/path/to/yttrium/repo'
```

3. Run `pod install` in the example app's `ios/` directory

### Code Style

- Follow Flutter/Dart style guide
- Use `dart format` for consistent formatting
- Follow `flutter_lints` recommendations
- Maximum line length: 80 characters (preferred)

## Versioning/Publishing Mechanism

### Version Format

Semantic versioning: `MAJOR.MINOR.PATCH`
- **MAJOR**: Breaking changes
- **MINOR**: New features (backward compatible)
- **PATCH**: Bug fixes

### Publishing Workflow

1. **Manual Trigger**: GitHub Actions workflow `publish-packages.yml`
2. **Package Selection**: Choose which packages to publish
3. **Branch Creation**: Creates `publish_workflow_<run_number>` branch
4. **Dependency Updates**: Automatically updates dependent packages
5. **Code Generation**: Runs `generate_files.sh` for each package
6. **Dry Run**: Validates package before publishing
7. **Publish**: Publishes to pub.dev
8. **Wait**: Waits for package availability
9. **PR Creation**: Creates PR with dependency updates

### Publishing Dependencies

Packages must be published in dependency order:

1. Independent packages first (can run in parallel):
   - `reown_yttrium`, `walletconnect_pay`, `reown_cli`, `pos_client`
2. Foundation package: `reown_core` (waits for `reown_yttrium`)
3. Protocol package: `reown_sign` (waits for `reown_core`)
4. Application packages (can run in parallel after `reown_sign`):
   - `reown_appkit` (depends on `reown_core`, `reown_sign`)
   - `reown_walletkit` (depends on `reown_core`, `reown_sign`, `walletconnect_pay`)

The workflow automatically:
- Updates `pubspec.yaml` with new dependency versions
- Commits changes to the release branch
- Creates a PR for review

### Pre-Publishing Checklist

- [ ] Update version in `pubspec.yaml`
- [ ] Run `generate_files.sh`
- [ ] Run tests: `flutter test`
- [ ] Run analyzer: `flutter analyze`
- [ ] Update CHANGELOG.md (if applicable)
- [ ] Convert to pub dependencies: `convert_to_pub_deps.sh`
- [ ] Verify package: `flutter pub publish --dry-run`

### Post-Publishing

- Verify package on pub.dev
- Update documentation if needed
- Tag release in GitHub (if applicable)
- Monitor for issues

## Common Tasks

### Adding a New Package

1. Create directory: `packages/new_package/`
2. Create `pubspec.yaml` with dependencies
3. Add `generate_files.sh` script
4. Add to `scripts/generate_all.sh`
5. Add to publishing workflow if needed

### Modifying Models

1. Update model class (with annotations)
2. Run `generate_files.sh`
3. Update tests if needed
4. Verify generated code compiles

### Debugging

- Use `Logger` from `logger` package
- Set log level in `ReownCore` initialization
- Check WebSocket connections via relay URL
- Verify storage with secure storage inspector

### Performance

- Use `ListView.builder` for long lists
- Cache network images with `cached_network_image`
- Avoid expensive operations in `build()` methods
- Use `const` constructors where possible

## Resources

- **Flutter Documentation**: https://docs.flutter.dev
- **Dart Documentation**: https://dart.dev
- **Reown Documentation**: https://docs.reown.com
- **WalletConnect Protocol**: https://docs.walletconnect.com
- **pub.dev**: https://pub.dev

## Support

For issues or questions:
- GitHub Issues: https://github.com/reown-com/reown_flutter/issues
- Documentation: https://docs.reown.com
- Community: Check Reown Discord/community channels
