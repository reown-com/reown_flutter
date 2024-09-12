import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_theme.dart';

enum SegmentOption {
  mobile,
  browser,
}

class SegmentedControl extends StatefulWidget {
  const SegmentedControl({
    super.key,
    this.onChange,
  });
  final Function(SegmentOption option)? onChange;

  @override
  State<SegmentedControl> createState() => _SegmentedControlState();
}

class _SegmentedControlState extends State<SegmentedControl> {
  SegmentOption _selectedSegment = SegmentOption.mobile;

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    return SizedBox(
      height: 32.0,
      child: CustomSlidingSegmentedControl<SegmentOption>(
        initialValue: SegmentOption.mobile,
        fixedWidth: 100.0,
        children: {
          SegmentOption.mobile: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'lib/modal/assets/icons/mobile.svg',
                package: 'reown_appkit',
                colorFilter: ColorFilter.mode(
                  _selectedSegment == SegmentOption.mobile
                      ? themeColors.foreground100
                      : themeColors.foreground200,
                  BlendMode.srcIn,
                ),
                height: 14.0,
              ),
              const SizedBox.square(dimension: 4.0),
              Text(
                'Mobile',
                style: themeData.textStyles.small500.copyWith(
                  color: _selectedSegment == SegmentOption.mobile
                      ? themeColors.foreground100
                      : themeColors.foreground200,
                ),
              ),
            ],
          ),
          SegmentOption.browser: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'lib/modal/assets/icons/extension.svg',
                package: 'reown_appkit',
                colorFilter: ColorFilter.mode(
                  _selectedSegment == SegmentOption.browser
                      ? themeColors.foreground100
                      : themeColors.foreground200,
                  BlendMode.srcIn,
                ),
                height: 14.0,
              ),
              const SizedBox.square(dimension: 4.0),
              Text(
                'Browser',
                style: themeData.textStyles.small500.copyWith(
                  color: _selectedSegment == SegmentOption.browser
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
