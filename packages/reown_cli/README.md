<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages). 
-->

# Reown CLI

A command-line interface for creating Flutter projects with Reown SDKs integration.

## Features

- Create new Flutter projects with Reown AppKit SDK integration
- Automatically sets up project structure and dependencies
- Configures platform-specific settings
- Supports Android, iOS, and web platforms
- Automatically fetches the latest stable version of Reown AppKit from pub.dev
- Configures iOS platform version (13.0) in Podfile (when iOS is enabled)
- Integrates project ID into the generated code
- Sets up proper analysis options and linting rules
- Configures supported blockchains (e.g., eip155, solana, bitcoin)

## Installation

```bash
dart pub global activate reown_cli
```

## Usage

```bash
reown create --appkit --name my_awesome_app --projectId your_reown_project_id
```

### What the command does

When you run the create command, it will:
1. Create a new Flutter project with the specified name and organization
2. Set up the project structure with proper navigation
3. Configure dependencies with the latest stable version of Reown AppKit
4. Set up platform-specific settings:
   - iOS: Configures minimum platform version (13.0) in Podfile (only when iOS is enabled)
   - Android: Sets up proper configuration
   - Web: Configures web support
5. Integrate your project ID into the generated code
6. Configure supported blockchains in the generated code
7. Set up analysis options and linting rules
8. Run `flutter pub get` to install dependencies

### Options

- `--appkit, -a`: Create a project with Reown AppKit SDK integration (required)
- `--name, -n`: The name of the project (required)
- `--org, -o`: The organization name (e.g., com.example) (default: com.example)
- `--projectId, -i`: The Reown project ID (required)
- `--platforms, -p`: Platforms to support (android,ios,web) (default: android,ios)
- `--chains, -c`: Blockchains to support (e.g., eip155,solana,bitcoin) (default: eip155)
- `--verbose, -v`: Enable verbose output (default: false)

### Example

```bash
reown create --appkit --name my_awesome_app --projectId 123456 --org com.testing --platforms ios,android --chains eip155,solana,bitcoin --verbose
```

## Development

This package is part of the Reown Flutter SDK. For more information, visit [reown.com](https://reown.com).

## License

This project is licensed under the MIT License - see the LICENSE file for details.
