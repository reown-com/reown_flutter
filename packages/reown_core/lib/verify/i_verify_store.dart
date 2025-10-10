import 'package:reown_core/store/i_generic_store.dart';
import 'package:reown_core/verify/models/jwk.dart';

abstract class IVerifyStore extends IGenericStore<String> {
  JWK? getItem();
  Future<void> removeItem();
  Future<void> setItem(JWK jwk);
}
