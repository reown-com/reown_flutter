import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// A lightweight visibility listener that triggers [onVisible]
/// once when the widget becomes visible within the viewport.
class VisibilityChecker extends StatefulWidget {
  const VisibilityChecker({
    super.key,
    required this.child,
    this.onVisible,
    this.fireOnce = true,
    this.enabled = true,
    this.visibilityThreshold = 1.0, // 1.0 = fully visible, 0.5 = half, etc.
  });

  final Widget child;
  final VoidCallback? onVisible;
  final bool fireOnce;
  final bool enabled;
  final double visibilityThreshold;

  @override
  State<VisibilityChecker> createState() => _VisibilityCheckerState();
}

class _VisibilityCheckerState extends State<VisibilityChecker> {
  bool _fired = false;
  ScrollPosition? _position;
  bool _checkScheduled = false;

  @override
  void initState() {
    super.initState();
    // initial check after first layout
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Attach to the nearest Scrollable's position
    final scrollable = Scrollable.maybeOf(context);
    if (scrollable != null) {
      final newPosition = scrollable.position;
      if (_position != newPosition) {
        _position?.removeListener(_onScroll);
        _position = newPosition;
        _position?.addListener(_onScroll);
      }
    }
  }

  @override
  void dispose() {
    _position?.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (!widget.enabled || (_fired && widget.fireOnce)) return;

    // Coalesce multiple scroll updates into one check per frame.
    if (_checkScheduled) return;
    _checkScheduled = true;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _checkScheduled = false;
      if (mounted) _checkVisibility();
    });
  }

  void _checkVisibility() {
    if (!mounted || (_fired && widget.fireOnce) || !widget.enabled) return;

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) return;

    // Viewport (the visible area of the nearest Scrollable)
    final scrollableState = Scrollable.of(context);
    final viewportRender =
        scrollableState.context.findRenderObject() as RenderBox?;
    if (viewportRender == null || !viewportRender.hasSize) return;

    // Rect of the widget in global coordinates
    final topLeft = renderBox.localToGlobal(Offset.zero);
    final rect = Rect.fromLTWH(
      topLeft.dx,
      topLeft.dy,
      renderBox.size.width,
      renderBox.size.height,
    );

    // Rect of the viewport in global coordinates
    final vpTopLeft = viewportRender.localToGlobal(Offset.zero);
    final viewportRect = Rect.fromLTWH(
      vpTopLeft.dx,
      vpTopLeft.dy,
      viewportRender.size.width,
      viewportRender.size.height,
    );

    final intersection = rect.intersect(viewportRect);
    final visibleArea = (intersection.width <= 0 || intersection.height <= 0)
        ? 0.0
        : intersection.width * intersection.height;
    final totalArea = renderBox.size.width * renderBox.size.height;
    final visibleFraction = totalArea == 0
        ? 0.0
        : (visibleArea / totalArea).clamp(0.0, 1.0);

    if (visibleFraction >= widget.visibilityThreshold) {
      widget.onVisible?.call();
      if (widget.fireOnce) _fired = true;
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
