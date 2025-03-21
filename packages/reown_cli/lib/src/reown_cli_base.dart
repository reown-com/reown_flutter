import 'dart:io';
import 'package:args/args.dart';
import 'package:path/path.dart' as path;
import 'package:process_run/process_run.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// Checks if you are awesome. Spoiler: you are.
class Awesome {
  bool get isAwesome => true;
}

class ReownCli {
  final ArgParser _parser;
  late final ArgResults _args;
  final Shell _shell = Shell();

  ReownCli(List<String> arguments) : _parser = ArgParser() {
    _setupCommands();
    _args = _parser.parse(arguments);
  }

  void _setupCommands() {
    _parser.addCommand(
      'create',
      ArgParser()
        ..addFlag(
          'appkit',
          abbr: 'a',
          help: 'Create a project with Reown AppKit SDK integration',
          defaultsTo: false,
        )
        ..addOption(
          'name',
          abbr: 'n',
          help: 'The name of the project',
          mandatory: true,
        )
        ..addOption(
          'org',
          abbr: 'o',
          help: 'The organization name (e.g., com.example)',
          defaultsTo: 'com.example',
        )
        ..addOption(
          'projectId',
          abbr: 'i',
          help: 'The Reown project ID',
          mandatory: true,
        )
        ..addOption(
          'platforms',
          abbr: 'p',
          help: 'Platforms to support (android,ios,web)',
          defaultsTo: 'android,ios',
        )
        ..addOption(
          'chains',
          abbr: 'c',
          help: 'Blockchains to support (e.g., eip155,solana,bitcoin)',
        )
        ..addFlag(
          'verbose',
          abbr: 'v',
          help: 'Enable verbose output',
          defaultsTo: false,
        ),
    );
  }

  Future<void> run() async {
    final command = _args.command?.name;
    if (command == null) {
      printUsage();
      exit(1);
    }

    switch (command) {
      case 'create':
        if (!(_args.command!['appkit'] as bool)) {
          print('Error: --appkit flag is required');
          printUsage();
          exit(1);
        }
        await _createProject();
        break;
      default:
        printUsage();
        exit(1);
    }
  }

  void printUsage() {
    print('''
Reown CLI - Create Flutter projects with Reown SDKs

Usage:
  reown <command> [arguments]

Available commands:
  create    Create a new Flutter project with Reown SDK integration

Options:
  --appkit, -a    Create a project with Reown AppKit SDK integration
  --walletkit     Create a project with Reown WalletKit SDK integration (coming soon)

Run "reown help create" for more information about the create command.
''');
  }

  Future<String> _getLatestVersion(String package) async {
    try {
      final response =
          await http.get(Uri.parse('https://pub.dev/api/packages/$package'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final versions = data['versions'] as List;
        final stableVersions = versions
            .where((v) => !v['version'].toString().contains('-'))
            .map((v) => Version.parse(v['version']))
            .toList();
        stableVersions.sort((a, b) => b.compareTo(a));
        return '^${stableVersions.first.toString()}';
      }
      throw Exception('Failed to fetch package version');
    } catch (e) {
      print('Warning: Could not fetch latest version of $package: $e');
      return '^1.4.1'; // Fallback to current stable version
    }
  }

  Future<void> _createProject() async {
    final projectName = _args.command!['name'] as String;
    final org = _args.command!['org'] as String;
    final projectId = _args.command!['projectId'] as String;
    final platforms = (_args.command!['platforms'] as String).split(',');
    final chains = (_args.command!['chains'] as String?)?.split(',') ??
        ['eip155', 'solana'];
    final verbose = _args.command!['verbose'] as bool;

    if (verbose) {
      print('Creating project: $projectName');
      print('Organization: $org');
      print('Project ID: $projectId');
      print('Platforms: ${platforms.join(', ')}');
      print('Chains: ${chains.join(', ')}');
    }

    // Create Flutter project
    final projectDir = Directory(projectName);
    if (projectDir.existsSync()) {
      print('Error: Directory $projectName already exists');
      exit(1);
    }

    try {
      // Fetch latest version of reown_appkit
      final latestVersion = await _getLatestVersion('reown_appkit');
      if (verbose) {
        print('Using reown_appkit version: $latestVersion');
      }

      // Create Flutter project
      await _runCommand(
          'flutter create --org $org --platforms ${platforms.join(',')} $projectName');

      // Copy template files
      await _copyTemplateFiles(projectName, latestVersion, chains);

      // Update pubspec.yaml
      await _updatePubspec(projectName, latestVersion);

      // Update analysis options
      await _updateAnalysisOptions(projectName);

      // Create a new shell with the project directory as working directory
      final projectShell = Shell(workingDirectory: projectName);

      // Run flutter pub get in the project directory
      final result = await projectShell.run('flutter pub get');
      if (result.first.exitCode != 0) {
        throw Exception(
            'Command failed: flutter pub get\n${result.first.stderr}');
      }

      // Format code
      await projectShell.run('dart format .');

      // Update Podfile if iOS is enabled
      if (platforms.contains('ios')) {
        await _updatePodfile(projectName);
      }

      print('\nProject created successfully!');
      print('\nNext steps:');
      print('1. cd $projectName');
      print('2. flutter pub get');
      print('3. flutter run');
      print(
          '4. Check the docs at https://docs.reown.com/appkit/flutter/core/installation');
      print(
          '5. Open any issue at https://github.com/reown-com/reown_flutter/issues');
    } catch (e) {
      print('Error creating project: $e');
      exit(1);
    }
  }

  Future<void> _runCommand(String command) async {
    final result = await _shell.run(command);
    if (result.first.exitCode != 0) {
      throw Exception('Command failed: $command\n${result.first.stderr}');
    }
  }

  Future<void> _copyTemplateFiles(
      String projectName, String version, List<String> chains) async {
    final scriptPath = Platform.script.path;
    final packageRoot = path.dirname(
        path.dirname(path.dirname(path.dirname(path.dirname(scriptPath)))));
    final templatesDir =
        Directory(path.join(packageRoot, 'lib', 'src', 'templates'));
    final projectDir = Directory(projectName);

    // Copy main.dart
    final mainTemplate =
        File(path.join(templatesDir.path, 'lib', 'main.dart.template'));
    final mainTarget = File(path.join(projectDir.path, 'lib', 'main.dart'));
    final projectId = _args.command!['projectId'] as String;

    // Process template with chain conditions
    String content = mainTemplate.readAsStringSync();

    // Replace basic placeholders
    content = content
        .replaceAll('{{project_name}}', projectName)
        .replaceAll('{{project_id}}', projectId)
        .replaceAll('{{chains}}', chains.join(', '));

    // Process chain-specific conditions
    content = _processChainConditions(content, chains);

    await mainTarget.writeAsString(content);
  }

  String _processChainConditions(String content, List<String> chains) {
    // If no chains are specified, remove all chain-related condition blocks
    if (chains.isEmpty || (chains.length == 1 && chains.first.isEmpty)) {
      // Remove all chain-related condition blocks
      content = content.replaceAll(
          RegExp(r'{{#if-chains-specified}}.*?{{/if-chains-specified}}',
              multiLine: true, dotAll: true),
          '');
      content = content.replaceAll(
          RegExp(r'{{#if-chain:.*?}}.*?{{/if-chain}}',
              multiLine: true, dotAll: true),
          '');
      content = content.replaceAll(
          RegExp(r'{{#if-not-chain:.*?}}.*?{{/if-not-chain}}',
              multiLine: true, dotAll: true),
          '');
      content = content.replaceAll(
          RegExp(r'{{#if-chain-not-in:.*?}}.*?{{/if-chain-not-in}}',
              multiLine: true, dotAll: true),
          '');
      content = content.replaceAll(
          RegExp(r'{{#each-additional-chain}}.*?{{/each-additional-chain}}',
              multiLine: true, dotAll: true),
          '');
      content = content.replaceAll(
          RegExp(r'{{#if-not-last}}.*?{{/if-not-last}}',
              multiLine: true, dotAll: true),
          '');
      content = content.replaceAll(
          RegExp(r'{{#if-chain:.*? \|\| .*?}}.*?{{/if-chain}}',
              multiLine: true, dotAll: true),
          '');
      return content;
    }

    // Process if-chains-specified blocks
    final ifChainsSpecifiedPattern = RegExp(
        r'{{#if-chains-specified}}(.*?){{/if-chains-specified}}',
        multiLine: true,
        dotAll: true);
    content = content.replaceAllMapped(ifChainsSpecifiedPattern, (match) {
      final blockContent = match.group(1) ?? '';
      // Process the content inside the if-chains-specified block
      String processedContent = blockContent;

      // Process if-chain blocks with OR conditions
      final ifChainOrPattern = RegExp(
          r'{{#if-chain:([^}]+ \|\| [^}]+)}}(.*?){{/if-chain}}',
          multiLine: true,
          dotAll: true);
      processedContent =
          processedContent.replaceAllMapped(ifChainOrPattern, (match) {
        final conditions =
            match.group(1)?.split('||').map((e) => e.trim()).toList() ?? [];
        final blockContent = match.group(2)?.trim() ?? '';
        final shouldInclude = conditions.any((condition) {
          if (condition == 'additional_chains') {
            return chains.any((chain) => !['eip155', 'solana'].contains(chain));
          }
          return chains.contains(condition);
        });
        return shouldInclude ? blockContent : '';
      });

      // Process if-chain blocks
      final ifChainPattern = RegExp(r'{{#if-chain:([^}]+)}}(.*?){{/if-chain}}',
          multiLine: true, dotAll: true);
      processedContent =
          processedContent.replaceAllMapped(ifChainPattern, (match) {
        final chain = match.group(1)?.trim();
        final blockContent = match.group(2)?.trim() ?? '';
        return chains.contains(chain) ? blockContent : '';
      });

      // Process if-not-chain blocks
      final ifNotChainPattern = RegExp(
          r'{{#if-not-chain:([^}]+)}}(.*?){{/if-not-chain}}',
          multiLine: true,
          dotAll: true);
      processedContent =
          processedContent.replaceAllMapped(ifNotChainPattern, (match) {
        final chain = match.group(1)?.trim();
        final blockContent = match.group(2)?.trim() ?? '';
        return !chains.contains(chain) ? blockContent : '';
      });

      // Process if-chain-not-in blocks
      final ifChainNotInPattern = RegExp(
          r'{{#if-chain-not-in:([^}]+)}}(.*?){{/if-chain-not-in}}',
          multiLine: true,
          dotAll: true);
      processedContent =
          processedContent.replaceAllMapped(ifChainNotInPattern, (match) {
        final excludedChains =
            match.group(1)?.split(',').map((e) => e.trim()).toList() ?? [];
        final blockContent = match.group(2)?.trim() ?? '';
        final additionalChains =
            chains.where((chain) => !excludedChains.contains(chain)).toList();

        if (additionalChains.isEmpty) {
          return '';
        }

        // Replace the additional_chains placeholder
        String processedBlock = blockContent.replaceAll(
            '{{additional_chains}}', additionalChains.join(', '));

        // Process each-additional-chain blocks
        final eachAdditionalChainPattern = RegExp(
            r'{{#each-additional-chain}}(.*?){{/each-additional-chain}}',
            multiLine: true,
            dotAll: true);
        processedBlock = processedBlock
            .replaceAllMapped(eachAdditionalChainPattern, (match) {
          final template = match.group(1)?.trim() ?? '';
          return additionalChains.asMap().entries.map((entry) {
            final isLast = entry.key == additionalChains.length - 1;
            final chain = entry.value;
            String chainContent = template.replaceAll('{{chain}}', chain);

            // Process if-not-last blocks
            final ifNotLastPattern = RegExp(
                r'{{#if-not-last}}(.*?){{/if-not-last}}',
                multiLine: true,
                dotAll: true);
            chainContent =
                chainContent.replaceAllMapped(ifNotLastPattern, (match) {
              return isLast ? '' : match.group(1) ?? '';
            });

            return chainContent;
          }).join('\n');
        });

        return processedBlock;
      });

      return processedContent;
    });

    // Remove any remaining empty lines that were left by the conditions
    content = content.replaceAll(RegExp(r'\n\s*\n\s*\n'), '\n\n');

    // Remove any remaining template conditions that weren't processed
    content = content.replaceAll(
        RegExp(r'{{#.*?}}.*?{{/.*?}}', multiLine: true, dotAll: true), '');
    content = content.replaceAll(
        RegExp(r'{{.*?}}', multiLine: true, dotAll: true), '');

    return content;
  }

  Future<void> _updatePubspec(String projectName, String version) async {
    final scriptPath = Platform.script.path;
    final packageRoot = path.dirname(
        path.dirname(path.dirname(path.dirname(path.dirname(scriptPath)))));
    final templatesDir =
        Directory(path.join(packageRoot, 'lib', 'src', 'templates'));
    final pubspecTemplate =
        File(path.join(templatesDir.path, 'pubspec.yaml.template'));
    final pubspecTarget = File(path.join(projectName, 'pubspec.yaml'));

    final content = pubspecTemplate
        .readAsStringSync()
        .replaceAll('{{project_name}}', projectName)
        .replaceAll('^1.4.1', version);

    await pubspecTarget.writeAsString(content);
  }

  Future<void> _updateAnalysisOptions(String projectName) async {
    final scriptPath = Platform.script.path;
    final packageRoot = path.dirname(
        path.dirname(path.dirname(path.dirname(path.dirname(scriptPath)))));
    final templatesDir =
        Directory(path.join(packageRoot, 'lib', 'src', 'templates'));
    final analysisTemplate =
        File(path.join(templatesDir.path, 'analysis_options.yaml.template'));
    final analysisTarget =
        File(path.join(projectName, 'analysis_options.yaml'));

    await analysisTarget.writeAsString(analysisTemplate.readAsStringSync());
  }

  Future<void> _updatePodfile(String projectName) async {
    final podfilePath = path.join(projectName, 'ios', 'Podfile');
    final podfile = File(podfilePath);

    if (!podfile.existsSync()) {
      return;
    }

    final content = podfile.readAsStringSync();
    final lines = content.split('\n');

    // Remove any existing platform line (commented or not)
    final filteredLines = lines
        .where((line) =>
            !line.trim().startsWith('platform :ios') &&
            !line.trim().startsWith('# platform :ios'))
        .toList();

    // Add the new platform line at the top
    filteredLines.insert(0, "platform :ios, '13.0'");

    await podfile.writeAsString(filteredLines.join('\n'));
  }
}
