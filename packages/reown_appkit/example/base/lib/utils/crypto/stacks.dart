enum StacksMethods {
  stacksSignMessage,
  stacksStxTransfer,
}

enum StacksEvents {
  none,
}

class Stacks {
  static final Map<StacksMethods, String> methods = {
    StacksMethods.stacksSignMessage: 'stacks_signMessage',
    StacksMethods.stacksStxTransfer: 'stacks_stxTransfer'
  };

  static final List<String> events = [];
}
