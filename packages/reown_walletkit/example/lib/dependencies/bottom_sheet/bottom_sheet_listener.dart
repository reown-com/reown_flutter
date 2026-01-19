import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/utils/constants.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_shared_widgets.dart';

class BottomSheetListener extends StatefulWidget {
  final Widget child;

  const BottomSheetListener({
    super.key,
    required this.child,
  });

  @override
  BottomSheetListenerState createState() => BottomSheetListenerState();
}

class BottomSheetListenerState extends State<BottomSheetListener> {
  late final IBottomSheetService _bottomSheetService;

  @override
  void initState() {
    super.initState();
    _bottomSheetService = GetIt.I<IBottomSheetService>();
    _bottomSheetService.currentSheet.addListener(_showBottomSheet);
  }

  @override
  void dispose() {
    _bottomSheetService.currentSheet.removeListener(_showBottomSheet);
    super.dispose();
  }

  Future<void> _showBottomSheet() async {
    if (_bottomSheetService.currentSheet.value != null) {
      BottomSheetQueueItem item = _bottomSheetService.currentSheet.value!;
      final value = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        isDismissible: false,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        builder: (context) {
          if (item.closeAfter > 0) {
            Future.delayed(Duration(seconds: item.closeAfter), () {
              try {
                if (!mounted) return;
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop(WCBottomSheetResult.close.name);
                }
              } catch (e) {
                debugPrint('[$runtimeType] close $e');
              }
            });
          }
          // final isDark =
          //     MediaQuery.of(context).platformBrightness == Brightness.dark;
          return Material(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(StyleConstants.linear32),
              topRight: Radius.circular(StyleConstants.linear32),
            ),
            color: StyleConstants.bgPrimary,
            child: Padding(
              padding: EdgeInsets.only(
                top: StyleConstants.linear16,
                left: StyleConstants.linear16,
                right: StyleConstants.linear16,
                bottom: MediaQuery.of(context).viewInsets.bottom +
                    StyleConstants.linear24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      (item.showBackButton)
                          ? IconButton(
                              padding: const EdgeInsets.all(0.0),
                              visualDensity: VisualDensity.compact,
                              onPressed: () {
                                if (Navigator.canPop(context)) {
                                  Navigator.of(context).pop(
                                    WCBottomSheetResult.back.name,
                                  );
                                }
                              },
                              icon: const Icon(Icons.arrow_back),
                            )
                          : const SizedBox(width: 40.0),
                      //
                      (item.stepper.$1 > 0 && item.stepper.$2 > 0)
                          ? WCPStepsIndicator(
                              currentStep: item.stepper.$1,
                              totalSteps: item.stepper.$2,
                            )
                          : const SizedBox(width: 40.0),
                      //
                      IconButton(
                        padding: const EdgeInsets.all(0.0),
                        visualDensity: VisualDensity.compact,
                        onPressed: () {
                          if (Navigator.canPop(context)) {
                            Navigator.of(context).pop(
                              WCBottomSheetResult.close.name,
                            );
                          }
                        },
                        icon: const Icon(Icons.close_sharp),
                      ),
                    ],
                  ),
                  Flexible(child: item.widget),
                ],
              ),
            ),
          );
        },
      );
      item.completer.complete(value);
      _bottomSheetService.showNext();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
