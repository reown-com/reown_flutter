import 'package:flutter/material.dart';

class DtcFooter extends StatelessWidget {
  const DtcFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Container(
        width: double.infinity,
        height: 60.0,
        color: Colors.black12,
        padding: const EdgeInsets.only(top: 12.0),
        child: const Text(
          'Powered by DTC Pay',
          style: TextStyle(
            color: Colors.black, // Very dark gray, almost black
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
