import 'package:flutter/material.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';

/// Simple gradient sweep used as a placeholder while per-option fee estimates
/// are loading in parallel. No new package deps — uses [ShaderMask] over a
/// solid base.
class WCPShimmer extends StatefulWidget {
  const WCPShimmer({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 4.0,
  });

  final double width;
  final double height;
  final double borderRadius;

  @override
  State<WCPShimmer> createState() => _WCPShimmerState();
}

class _WCPShimmerState extends State<WCPShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final base = colors.foregroundTertiary;
    final highlight = colors.foregroundSecondary;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        // Slide a fixed-width highlight band from off-screen left to
        // off-screen right. The earlier implementation animated `begin`/`end`
        // symmetrically, which collapsed the gradient width over time
        // instead of moving the band — that's the "glitched" pulse the user
        // saw.
        final t = _controller.value;
        final dx = -2.0 + 4.0 * t;
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment(dx - 1.0, 0),
              end: Alignment(dx + 1.0, 0),
              colors: [base, highlight, base],
              stops: const [0.0, 0.5, 1.0],
            ).createShader(rect);
          },
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: base,
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
          ),
        );
      },
    );
  }
}
