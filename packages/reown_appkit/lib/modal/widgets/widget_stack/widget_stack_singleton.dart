import 'package:reown_appkit/modal/widgets/widget_stack/i_widget_stack.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/widget_stack.dart';

class WidgetStackSingleton {
  IWidgetStack instance;
  WidgetStackSingleton() : instance = WidgetStack();
}

final widgetStack = WidgetStackSingleton();
