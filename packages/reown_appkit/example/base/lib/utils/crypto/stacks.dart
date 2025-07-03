enum StacksMethods {
  stacksSignMessage,
  stacksStxTransfer,
}

enum StacksEvents {
  none,
}

class Stacks {
  static final Map<StacksMethods, String> methods = {
    StacksMethods.stacksSignMessage: 'stx_signMessage',
    StacksMethods.stacksStxTransfer: 'stx_transferStx'
  };

  static final List<String> events = [];
}
