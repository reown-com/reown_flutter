import 'package:flutter/material.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_radius.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';

class ExpandableSection extends StatefulWidget {
  const ExpandableSection({
    super.key,
    required this.headerLeft,
    required this.headerRight,
    required this.expandedContent,
    this.initiallyExpanded = false,
  });

  final Widget headerLeft;
  final Widget headerRight;
  final Widget expandedContent;
  final bool initiallyExpanded;

  @override
  State<ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: colors.foregroundPrimary,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: _toggle,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.s4,
                vertical: 14.0,
              ),
              child: Row(
                children: [
                  Expanded(child: widget.headerLeft),
                  widget.headerRight,
                  const SizedBox(width: AppSpacing.s2),
                  Icon(
                    Icons.unfold_more,
                    color: colors.backgroundInvert,
                    size: 20.0,
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: _isExpanded
                ? Padding(
                    padding: const EdgeInsets.only(
                      left: AppSpacing.s4,
                      right: AppSpacing.s4,
                      bottom: AppSpacing.s4,
                    ),
                    child: widget.expandedContent,
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
