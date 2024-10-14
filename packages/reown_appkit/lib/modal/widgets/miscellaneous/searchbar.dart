import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_theme.dart';
import 'package:reown_appkit/modal/utils/asset_util.dart';
import 'package:reown_appkit/modal/utils/debouncer.dart';

class ModalSearchBar extends StatefulWidget {
  const ModalSearchBar({
    super.key,
    required this.onTextChanged,
    this.controller,
    this.onDismissKeyboard,
    this.hint = '',
    this.initialValue = '',
    this.iconPath = 'lib/modal/assets/icons/search.svg',
    this.prefixIcon,
    this.suffixIcon,
    this.textAlign,
    this.textInputType,
    this.textInputAction,
    this.onSubmitted,
    this.autofocus,
    this.onFocusChange,
    this.noIcons = false,
    this.showCursor = true,
    this.textStyle,
    this.debounce = true,
    this.focusNode,
    this.width,
    this.height = kSearchFieldHeight,
    this.enabled = true,
    this.inputFormatters,
  });
  final Function(String) onTextChanged;
  final String hint;
  final Function(bool)? onDismissKeyboard;
  final TextEditingController? controller;
  final String? iconPath;
  final String initialValue;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextAlign? textAlign;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final Function(String)? onSubmitted;
  final bool? autofocus;
  final Function(bool)? onFocusChange;
  final bool noIcons;
  final bool showCursor;
  final TextStyle? textStyle;
  final bool debounce;
  final FocusNode? focusNode;
  final double? width;
  final double height;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<ModalSearchBar> createState() => _ModalSearchBarState();
}

class _ModalSearchBarState extends State<ModalSearchBar>
    with TickerProviderStateMixin {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  final _debouncer = Debouncer(milliseconds: 300);

  late DecorationTween _decorationTween = DecorationTween(
    begin: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.transparent,
          offset: Offset.zero,
          blurRadius: 0.0,
          spreadRadius: 1.0,
          blurStyle: BlurStyle.normal,
        ),
      ],
    ),
    end: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.transparent,
          offset: Offset.zero,
          blurRadius: 0.0,
          spreadRadius: 1.0,
          blurStyle: BlurStyle.normal,
        ),
      ],
    ),
  );

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 150),
  );

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _setDecoration();
      _controller.text = widget.initialValue;
      _controller.addListener(_updateState);
      _focusNode.addListener(_updateState);
    });
  }

  void _setDecoration() {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    _decorationTween = DecorationTween(
      begin: BoxDecoration(
        borderRadius: radiuses.isSquare()
            ? BorderRadius.zero
            : (radiuses.isCircular()
                ? BorderRadius.circular(widget.height)
                : BorderRadius.circular(widget.height * 0.4)),
        boxShadow: [
          BoxShadow(
            color: Colors.transparent,
            offset: Offset.zero,
            blurRadius: 0.0,
            spreadRadius: 1.0,
            blurStyle: BlurStyle.normal,
          ),
        ],
      ),
      end: BoxDecoration(
        borderRadius: radiuses.isSquare()
            ? BorderRadius.zero
            : (radiuses.isCircular()
                ? BorderRadius.circular(widget.height)
                : BorderRadius.circular(widget.height * 0.4)),
        boxShadow: [
          BoxShadow(
            color: themeColors.accenGlass015,
            offset: Offset.zero,
            blurRadius: 0.0,
            spreadRadius: 1.0,
            blurStyle: BlurStyle.normal,
          ),
        ],
      ),
    );
  }

  @override
  void didUpdateWidget(covariant ModalSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setDecoration();
  }

  bool _hasFocus = false;
  void _updateState() {
    if (_focusNode.hasFocus && !_hasFocus) {
      _hasFocus = _focusNode.hasFocus;
      _animationController.forward();
    }
    if (!_focusNode.hasFocus && _hasFocus) {
      _hasFocus = _focusNode.hasFocus;
      _animationController.reverse();
    }
    widget.onFocusChange?.call(_focusNode.hasFocus);
    setState(() {});
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controller.removeListener(_updateState);
    _controller.dispose();
    _focusNode.removeListener(_updateState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final unfocusedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: themeColors.grayGlass005, width: 1.0),
      borderRadius: radiuses.isSquare()
          ? BorderRadius.zero
          : (radiuses.isCircular()
              ? BorderRadius.circular(widget.height)
              : BorderRadius.circular(widget.height * 0.3)),
    );
    final focusedBorder = unfocusedBorder.copyWith(
      borderSide: BorderSide(color: themeColors.accent100, width: 1.0),
    );
    final disabledBorder = unfocusedBorder.copyWith(
      borderSide: BorderSide(color: themeColors.background100, width: 1.0),
    );

    return DecoratedBoxTransition(
      decoration: _decorationTween.animate(_animationController),
      child: Container(
        height: widget.height + 8.0,
        width: widget.width,
        padding: const EdgeInsets.all(4.0),
        child: TextFormField(
          keyboardType: widget.textInputType ?? TextInputType.text,
          textInputAction:
              widget.textInputAction ?? TextInputAction.unspecified,
          autofocus: widget.autofocus ?? false,
          onFieldSubmitted: widget.onSubmitted,
          onEditingComplete: () {},
          focusNode: _focusNode,
          controller: _controller,
          inputFormatters: widget.inputFormatters,
          onChanged: (value) {
            if (!widget.debounce) {
              widget.onTextChanged(value);
            } else {
              _debouncer.run(() => widget.onTextChanged(value));
            }
          },
          enabled: widget.enabled,
          readOnly: !widget.enabled,
          onTapOutside: (_) => widget.onDismissKeyboard?.call(false),
          textAlignVertical: TextAlignVertical.center,
          textAlign: widget.textAlign ?? TextAlign.left,
          style:
              widget.textStyle ?? TextStyle(color: themeColors.foreground100),
          cursorColor: themeColors.accent100,
          enableSuggestions: false,
          autocorrect: false,
          showCursor: widget.showCursor,
          decoration: InputDecoration(
            isDense: true,
            prefixIcon: widget.prefixIcon ??
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 16.0,
                      height: 16.0,
                      margin: const EdgeInsets.only(left: kPadding16),
                      child: GestureDetector(
                        onTap: () {
                          _controller.clear();
                          widget.onDismissKeyboard?.call(true);
                        },
                        child: SvgPicture.asset(
                          widget.iconPath ?? '',
                          package: 'reown_appkit',
                          height: 10.0,
                          width: 10.0,
                          colorFilter: ColorFilter.mode(
                            themeColors.foreground275,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: widget.height,
              minHeight: widget.height,
              maxWidth: 40.0,
              minWidth: widget.noIcons ? 0.0 : 40.0,
            ),
            labelStyle: themeData.textStyles.paragraph500.copyWith(
              color: themeColors.inverse100,
            ),
            hintText: widget.hint,
            hintStyle: themeData.textStyles.paragraph500.copyWith(
              color: themeColors.foreground275,
              height: 1.5,
            ),
            suffixIcon: widget.suffixIcon ??
                (_controller.value.text.isNotEmpty || _focusNode.hasFocus
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 18.0,
                            height: 18.0,
                            margin: const EdgeInsets.only(right: kPadding12),
                            child: GestureDetector(
                              onTap: () {
                                _controller.clear();
                                widget.onDismissKeyboard?.call(true);
                              },
                              child: SvgPicture.asset(
                                AssetUtils.getThemedAsset(
                                  context,
                                  'input_cancel.svg',
                                ),
                                package: 'reown_appkit',
                                height: 10.0,
                                width: 10.0,
                              ),
                            ),
                          ),
                        ],
                      )
                    : null),
            suffixIconConstraints: BoxConstraints(
              maxHeight: widget.height,
              minHeight: widget.height,
              maxWidth: 36.0,
              minWidth: widget.noIcons ? 0.0 : 36.0,
            ),
            border: unfocusedBorder,
            errorBorder: unfocusedBorder,
            enabledBorder: unfocusedBorder,
            disabledBorder: disabledBorder,
            focusedBorder: focusedBorder,
            filled: true,
            fillColor: themeColors.grayGlass002,
            contentPadding: const EdgeInsets.all(0.0),
          ),
        ),
      ),
    );
  }
}

// ignore: unused_element
class _DecoratedInputBorder extends InputBorder {
  _DecoratedInputBorder({
    required this.child,
    required this.shadow,
  }) : super(borderSide: child.borderSide);

  final InputBorder child;

  final BoxShadow shadow;

  @override
  bool get isOutline => child.isOutline;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      child.getInnerPath(rect, textDirection: textDirection);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      child.getOuterPath(rect, textDirection: textDirection);

  @override
  EdgeInsetsGeometry get dimensions => child.dimensions;

  @override
  InputBorder copyWith({
    BorderSide? borderSide,
    InputBorder? child,
    BoxShadow? shadow,
    bool? isOutline,
  }) {
    return _DecoratedInputBorder(
      child: (child ?? this.child).copyWith(borderSide: borderSide),
      shadow: shadow ?? this.shadow,
    );
  }

  @override
  ShapeBorder scale(double t) {
    final scalledChild = child.scale(t);

    return _DecoratedInputBorder(
      child: scalledChild is InputBorder ? scalledChild : child,
      shadow: BoxShadow.lerp(null, shadow, t)!,
    );
  }

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection? textDirection,
  }) {
    final clipPath = Path()
      ..addRect(const Rect.fromLTWH(-5000, -5000, 10000, 10000))
      ..addPath(getInnerPath(rect), Offset.zero)
      ..fillType = PathFillType.evenOdd;
    canvas.clipPath(clipPath);

    final Paint paint = shadow.toPaint();
    final Rect bounds = rect.shift(shadow.offset).inflate(shadow.spreadRadius);

    canvas.drawPath(getOuterPath(bounds), paint);

    child.paint(canvas, rect,
        gapStart: gapStart,
        gapExtent: gapExtent,
        gapPercentage: gapPercentage,
        textDirection: textDirection);
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is _DecoratedInputBorder &&
        other.borderSide == borderSide &&
        other.child == child &&
        other.shadow == shadow;
  }

  @override
  int get hashCode => Object.hash(borderSide, child, shadow);

  @override
  String toString() {
    return '$runtimeType($borderSide, $shadow, $child)';
  }
}
