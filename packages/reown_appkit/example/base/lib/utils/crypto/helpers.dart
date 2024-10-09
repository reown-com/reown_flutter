import 'package:reown_appkit_dapp/utils/crypto/eip155.dart';
import 'package:reown_appkit_dapp/utils/crypto/polkadot.dart';
import 'package:reown_appkit_dapp/utils/crypto/solana.dart';

List<String> getChainMethods(String namespace) {
  switch (namespace) {
    case 'eip155':
      return EIP155.methods.values.toList();
    case 'solana':
      return Solana.methods.values.toList();
    case 'polkadot':
      return Polkadot.methods.values.toList();
    default:
      return [];
  }
}

List<String> getChainEvents(String namespace) {
  switch (namespace) {
    case 'eip155':
      return EIP155.events.values.toList();
    case 'solana':
      return Solana.events.values.toList();
    case 'polkadot':
      return Polkadot.events.values.toList();
    default:
      return [];
  }
}
