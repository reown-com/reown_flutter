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

## Installation

```bash
dart pub global activate reown_cli
```

## Usage

```bash
reown create --appkit --name my_awesome_app --projectId your_reown_project_id
```

### Options

- `--appkit, -a`: Create a project with Reown AppKit SDK integration (required)
- `--name, -n`: The name of the project (required)
- `--org, -o`: The organization name (e.g., com.example) (default: com.example)
- `--projectId, -i`: The Reown project ID (required)
- `--platforms, -p`: Platforms to support (android,ios,web) (default: android,ios)
- `--verbose, -v`: Enable verbose output (default: false)

### Example

```bash
reown create --appkit --name my_awesome_app --projectId 123456 --org com.testing --platforms ios,android --verbose
```

## Development

This package is part of the Reown Flutter SDK. For more information, visit [reown.com](https://reown.com).

## License

This project is licensed under the MIT License - see the LICENSE file for details.
