import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/services/toast_service/i_toast_service.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_theme.dart';
import 'package:reown_appkit/modal/services/toast_service/models/toast_message.dart';

class ToastWidget extends StatefulWidget {
  const ToastWidget({
    super.key,
    required this.message,
  });

  final ToastMessage message;

  @override
  State<ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<ToastWidget>
    with SingleTickerProviderStateMixin {
  static const fadeInTime = 200;
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: fadeInTime),
      vsync: this,
    );
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward().then((_) {
      Future.delayed(
        widget.message.duration - const Duration(milliseconds: fadeInTime * 2),
      ).then((_) {
        if (!mounted) {
          return;
        }
        _controller.reverse().then((value) => GetIt.I<IToastService>().clear());
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    return Positioned(
      top: 10.0,
      left: 20.0,
      right: 20.0,
      child: Center(
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: Container(
            constraints: BoxConstraints(
              minHeight: 40.0,
            ),
            decoration: BoxDecoration(
              color: themeColors.background175,
              borderRadius: BorderRadius.circular(radiuses.radiusM),
              border: Border.all(
                color: themeColors.grayGlass005,
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.message.icon(context),
                  const SizedBox(width: 8.0),
                  Flexible(
                    child: Text(
                      widget.message.text,
                      textAlign: TextAlign.center,
                      style: themeData.textStyles.paragraph500.copyWith(
                        color: themeColors.foreground100,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
