#!/usr/bin/env dart

import 'package:reown_cli/reown_cli.dart';

void main(List<String> arguments) async {
  final cli = ReownCli(arguments);
  await cli.run();
}
