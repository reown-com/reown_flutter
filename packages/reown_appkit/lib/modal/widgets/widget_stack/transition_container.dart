import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/widget_stack_singleton.dart';

class TransitionContainer extends StatefulWidget {
  const TransitionContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<TransitionContainer> createState() => _TransitionContainerState();
}

class _TransitionContainerState extends State<TransitionContainer>
    with TickerProviderStateMixin {
  static const fadeDuration = Duration(milliseconds: 150);
  static const resizeDuration = Duration(milliseconds: 150);
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Widget _currentScreen;

  @override
  void initState() {
    super.initState();
    _currentScreen = widget.child;

    _fadeController = AnimationController(
      vsync: this,
      duration: fadeDuration,
    );

    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      _fadeController,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(
      _fadeController,
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    // _resizeController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TransitionContainer previousScreen) {
    super.didUpdateWidget(previousScreen);
    if (previousScreen.child.key != widget.child.key) {
      _fadeController.forward().then((_) {
        setState(() => _currentScreen = widget.child);
        if (!widgetStack.instance.onRenderScreen.value) {
          widgetStack.instance.onRenderScreen.value = true;
        }
        Future.delayed(fadeDuration).then((value) {
          if (mounted) {
            _fadeController.reverse();
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_fadeAnimation, _scaleAnimation]),
      builder: (context, _) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: AnimatedSize(
            duration: resizeDuration,
            child: _currentScreen,
          ),
        );
      },
    );
  }
}
