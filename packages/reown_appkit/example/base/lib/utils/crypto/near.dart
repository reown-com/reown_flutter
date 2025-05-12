enum NearMethods {
  nearSignMessage,
  nearSignTransaction,
  nearSignTransactions,
  // nearSignAndSendTransaction,
  // nearRequestSignTransactions,
}

enum NearEvents {
  chainChanged,
  accountsChanged,
}

class Near {
  static final Map<NearMethods, String> methods = {
    NearMethods.nearSignMessage: 'near_signMessage',
    NearMethods.nearSignTransaction: 'near_signTransaction',
    NearMethods.nearSignTransactions: 'near_signTransactions',
  };

  static final Map<NearEvents, String> events = {
    NearEvents.chainChanged: 'chainChanged',
    NearEvents.accountsChanged: 'accountsChanged',
  };
}
