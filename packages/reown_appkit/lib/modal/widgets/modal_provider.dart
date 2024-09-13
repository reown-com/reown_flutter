import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';

class ModalProvider extends InheritedWidget {
  final IReownAppKitModal instance;

  const ModalProvider({
    super.key,
    required this.instance,
    required super.child,
  });

  static ModalProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ModalProvider>();
  }

  static ModalProvider of(BuildContext context) {
    final ModalProvider? result = maybeOf(context);
    assert(result != null, 'No ModalProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ModalProvider oldWidget) {
    return true;
  }
}
