import 'package:flutter/material.dart';

class DtcItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final double iconSize;
  final double titleFontSize;
  final double subtitleFontSize;

  const DtcItem({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    this.trailing,
    this.subtitle,
    this.iconSize = 18,
    this.titleFontSize = 18,
    this.subtitleFontSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      visualDensity: VisualDensity.compact,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.white, size: iconSize),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: titleFontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: TextStyle(
                color: Colors.grey,
                fontSize: subtitleFontSize,
                fontWeight: FontWeight.normal,
              ),
            )
          : null,
      trailing: trailing,
    );
  }
}
