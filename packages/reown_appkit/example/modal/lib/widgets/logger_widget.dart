import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:reown_appkit/reown_appkit.dart';

class DraggableCard extends StatefulWidget {
  final OverlayController overlayController;
  //
  const DraggableCard({
    super.key,
    required this.overlayController,
  });

  @override
  State<DraggableCard> createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard> {
  final List<Widget> _logs = [];
  //
  @override
  void initState() {
    super.initState();
    widget.overlayController.appKitModal.appKit!.core.addLogListener(
      _eventsListener,
    );
  }

  void _eventsListener(String event) {
    if (!mounted) return;
    if (!event.toString().contains('[AnalyticsService]')) return;
    String message = event.replaceAll('[AnalyticsService] ', '');
    message = message.replaceAll('send event 202: ', '');
    message = message.replaceAll('info: ', '');
    _logs.add(
      Text(
        '=> $message',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12.0,
        ),
      ),
    );
    setState(() {});
  }

  @override
  void dispose() {
    widget.overlayController.appKitModal.appKit!.core.removeLogListener(
      _eventsListener,
    );
    widget.overlayController.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Card(
      elevation: 6.0,
      color: Colors.black87,
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 300.0,
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 300.0,
                    child: ListView(
                      reverse: true,
                      padding: const EdgeInsets.all(6.0),
                      children: _logs.reversed.toList(),
                    ),
                  ),
                ),
                GestureDetector(
                  onPanUpdate: (details) {
                    widget.overlayController.alignChildTo(
                      details.globalPosition,
                      size * 0.5,
                    );
                  },
                  onPanEnd: (_) {
                    // widget.overlayController.alignToScreenEdge();
                  },
                  child: Container(
                    width: 25.0,
                    color: Colors.black,
                    child: const Center(
                      child: Icon(
                        Icons.drag_indicator_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OverlayController extends AnimatedOverlay {
  OverlayController(
    super.duration, {
    required this.appKitModal,
  });
  final ReownAppKitModal appKitModal;
  OverlayEntry? _entry;
  final _defaultAlign = const Alignment(0.0, -30.0);
  Alignment align = const Alignment(0.0, -30.0);
  Animation<Alignment>? alignAnimation;

  OverlayEntry createAlignOverlay(Widget child) {
    return OverlayEntry(
      maintainState: true,
      builder: (_) => CustomAlign(
        animation: alignAnimation ?? AlwaysStoppedAnimation(align),
        child: child,
      ),
    );
  }

  void insert(BuildContext context) {
    _entry = createAlignOverlay(DraggableCard(overlayController: this));
    Overlay.of(context).insert(_entry!);
  }

  void show(BuildContext context) {
    if (_entry != null) {
      toggle();
    } else {
      insert(context);
    }
  }

  void remove() {
    _entry?.remove();
    _entry?.dispose();
    _entry = null;
  }

  void alignChildTo(Offset globalPosition, Size size) {
    double dx = (globalPosition.dx - size.width) / size.width;
    double dy = (globalPosition.dy - size.height) / size.height;

    dx = dx.abs() < 1 ? dx : dx / dx.abs();
    dy = dy.abs() < 1 ? dy : dy / dy.abs();

    final newAlign = Alignment(dx, dy);

    if (align == newAlign) return;

    alignAnimation = createAnimation(begin: align, end: newAlign);

    align = newAlign;

    controller.forward();
    _entry?.markNeedsBuild();
  }

  void toggle() {
    if (align == Alignment.center) {
      alignAnimation = createAnimation<Alignment>(
        begin: align,
        end: _defaultAlign,
      );
      align = _defaultAlign;
    } else {
      alignAnimation = createAnimation<Alignment>(
        begin: align,
        end: Alignment.center,
      );
      align = Alignment.center;
    }

    controller.forward();
    _entry?.markNeedsBuild();
  }
}

abstract class AnimatedOverlay extends TickerProvider {
  @override
  Ticker createTicker(onTick) => Ticker(onTick);

  late final AnimationController controller;

  AnimatedOverlay(Duration duration) : super() {
    controller = AnimationController(
      vsync: this,
      duration: duration,
    );
  }

  Animation<T> createAnimation<T>({
    required T begin,
    required T end,
    Curve curve = Curves.easeInOutCubic,
  }) {
    controller.reset();
    if (begin == end) {
      return AlwaysStoppedAnimation<T>(end);
    } else {
      return Tween<T>(begin: begin, end: end).animate(
        CurvedAnimation(
          parent: controller,
          curve: curve,
        ),
      );
    }
  }
}

class CustomAlign extends AnimatedWidget {
  final Widget child;
  final Animation<Alignment> animation;

  const CustomAlign({
    super.key,
    required this.child,
    required this.animation,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: animation.value,
      child: child,
    );
  }
}
