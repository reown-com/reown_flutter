import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_appkit_dapp/utils/constants.dart';

class ChainButton extends StatelessWidget {
  const ChainButton({
    super.key,
    required this.chain,
    required this.onPressed,
    this.selected = false,
  });

  final ReownAppKitModalNetworkInfo chain;
  final VoidCallback onPressed;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (min(Constants.smallScreen - 78.0,
                  MediaQuery.of(context).size.width) /
              2) -
          14.0,
      height: StyleConstants.linear48,
      margin: const EdgeInsets.only(
        bottom: StyleConstants.linear8,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0.0),
          backgroundColor: MaterialStateProperty.all<Color>(
            selected ? Colors.white : Colors.grey.shade300,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              side: BorderSide(
                color: selected ? Colors.blue : Colors.grey.shade300,
                width: selected ? 4 : 2,
              ),
              borderRadius: BorderRadius.circular(
                StyleConstants.linear8,
              ),
            ),
          ),
        ),
        child: Text(
          chain.name,
          style: StyleConstants.buttonText,
        ),
      ),
    );
  }
}
