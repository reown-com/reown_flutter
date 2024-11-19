import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_theme.dart';

enum SegmentOption {
  option1,
  option2,
}

class SegmentedControl extends StatefulWidget {
  const SegmentedControl({
    super.key,
    this.width,
    this.onChange,
    this.option1Title = 'Mobile',
    this.option1Icon = 'lib/modal/assets/icons/mobile.svg',
    this.option2Title = 'Browser',
    this.option2Icon = 'lib/modal/assets/icons/extension.svg',
  });
  final Function(SegmentOption option)? onChange;
  final double? width;
  final String option1Title, option2Title;
  final String option1Icon, option2Icon;

  @override
  State<SegmentedControl> createState() => _SegmentedControlState();
}

class _SegmentedControlState extends State<SegmentedControl> {
  SegmentOption _selectedSegment = SegmentOption.option1;

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    return SizedBox(
      height: 32.0,
      child: CustomSlidingSegmentedControl<SegmentOption>(
        initialValue: SegmentOption.option1,
        fixedWidth: widget.width ?? 100.0,
        children: {
          SegmentOption.option1: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: widget.option1Icon.isNotEmpty,
                child: SvgPicture.asset(
                  widget.option1Icon,
                  package: 'reown_appkit',
                  colorFilter: ColorFilter.mode(
                    _selectedSegment == SegmentOption.option1
                        ? themeColors.foreground100
                        : themeColors.foreground200,
                    BlendMode.srcIn,
                  ),
                  height: 14.0,
                ),
              ),
              Text(
                ' ${widget.option1Title}',
                style: themeData.textStyles.small500.copyWith(
                  color: _selectedSegment == SegmentOption.option1
                      ? themeColors.foreground100
                      : themeColors.foreground200,
                ),
              ),
            ],
          ),
          SegmentOption.option2: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: widget.option2Icon.isNotEmpty,
                child: SvgPicture.asset(
                  widget.option2Icon,
                  package: 'reown_appkit',
                  colorFilter: ColorFilter.mode(
                    _selectedSegment == SegmentOption.option2
                        ? themeColors.foreground100
                        : themeColors.foreground200,
                    BlendMode.srcIn,
                  ),
                  height: 14.0,
                ),
              ),
              Text(
                ' ${widget.option2Title}',
                style: themeData.textStyles.small500.copyWith(
                  color: _selectedSegment == SegmentOption.option2
                      ? themeColors.foreground100
                      : themeColors.foreground200,
                ),
              ),
            ],
          ),
        },
        decoration: BoxDecoration(
          color: themeColors.grayGlass002,
          borderRadius: radiuses.isSquare()
              ? BorderRadius.all(Radius.zero)
              : BorderRadius.circular(16.0),
        ),
        thumbDecoration: BoxDecoration(
          color: themeColors.grayGlass002,
          borderRadius: radiuses.isSquare()
              ? BorderRadius.all(Radius.zero)
              : BorderRadius.circular(16.0),
          border: Border.all(
            color: themeColors.grayGlass002,
            width: 1,
          ),
        ),
        duration: Duration(milliseconds: 200),
        curve: Curves.linear,
        onValueChanged: (value) {
          setState(() {
            _selectedSegment = value;
          });
          widget.onChange?.call(value);
        },
      ),
    );
  }
}
