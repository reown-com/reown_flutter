import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/utils/constants.dart';

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
        backgroundColor: StyleConstants.clear,
        isScrollControlled: true,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        builder: (context) {
          if (item.closeAfter > 0) {
            Future.delayed(Duration(seconds: item.closeAfter), () {
              try {
                if (!mounted) return;
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              } catch (e) {
                debugPrint('[$runtimeType] close $e');
              }
            });
          }
          return Material(
            borderRadius: BorderRadius.all(
              Radius.circular(StyleConstants.linear16),
            ),
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        padding: const EdgeInsets.all(0.0),
                        visualDensity: VisualDensity.compact,
                        onPressed: () {
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
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
