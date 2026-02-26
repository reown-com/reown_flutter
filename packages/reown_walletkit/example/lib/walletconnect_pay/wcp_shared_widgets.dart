import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_radius.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';
import 'package:reown_walletkit_wallet/theme/app_typography.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_utils.dart';
import 'package:reown_walletkit/reown_walletkit.dart';

class WCModalTitle extends StatelessWidget {
  const WCModalTitle({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: context.textStyles.heading6,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class WCPrimaryButton extends StatelessWidget {
  const WCPrimaryButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.enabled = true,
  });

  final VoidCallback onPressed;
  final String text;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48.0,
      child: InkWell(
        onTap: enabled ? onPressed : null,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Builder(builder: (context) {
          final colors = context.colors;
          return Container(
            decoration: BoxDecoration(
              color: enabled
                  ? colors.accent
                  : colors.accent.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s4,
            ),
            alignment: Alignment.center,
            child: Text(
              text,
              style: context.textStyles.wcpTextPrimary.copyWith(
                color: colors.textInvert,
              ),
              textAlign: TextAlign.center,
            ),
          );
        }),
      ),
    );
  }
}

class WCPStepsIndicator extends StatelessWidget {
  const WCPStepsIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  final int currentStep;
  final int totalSteps;

  static const double _barHeight = 6.0;
  static const double _barWidth = 36.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalSteps, (index) {
        final isActive = index < currentStep;
        final isCurrent = index == currentStep - 1;
        return Container(
          width: _barWidth,
          height: _barHeight,
          margin: EdgeInsets.only(right: index < totalSteps - 1 ? 8 : 0),
          decoration: BoxDecoration(
            color: isActive || isCurrent ? colors.accent : colors.neutrals,
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}

class WCPTextField extends StatefulWidget {
  const WCPTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.label,
    this.enabled = true,
    this.suffix,
    this.padding,
    this.keyboardType,
    this.textStyle,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String label;
  final bool enabled;
  final Widget? suffix;
  final EdgeInsetsGeometry? padding;
  final ValueChanged<String>? onSubmitted;
  final TextInputType? keyboardType;
  final TextStyle? textStyle;

  @override
  State<WCPTextField> createState() => _WCPTextFieldState();
}

class _WCPTextFieldState extends State<WCPTextField> {
  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isFocused = widget.focusNode.hasFocus;
    final borderColor =
        isFocused ? colors.accent.withValues(alpha: 0.4) : colors.inputBorder;

    return Container(
      height: 64.0,
      decoration: BoxDecoration(
        color: colors.backgroundSecondary,
        borderRadius: BorderRadius.circular(20),
        border: widget.enabled
            ? Border.all(color: borderColor, width: isFocused ? 4 : 1)
            : null,
      ),
      padding: widget.padding ??
          const EdgeInsets.symmetric(horizontal: AppSpacing.s6),
      child: CupertinoTextField(
        enabled: widget.enabled,
        controller: widget.controller,
        focusNode: widget.focusNode,
        onSubmitted: widget.onSubmitted,
        style: widget.textStyle ??
            context.textStyles.buttonText.copyWith(
              color: colors.textPrimary,
            ),
        placeholder: widget.label,
        placeholderStyle: context.textStyles.wcpTextPrimary.copyWith(
          color: colors.textTertiary,
        ),
        decoration: const BoxDecoration(),
        padding: EdgeInsets.zero,
        suffix: widget.suffix,
        textCapitalization: TextCapitalization.words,
        keyboardType: widget.keyboardType ?? TextInputType.text,
      ),
    );
  }
}

class WCPPaymentDetails extends StatelessWidget {
  const WCPPaymentDetails({super.key, required this.paymentInfo});

  final PaymentInfo paymentInfo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: RichText(
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              style: context.textStyles.heading6,
              children: [
                const TextSpan(text: 'Pay '),
                TextSpan(text: formatPayAmount(paymentInfo.amount)),
                const TextSpan(text: ' to '),
                TextSpan(text: paymentInfo.merchant.name),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class WCPMerchantHeader extends StatelessWidget {
  const WCPMerchantHeader({super.key, required this.merchant});

  final MerchantInfo merchant;

  static const double _logoSize = 64.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: _logoSize,
        height: _logoSize,
        decoration: BoxDecoration(
          color: context.colors.backgroundInvert,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: merchant.iconUrl != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  child: Image.network(
                    merchant.iconUrl!,
                    width: _logoSize,
                    height: _logoSize,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        _DefaultLogo(text: merchant.name.characters.first),
                  ),
                )
              : _DefaultLogo(text: merchant.name.characters.first),
        ),
      ),
    );
  }
}

class _DefaultLogo extends StatelessWidget {
  final String text;
  const _DefaultLogo({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: context.colors.onBackgroundInvert,
        fontSize: 32,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.32,
      ),
    );
  }
}

class WCPSheetIconButton extends StatelessWidget {
  const WCPSheetIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.showBorder = true,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 38.0,
        height: 38.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: showBorder
              ? Border.all(color: colors.foregroundTertiary, width: 1)
              : null,
          borderRadius: BorderRadius.circular(AppSpacing.s3),
        ),
        child: Icon(
          icon,
          color: colors.textPrimary,
          size: 20.0,
        ),
      ),
    );
  }
}

class WCPInfoButton extends StatelessWidget {
  const WCPInfoButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38.0,
        height: 38.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: colors.foregroundTertiary, width: 1),
          borderRadius: BorderRadius.circular(AppSpacing.s3),
        ),
        child: SvgPicture.asset(
          'assets/QuestionMark.svg',
          width: 20.0,
          height: 20.0,
          colorFilter: ColorFilter.mode(
            colors.textPrimary,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

class WalletConnectLoading extends StatefulWidget {
  const WalletConnectLoading({super.key, this.size = 120.0});

  final double size;

  @override
  State<WalletConnectLoading> createState() => _WalletConnectLoadingState();
}

class _WalletConnectLoadingState extends State<WalletConnectLoading>
    with TickerProviderStateMixin {
  static const _cycleDuration = Duration(milliseconds: 4000);
  static const _gap = 2.0;

  late AnimationController _controller;
  late double _squareSize;

  // Opacity animations
  late Animation<double> _opacityTL;
  late Animation<double> _opacityTR;
  late Animation<double> _opacityBL;
  late Animation<double> _opacityBR;

  // Border radius animations
  late Animation<double> _cornerTL;
  late Animation<double> _cornerTR;
  late Animation<double> _cornerBL;
  late Animation<double> _cornerBR;

  @override
  void initState() {
    super.initState();
    _squareSize = (widget.size - _gap) / 2;

    _controller = AnimationController(duration: _cycleDuration, vsync: this);

    _setupAnimations();
    _controller.repeat();
  }

  void _setupAnimations() {
    // Bottom-left (gray pill) - appears at 30ms, disappears at 3580ms
    _opacityBL = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: 30),
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 80,
      ),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 3470),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 80,
      ),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: 340),
    ]).animate(_controller);

    // Bottom-left border radius animation
    _cornerBL = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: _squareSize * 0.1, end: _squareSize * 0.1),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: _squareSize * 0.1,
          end: _squareSize * 0.15,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween(begin: _squareSize * 0.15, end: _squareSize * 0.15),
        weight: 1150,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: _squareSize * 0.15,
          end: _squareSize * 0.25,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1000,
      ),
      TweenSequenceItem(
        tween: Tween(begin: _squareSize * 0.25, end: _squareSize * 0.25),
        weight: 500,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: _squareSize * 0.25,
          end: _squareSize * 0.1,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1000,
      ),
      TweenSequenceItem(
        tween: Tween(begin: _squareSize * 0.1, end: _squareSize * 0.1),
        weight: 270,
      ),
    ]).animate(_controller);

    // Bottom-right (blue) - appears at 120ms, disappears at 3660ms
    _opacityBR = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: 120),
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 80,
      ),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 3460),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 80,
      ),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: 260),
    ]).animate(_controller);

    // Bottom-right border radius animation
    _cornerBR = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: _squareSize * 0.12, end: _squareSize * 0.12),
        weight: 120,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: _squareSize * 0.12,
          end: _squareSize * 0.2,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 850,
      ),
      TweenSequenceItem(
        tween: Tween(begin: _squareSize * 0.2, end: _squareSize * 0.2),
        weight: 600,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: _squareSize * 0.2,
          end: _squareSize * 0.48,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1100,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: _squareSize * 0.48,
          end: _squareSize * 0.12,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 900,
      ),
      TweenSequenceItem(
        tween: Tween(begin: _squareSize * 0.12, end: _squareSize * 0.12),
        weight: 430,
      ),
    ]).animate(_controller);

    // Top-right (dark gray) - appears at 200ms, disappears at 3740ms
    _opacityTR = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: 200),
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 80,
      ),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 3460),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 80,
      ),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: 180),
    ]).animate(_controller);

    // Top-right border radius animation
    _cornerTR = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: _squareSize * 0.12, end: _squareSize * 0.12),
        weight: 200,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: _squareSize * 0.12,
          end: _squareSize * 0.45,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 800,
      ),
      TweenSequenceItem(
        tween: Tween(begin: _squareSize * 0.45, end: _squareSize * 0.45),
        weight: 500,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: _squareSize * 0.45,
          end: _squareSize * 0.2,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 900,
      ),
      TweenSequenceItem(
        tween: Tween(begin: _squareSize * 0.2, end: _squareSize * 0.2),
        weight: 600,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: _squareSize * 0.2,
          end: _squareSize * 0.12,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 700,
      ),
      TweenSequenceItem(
        tween: Tween(begin: _squareSize * 0.12, end: _squareSize * 0.12),
        weight: 300,
      ),
    ]).animate(_controller);

    // Top-left (light gray) - appears at 250ms, disappears at 3780ms
    _opacityTL = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: 250),
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 80,
      ),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 3450),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 80,
      ),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: 140),
    ]).animate(_controller);

    // Top-left border radius animation
    _cornerTL = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: _squareSize * 0.12, end: _squareSize * 0.12),
        weight: 250,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: _squareSize * 0.12,
          end: _squareSize * 0.3,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 750,
      ),
      TweenSequenceItem(
        tween: Tween(begin: _squareSize * 0.3, end: _squareSize * 0.3),
        weight: 600,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: _squareSize * 0.3,
          end: _squareSize * 0.2,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1000,
      ),
      TweenSequenceItem(
        tween: Tween(begin: _squareSize * 0.2, end: _squareSize * 0.2),
        weight: 1000,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: _squareSize * 0.2,
          end: _squareSize * 0.12,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 400,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        children: [
          // Top left - Light gray
          Positioned(
            top: 0,
            left: 0,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityTL.value,
                  child: Container(
                    width: _squareSize,
                    height: _squareSize,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8E8E8),
                      borderRadius: BorderRadius.circular(_cornerTL.value),
                    ),
                  ),
                );
              },
            ),
          ),

          // Top right - Dark gray
          Positioned(
            top: 0,
            left: _squareSize + _gap,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityTR.value,
                  child: Container(
                    width: _squareSize,
                    height: _squareSize,
                    decoration: BoxDecoration(
                      color: const Color(0xFF363636),
                      borderRadius: BorderRadius.circular(_cornerTR.value),
                    ),
                  ),
                );
              },
            ),
          ),

          // Bottom left - Gray - Half height pill at bottom
          Positioned(
            top: _squareSize + _gap + _squareSize / 2,
            left: 0,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityBL.value,
                  child: Container(
                    width: _squareSize,
                    height: _squareSize / 2,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C6C6C),
                      borderRadius: BorderRadius.circular(_cornerBL.value),
                    ),
                  ),
                );
              },
            ),
          ),

          // Bottom right - Accent Primary
          Positioned(
            top: _squareSize + _gap,
            left: _squareSize + _gap,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityBR.value,
                  child: Container(
                    width: _squareSize,
                    height: _squareSize,
                    decoration: BoxDecoration(
                      color: context.colors.accent,
                      borderRadius: BorderRadius.circular(_cornerBR.value),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
