// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stacks.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransferStxRequest {

 BigInt get amount; String get sender; String get recipient; String? get memo;
/// Create a copy of TransferStxRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransferStxRequestCopyWith<TransferStxRequest> get copyWith => _$TransferStxRequestCopyWithImpl<TransferStxRequest>(this as TransferStxRequest, _$identity);

  /// Serializes this TransferStxRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransferStxRequest&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.sender, sender) || other.sender == sender)&&(identical(other.recipient, recipient) || other.recipient == recipient)&&(identical(other.memo, memo) || other.memo == memo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,sender,recipient,memo);

@override
String toString() {
  return 'TransferStxRequest(amount: $amount, sender: $sender, recipient: $recipient, memo: $memo)';
}


}

/// @nodoc
abstract mixin class $TransferStxRequestCopyWith<$Res>  {
  factory $TransferStxRequestCopyWith(TransferStxRequest value, $Res Function(TransferStxRequest) _then) = _$TransferStxRequestCopyWithImpl;
@useResult
$Res call({
 BigInt amount, String sender, String recipient, String? memo
});




}
/// @nodoc
class _$TransferStxRequestCopyWithImpl<$Res>
    implements $TransferStxRequestCopyWith<$Res> {
  _$TransferStxRequestCopyWithImpl(this._self, this._then);

  final TransferStxRequest _self;
  final $Res Function(TransferStxRequest) _then;

/// Create a copy of TransferStxRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? sender = null,Object? recipient = null,Object? memo = freezed,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as BigInt,sender: null == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as String,recipient: null == recipient ? _self.recipient : recipient // ignore: cast_nullable_to_non_nullable
as String,memo: freezed == memo ? _self.memo : memo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransferStxRequest].
extension TransferStxRequestPatterns on TransferStxRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransferStxRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransferStxRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransferStxRequest value)  $default,){
final _that = this;
switch (_that) {
case _TransferStxRequest():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransferStxRequest value)?  $default,){
final _that = this;
switch (_that) {
case _TransferStxRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BigInt amount,  String sender,  String recipient,  String? memo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransferStxRequest() when $default != null:
return $default(_that.amount,_that.sender,_that.recipient,_that.memo);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BigInt amount,  String sender,  String recipient,  String? memo)  $default,) {final _that = this;
switch (_that) {
case _TransferStxRequest():
return $default(_that.amount,_that.sender,_that.recipient,_that.memo);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BigInt amount,  String sender,  String recipient,  String? memo)?  $default,) {final _that = this;
switch (_that) {
case _TransferStxRequest() when $default != null:
return $default(_that.amount,_that.sender,_that.recipient,_that.memo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransferStxRequest implements TransferStxRequest {
  const _TransferStxRequest({required this.amount, required this.sender, required this.recipient, this.memo});
  factory _TransferStxRequest.fromJson(Map<String, dynamic> json) => _$TransferStxRequestFromJson(json);

@override final  BigInt amount;
@override final  String sender;
@override final  String recipient;
@override final  String? memo;

/// Create a copy of TransferStxRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransferStxRequestCopyWith<_TransferStxRequest> get copyWith => __$TransferStxRequestCopyWithImpl<_TransferStxRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransferStxRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransferStxRequest&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.sender, sender) || other.sender == sender)&&(identical(other.recipient, recipient) || other.recipient == recipient)&&(identical(other.memo, memo) || other.memo == memo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,sender,recipient,memo);

@override
String toString() {
  return 'TransferStxRequest(amount: $amount, sender: $sender, recipient: $recipient, memo: $memo)';
}


}

/// @nodoc
abstract mixin class _$TransferStxRequestCopyWith<$Res> implements $TransferStxRequestCopyWith<$Res> {
  factory _$TransferStxRequestCopyWith(_TransferStxRequest value, $Res Function(_TransferStxRequest) _then) = __$TransferStxRequestCopyWithImpl;
@override @useResult
$Res call({
 BigInt amount, String sender, String recipient, String? memo
});




}
/// @nodoc
class __$TransferStxRequestCopyWithImpl<$Res>
    implements _$TransferStxRequestCopyWith<$Res> {
  __$TransferStxRequestCopyWithImpl(this._self, this._then);

  final _TransferStxRequest _self;
  final $Res Function(_TransferStxRequest) _then;

/// Create a copy of TransferStxRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? sender = null,Object? recipient = null,Object? memo = freezed,}) {
  return _then(_TransferStxRequest(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as BigInt,sender: null == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as String,recipient: null == recipient ? _self.recipient : recipient // ignore: cast_nullable_to_non_nullable
as String,memo: freezed == memo ? _self.memo : memo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TransferStxResponse {

 String get transaction; String get txid;
/// Create a copy of TransferStxResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransferStxResponseCopyWith<TransferStxResponse> get copyWith => _$TransferStxResponseCopyWithImpl<TransferStxResponse>(this as TransferStxResponse, _$identity);

  /// Serializes this TransferStxResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransferStxResponse&&(identical(other.transaction, transaction) || other.transaction == transaction)&&(identical(other.txid, txid) || other.txid == txid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transaction,txid);

@override
String toString() {
  return 'TransferStxResponse(transaction: $transaction, txid: $txid)';
}


}

/// @nodoc
abstract mixin class $TransferStxResponseCopyWith<$Res>  {
  factory $TransferStxResponseCopyWith(TransferStxResponse value, $Res Function(TransferStxResponse) _then) = _$TransferStxResponseCopyWithImpl;
@useResult
$Res call({
 String transaction, String txid
});




}
/// @nodoc
class _$TransferStxResponseCopyWithImpl<$Res>
    implements $TransferStxResponseCopyWith<$Res> {
  _$TransferStxResponseCopyWithImpl(this._self, this._then);

  final TransferStxResponse _self;
  final $Res Function(TransferStxResponse) _then;

/// Create a copy of TransferStxResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transaction = null,Object? txid = null,}) {
  return _then(_self.copyWith(
transaction: null == transaction ? _self.transaction : transaction // ignore: cast_nullable_to_non_nullable
as String,txid: null == txid ? _self.txid : txid // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TransferStxResponse].
extension TransferStxResponsePatterns on TransferStxResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransferStxResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransferStxResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransferStxResponse value)  $default,){
final _that = this;
switch (_that) {
case _TransferStxResponse():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransferStxResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TransferStxResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String transaction,  String txid)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransferStxResponse() when $default != null:
return $default(_that.transaction,_that.txid);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String transaction,  String txid)  $default,) {final _that = this;
switch (_that) {
case _TransferStxResponse():
return $default(_that.transaction,_that.txid);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String transaction,  String txid)?  $default,) {final _that = this;
switch (_that) {
case _TransferStxResponse() when $default != null:
return $default(_that.transaction,_that.txid);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransferStxResponse implements TransferStxResponse {
  const _TransferStxResponse({required this.transaction, required this.txid});
  factory _TransferStxResponse.fromJson(Map<String, dynamic> json) => _$TransferStxResponseFromJson(json);

@override final  String transaction;
@override final  String txid;

/// Create a copy of TransferStxResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransferStxResponseCopyWith<_TransferStxResponse> get copyWith => __$TransferStxResponseCopyWithImpl<_TransferStxResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransferStxResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransferStxResponse&&(identical(other.transaction, transaction) || other.transaction == transaction)&&(identical(other.txid, txid) || other.txid == txid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transaction,txid);

@override
String toString() {
  return 'TransferStxResponse(transaction: $transaction, txid: $txid)';
}


}

/// @nodoc
abstract mixin class _$TransferStxResponseCopyWith<$Res> implements $TransferStxResponseCopyWith<$Res> {
  factory _$TransferStxResponseCopyWith(_TransferStxResponse value, $Res Function(_TransferStxResponse) _then) = __$TransferStxResponseCopyWithImpl;
@override @useResult
$Res call({
 String transaction, String txid
});




}
/// @nodoc
class __$TransferStxResponseCopyWithImpl<$Res>
    implements _$TransferStxResponseCopyWith<$Res> {
  __$TransferStxResponseCopyWithImpl(this._self, this._then);

  final _TransferStxResponse _self;
  final $Res Function(_TransferStxResponse) _then;

/// Create a copy of TransferStxResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transaction = null,Object? txid = null,}) {
  return _then(_TransferStxResponse(
transaction: null == transaction ? _self.transaction : transaction // ignore: cast_nullable_to_non_nullable
as String,txid: null == txid ? _self.txid : txid // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$StacksAccount {

 String get balance; String get locked;@JsonKey(name: 'unlock_height') String get unlockHeight; String get nonce;@JsonKey(name: 'balance_proof') String get balanceProof;@JsonKey(name: 'nonce_proof') String get nonceProof;
/// Create a copy of StacksAccount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StacksAccountCopyWith<StacksAccount> get copyWith => _$StacksAccountCopyWithImpl<StacksAccount>(this as StacksAccount, _$identity);

  /// Serializes this StacksAccount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StacksAccount&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.locked, locked) || other.locked == locked)&&(identical(other.unlockHeight, unlockHeight) || other.unlockHeight == unlockHeight)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.balanceProof, balanceProof) || other.balanceProof == balanceProof)&&(identical(other.nonceProof, nonceProof) || other.nonceProof == nonceProof));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,balance,locked,unlockHeight,nonce,balanceProof,nonceProof);

@override
String toString() {
  return 'StacksAccount(balance: $balance, locked: $locked, unlockHeight: $unlockHeight, nonce: $nonce, balanceProof: $balanceProof, nonceProof: $nonceProof)';
}


}

/// @nodoc
abstract mixin class $StacksAccountCopyWith<$Res>  {
  factory $StacksAccountCopyWith(StacksAccount value, $Res Function(StacksAccount) _then) = _$StacksAccountCopyWithImpl;
@useResult
$Res call({
 String balance, String locked,@JsonKey(name: 'unlock_height') String unlockHeight, String nonce,@JsonKey(name: 'balance_proof') String balanceProof,@JsonKey(name: 'nonce_proof') String nonceProof
});




}
/// @nodoc
class _$StacksAccountCopyWithImpl<$Res>
    implements $StacksAccountCopyWith<$Res> {
  _$StacksAccountCopyWithImpl(this._self, this._then);

  final StacksAccount _self;
  final $Res Function(StacksAccount) _then;

/// Create a copy of StacksAccount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? balance = null,Object? locked = null,Object? unlockHeight = null,Object? nonce = null,Object? balanceProof = null,Object? nonceProof = null,}) {
  return _then(_self.copyWith(
balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as String,locked: null == locked ? _self.locked : locked // ignore: cast_nullable_to_non_nullable
as String,unlockHeight: null == unlockHeight ? _self.unlockHeight : unlockHeight // ignore: cast_nullable_to_non_nullable
as String,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String,balanceProof: null == balanceProof ? _self.balanceProof : balanceProof // ignore: cast_nullable_to_non_nullable
as String,nonceProof: null == nonceProof ? _self.nonceProof : nonceProof // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StacksAccount].
extension StacksAccountPatterns on StacksAccount {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StacksAccount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StacksAccount() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StacksAccount value)  $default,){
final _that = this;
switch (_that) {
case _StacksAccount():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StacksAccount value)?  $default,){
final _that = this;
switch (_that) {
case _StacksAccount() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String balance,  String locked, @JsonKey(name: 'unlock_height')  String unlockHeight,  String nonce, @JsonKey(name: 'balance_proof')  String balanceProof, @JsonKey(name: 'nonce_proof')  String nonceProof)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StacksAccount() when $default != null:
return $default(_that.balance,_that.locked,_that.unlockHeight,_that.nonce,_that.balanceProof,_that.nonceProof);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String balance,  String locked, @JsonKey(name: 'unlock_height')  String unlockHeight,  String nonce, @JsonKey(name: 'balance_proof')  String balanceProof, @JsonKey(name: 'nonce_proof')  String nonceProof)  $default,) {final _that = this;
switch (_that) {
case _StacksAccount():
return $default(_that.balance,_that.locked,_that.unlockHeight,_that.nonce,_that.balanceProof,_that.nonceProof);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String balance,  String locked, @JsonKey(name: 'unlock_height')  String unlockHeight,  String nonce, @JsonKey(name: 'balance_proof')  String balanceProof, @JsonKey(name: 'nonce_proof')  String nonceProof)?  $default,) {final _that = this;
switch (_that) {
case _StacksAccount() when $default != null:
return $default(_that.balance,_that.locked,_that.unlockHeight,_that.nonce,_that.balanceProof,_that.nonceProof);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StacksAccount implements StacksAccount {
  const _StacksAccount({required this.balance, required this.locked, @JsonKey(name: 'unlock_height') required this.unlockHeight, required this.nonce, @JsonKey(name: 'balance_proof') required this.balanceProof, @JsonKey(name: 'nonce_proof') required this.nonceProof});
  factory _StacksAccount.fromJson(Map<String, dynamic> json) => _$StacksAccountFromJson(json);

@override final  String balance;
@override final  String locked;
@override@JsonKey(name: 'unlock_height') final  String unlockHeight;
@override final  String nonce;
@override@JsonKey(name: 'balance_proof') final  String balanceProof;
@override@JsonKey(name: 'nonce_proof') final  String nonceProof;

/// Create a copy of StacksAccount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StacksAccountCopyWith<_StacksAccount> get copyWith => __$StacksAccountCopyWithImpl<_StacksAccount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StacksAccountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StacksAccount&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.locked, locked) || other.locked == locked)&&(identical(other.unlockHeight, unlockHeight) || other.unlockHeight == unlockHeight)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.balanceProof, balanceProof) || other.balanceProof == balanceProof)&&(identical(other.nonceProof, nonceProof) || other.nonceProof == nonceProof));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,balance,locked,unlockHeight,nonce,balanceProof,nonceProof);

@override
String toString() {
  return 'StacksAccount(balance: $balance, locked: $locked, unlockHeight: $unlockHeight, nonce: $nonce, balanceProof: $balanceProof, nonceProof: $nonceProof)';
}


}

/// @nodoc
abstract mixin class _$StacksAccountCopyWith<$Res> implements $StacksAccountCopyWith<$Res> {
  factory _$StacksAccountCopyWith(_StacksAccount value, $Res Function(_StacksAccount) _then) = __$StacksAccountCopyWithImpl;
@override @useResult
$Res call({
 String balance, String locked,@JsonKey(name: 'unlock_height') String unlockHeight, String nonce,@JsonKey(name: 'balance_proof') String balanceProof,@JsonKey(name: 'nonce_proof') String nonceProof
});




}
/// @nodoc
class __$StacksAccountCopyWithImpl<$Res>
    implements _$StacksAccountCopyWith<$Res> {
  __$StacksAccountCopyWithImpl(this._self, this._then);

  final _StacksAccount _self;
  final $Res Function(_StacksAccount) _then;

/// Create a copy of StacksAccount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? balance = null,Object? locked = null,Object? unlockHeight = null,Object? nonce = null,Object? balanceProof = null,Object? nonceProof = null,}) {
  return _then(_StacksAccount(
balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as String,locked: null == locked ? _self.locked : locked // ignore: cast_nullable_to_non_nullable
as String,unlockHeight: null == unlockHeight ? _self.unlockHeight : unlockHeight // ignore: cast_nullable_to_non_nullable
as String,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String,balanceProof: null == balanceProof ? _self.balanceProof : balanceProof // ignore: cast_nullable_to_non_nullable
as String,nonceProof: null == nonceProof ? _self.nonceProof : nonceProof // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$FeeEstimation {

@JsonKey(name: 'cost_scalar_change_by_byte') double get costScalarChangeByByte;@JsonKey(name: 'estimated_cost') EstimatedCost get estimatedCost;@JsonKey(name: 'estimated_cost_scalar') int get estimatedCostScalar; List<Estimation> get estimations;
/// Create a copy of FeeEstimation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeeEstimationCopyWith<FeeEstimation> get copyWith => _$FeeEstimationCopyWithImpl<FeeEstimation>(this as FeeEstimation, _$identity);

  /// Serializes this FeeEstimation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeeEstimation&&(identical(other.costScalarChangeByByte, costScalarChangeByByte) || other.costScalarChangeByByte == costScalarChangeByByte)&&(identical(other.estimatedCost, estimatedCost) || other.estimatedCost == estimatedCost)&&(identical(other.estimatedCostScalar, estimatedCostScalar) || other.estimatedCostScalar == estimatedCostScalar)&&const DeepCollectionEquality().equals(other.estimations, estimations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,costScalarChangeByByte,estimatedCost,estimatedCostScalar,const DeepCollectionEquality().hash(estimations));

@override
String toString() {
  return 'FeeEstimation(costScalarChangeByByte: $costScalarChangeByByte, estimatedCost: $estimatedCost, estimatedCostScalar: $estimatedCostScalar, estimations: $estimations)';
}


}

/// @nodoc
abstract mixin class $FeeEstimationCopyWith<$Res>  {
  factory $FeeEstimationCopyWith(FeeEstimation value, $Res Function(FeeEstimation) _then) = _$FeeEstimationCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'cost_scalar_change_by_byte') double costScalarChangeByByte,@JsonKey(name: 'estimated_cost') EstimatedCost estimatedCost,@JsonKey(name: 'estimated_cost_scalar') int estimatedCostScalar, List<Estimation> estimations
});


$EstimatedCostCopyWith<$Res> get estimatedCost;

}
/// @nodoc
class _$FeeEstimationCopyWithImpl<$Res>
    implements $FeeEstimationCopyWith<$Res> {
  _$FeeEstimationCopyWithImpl(this._self, this._then);

  final FeeEstimation _self;
  final $Res Function(FeeEstimation) _then;

/// Create a copy of FeeEstimation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? costScalarChangeByByte = null,Object? estimatedCost = null,Object? estimatedCostScalar = null,Object? estimations = null,}) {
  return _then(_self.copyWith(
costScalarChangeByByte: null == costScalarChangeByByte ? _self.costScalarChangeByByte : costScalarChangeByByte // ignore: cast_nullable_to_non_nullable
as double,estimatedCost: null == estimatedCost ? _self.estimatedCost : estimatedCost // ignore: cast_nullable_to_non_nullable
as EstimatedCost,estimatedCostScalar: null == estimatedCostScalar ? _self.estimatedCostScalar : estimatedCostScalar // ignore: cast_nullable_to_non_nullable
as int,estimations: null == estimations ? _self.estimations : estimations // ignore: cast_nullable_to_non_nullable
as List<Estimation>,
  ));
}
/// Create a copy of FeeEstimation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EstimatedCostCopyWith<$Res> get estimatedCost {
  
  return $EstimatedCostCopyWith<$Res>(_self.estimatedCost, (value) {
    return _then(_self.copyWith(estimatedCost: value));
  });
}
}


/// Adds pattern-matching-related methods to [FeeEstimation].
extension FeeEstimationPatterns on FeeEstimation {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeeEstimation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeeEstimation() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeeEstimation value)  $default,){
final _that = this;
switch (_that) {
case _FeeEstimation():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeeEstimation value)?  $default,){
final _that = this;
switch (_that) {
case _FeeEstimation() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'cost_scalar_change_by_byte')  double costScalarChangeByByte, @JsonKey(name: 'estimated_cost')  EstimatedCost estimatedCost, @JsonKey(name: 'estimated_cost_scalar')  int estimatedCostScalar,  List<Estimation> estimations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeeEstimation() when $default != null:
return $default(_that.costScalarChangeByByte,_that.estimatedCost,_that.estimatedCostScalar,_that.estimations);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'cost_scalar_change_by_byte')  double costScalarChangeByByte, @JsonKey(name: 'estimated_cost')  EstimatedCost estimatedCost, @JsonKey(name: 'estimated_cost_scalar')  int estimatedCostScalar,  List<Estimation> estimations)  $default,) {final _that = this;
switch (_that) {
case _FeeEstimation():
return $default(_that.costScalarChangeByByte,_that.estimatedCost,_that.estimatedCostScalar,_that.estimations);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'cost_scalar_change_by_byte')  double costScalarChangeByByte, @JsonKey(name: 'estimated_cost')  EstimatedCost estimatedCost, @JsonKey(name: 'estimated_cost_scalar')  int estimatedCostScalar,  List<Estimation> estimations)?  $default,) {final _that = this;
switch (_that) {
case _FeeEstimation() when $default != null:
return $default(_that.costScalarChangeByByte,_that.estimatedCost,_that.estimatedCostScalar,_that.estimations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeeEstimation implements FeeEstimation {
  const _FeeEstimation({@JsonKey(name: 'cost_scalar_change_by_byte') required this.costScalarChangeByByte, @JsonKey(name: 'estimated_cost') required this.estimatedCost, @JsonKey(name: 'estimated_cost_scalar') required this.estimatedCostScalar, required final  List<Estimation> estimations}): _estimations = estimations;
  factory _FeeEstimation.fromJson(Map<String, dynamic> json) => _$FeeEstimationFromJson(json);

@override@JsonKey(name: 'cost_scalar_change_by_byte') final  double costScalarChangeByByte;
@override@JsonKey(name: 'estimated_cost') final  EstimatedCost estimatedCost;
@override@JsonKey(name: 'estimated_cost_scalar') final  int estimatedCostScalar;
 final  List<Estimation> _estimations;
@override List<Estimation> get estimations {
  if (_estimations is EqualUnmodifiableListView) return _estimations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_estimations);
}


/// Create a copy of FeeEstimation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeeEstimationCopyWith<_FeeEstimation> get copyWith => __$FeeEstimationCopyWithImpl<_FeeEstimation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeeEstimationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeeEstimation&&(identical(other.costScalarChangeByByte, costScalarChangeByByte) || other.costScalarChangeByByte == costScalarChangeByByte)&&(identical(other.estimatedCost, estimatedCost) || other.estimatedCost == estimatedCost)&&(identical(other.estimatedCostScalar, estimatedCostScalar) || other.estimatedCostScalar == estimatedCostScalar)&&const DeepCollectionEquality().equals(other._estimations, _estimations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,costScalarChangeByByte,estimatedCost,estimatedCostScalar,const DeepCollectionEquality().hash(_estimations));

@override
String toString() {
  return 'FeeEstimation(costScalarChangeByByte: $costScalarChangeByByte, estimatedCost: $estimatedCost, estimatedCostScalar: $estimatedCostScalar, estimations: $estimations)';
}


}

/// @nodoc
abstract mixin class _$FeeEstimationCopyWith<$Res> implements $FeeEstimationCopyWith<$Res> {
  factory _$FeeEstimationCopyWith(_FeeEstimation value, $Res Function(_FeeEstimation) _then) = __$FeeEstimationCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'cost_scalar_change_by_byte') double costScalarChangeByByte,@JsonKey(name: 'estimated_cost') EstimatedCost estimatedCost,@JsonKey(name: 'estimated_cost_scalar') int estimatedCostScalar, List<Estimation> estimations
});


@override $EstimatedCostCopyWith<$Res> get estimatedCost;

}
/// @nodoc
class __$FeeEstimationCopyWithImpl<$Res>
    implements _$FeeEstimationCopyWith<$Res> {
  __$FeeEstimationCopyWithImpl(this._self, this._then);

  final _FeeEstimation _self;
  final $Res Function(_FeeEstimation) _then;

/// Create a copy of FeeEstimation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? costScalarChangeByByte = null,Object? estimatedCost = null,Object? estimatedCostScalar = null,Object? estimations = null,}) {
  return _then(_FeeEstimation(
costScalarChangeByByte: null == costScalarChangeByByte ? _self.costScalarChangeByByte : costScalarChangeByByte // ignore: cast_nullable_to_non_nullable
as double,estimatedCost: null == estimatedCost ? _self.estimatedCost : estimatedCost // ignore: cast_nullable_to_non_nullable
as EstimatedCost,estimatedCostScalar: null == estimatedCostScalar ? _self.estimatedCostScalar : estimatedCostScalar // ignore: cast_nullable_to_non_nullable
as int,estimations: null == estimations ? _self._estimations : estimations // ignore: cast_nullable_to_non_nullable
as List<Estimation>,
  ));
}

/// Create a copy of FeeEstimation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EstimatedCostCopyWith<$Res> get estimatedCost {
  
  return $EstimatedCostCopyWith<$Res>(_self.estimatedCost, (value) {
    return _then(_self.copyWith(estimatedCost: value));
  });
}
}


/// @nodoc
mixin _$EstimatedCost {

@JsonKey(name: 'read_count') int get readCount;@JsonKey(name: 'read_length') int get readLength; int get runtime;@JsonKey(name: 'write_count') int get writeCount;@JsonKey(name: 'write_length') int get writeLength;
/// Create a copy of EstimatedCost
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EstimatedCostCopyWith<EstimatedCost> get copyWith => _$EstimatedCostCopyWithImpl<EstimatedCost>(this as EstimatedCost, _$identity);

  /// Serializes this EstimatedCost to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EstimatedCost&&(identical(other.readCount, readCount) || other.readCount == readCount)&&(identical(other.readLength, readLength) || other.readLength == readLength)&&(identical(other.runtime, runtime) || other.runtime == runtime)&&(identical(other.writeCount, writeCount) || other.writeCount == writeCount)&&(identical(other.writeLength, writeLength) || other.writeLength == writeLength));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,readCount,readLength,runtime,writeCount,writeLength);

@override
String toString() {
  return 'EstimatedCost(readCount: $readCount, readLength: $readLength, runtime: $runtime, writeCount: $writeCount, writeLength: $writeLength)';
}


}

/// @nodoc
abstract mixin class $EstimatedCostCopyWith<$Res>  {
  factory $EstimatedCostCopyWith(EstimatedCost value, $Res Function(EstimatedCost) _then) = _$EstimatedCostCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'read_count') int readCount,@JsonKey(name: 'read_length') int readLength, int runtime,@JsonKey(name: 'write_count') int writeCount,@JsonKey(name: 'write_length') int writeLength
});




}
/// @nodoc
class _$EstimatedCostCopyWithImpl<$Res>
    implements $EstimatedCostCopyWith<$Res> {
  _$EstimatedCostCopyWithImpl(this._self, this._then);

  final EstimatedCost _self;
  final $Res Function(EstimatedCost) _then;

/// Create a copy of EstimatedCost
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? readCount = null,Object? readLength = null,Object? runtime = null,Object? writeCount = null,Object? writeLength = null,}) {
  return _then(_self.copyWith(
readCount: null == readCount ? _self.readCount : readCount // ignore: cast_nullable_to_non_nullable
as int,readLength: null == readLength ? _self.readLength : readLength // ignore: cast_nullable_to_non_nullable
as int,runtime: null == runtime ? _self.runtime : runtime // ignore: cast_nullable_to_non_nullable
as int,writeCount: null == writeCount ? _self.writeCount : writeCount // ignore: cast_nullable_to_non_nullable
as int,writeLength: null == writeLength ? _self.writeLength : writeLength // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [EstimatedCost].
extension EstimatedCostPatterns on EstimatedCost {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EstimatedCost value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EstimatedCost() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EstimatedCost value)  $default,){
final _that = this;
switch (_that) {
case _EstimatedCost():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EstimatedCost value)?  $default,){
final _that = this;
switch (_that) {
case _EstimatedCost() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'read_count')  int readCount, @JsonKey(name: 'read_length')  int readLength,  int runtime, @JsonKey(name: 'write_count')  int writeCount, @JsonKey(name: 'write_length')  int writeLength)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EstimatedCost() when $default != null:
return $default(_that.readCount,_that.readLength,_that.runtime,_that.writeCount,_that.writeLength);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'read_count')  int readCount, @JsonKey(name: 'read_length')  int readLength,  int runtime, @JsonKey(name: 'write_count')  int writeCount, @JsonKey(name: 'write_length')  int writeLength)  $default,) {final _that = this;
switch (_that) {
case _EstimatedCost():
return $default(_that.readCount,_that.readLength,_that.runtime,_that.writeCount,_that.writeLength);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'read_count')  int readCount, @JsonKey(name: 'read_length')  int readLength,  int runtime, @JsonKey(name: 'write_count')  int writeCount, @JsonKey(name: 'write_length')  int writeLength)?  $default,) {final _that = this;
switch (_that) {
case _EstimatedCost() when $default != null:
return $default(_that.readCount,_that.readLength,_that.runtime,_that.writeCount,_that.writeLength);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EstimatedCost implements EstimatedCost {
  const _EstimatedCost({@JsonKey(name: 'read_count') required this.readCount, @JsonKey(name: 'read_length') required this.readLength, required this.runtime, @JsonKey(name: 'write_count') required this.writeCount, @JsonKey(name: 'write_length') required this.writeLength});
  factory _EstimatedCost.fromJson(Map<String, dynamic> json) => _$EstimatedCostFromJson(json);

@override@JsonKey(name: 'read_count') final  int readCount;
@override@JsonKey(name: 'read_length') final  int readLength;
@override final  int runtime;
@override@JsonKey(name: 'write_count') final  int writeCount;
@override@JsonKey(name: 'write_length') final  int writeLength;

/// Create a copy of EstimatedCost
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EstimatedCostCopyWith<_EstimatedCost> get copyWith => __$EstimatedCostCopyWithImpl<_EstimatedCost>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EstimatedCostToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EstimatedCost&&(identical(other.readCount, readCount) || other.readCount == readCount)&&(identical(other.readLength, readLength) || other.readLength == readLength)&&(identical(other.runtime, runtime) || other.runtime == runtime)&&(identical(other.writeCount, writeCount) || other.writeCount == writeCount)&&(identical(other.writeLength, writeLength) || other.writeLength == writeLength));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,readCount,readLength,runtime,writeCount,writeLength);

@override
String toString() {
  return 'EstimatedCost(readCount: $readCount, readLength: $readLength, runtime: $runtime, writeCount: $writeCount, writeLength: $writeLength)';
}


}

/// @nodoc
abstract mixin class _$EstimatedCostCopyWith<$Res> implements $EstimatedCostCopyWith<$Res> {
  factory _$EstimatedCostCopyWith(_EstimatedCost value, $Res Function(_EstimatedCost) _then) = __$EstimatedCostCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'read_count') int readCount,@JsonKey(name: 'read_length') int readLength, int runtime,@JsonKey(name: 'write_count') int writeCount,@JsonKey(name: 'write_length') int writeLength
});




}
/// @nodoc
class __$EstimatedCostCopyWithImpl<$Res>
    implements _$EstimatedCostCopyWith<$Res> {
  __$EstimatedCostCopyWithImpl(this._self, this._then);

  final _EstimatedCost _self;
  final $Res Function(_EstimatedCost) _then;

/// Create a copy of EstimatedCost
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? readCount = null,Object? readLength = null,Object? runtime = null,Object? writeCount = null,Object? writeLength = null,}) {
  return _then(_EstimatedCost(
readCount: null == readCount ? _self.readCount : readCount // ignore: cast_nullable_to_non_nullable
as int,readLength: null == readLength ? _self.readLength : readLength // ignore: cast_nullable_to_non_nullable
as int,runtime: null == runtime ? _self.runtime : runtime // ignore: cast_nullable_to_non_nullable
as int,writeCount: null == writeCount ? _self.writeCount : writeCount // ignore: cast_nullable_to_non_nullable
as int,writeLength: null == writeLength ? _self.writeLength : writeLength // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$Estimation {

 int get fee;@JsonKey(name: 'fee_rate') double get feeRate;
/// Create a copy of Estimation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EstimationCopyWith<Estimation> get copyWith => _$EstimationCopyWithImpl<Estimation>(this as Estimation, _$identity);

  /// Serializes this Estimation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Estimation&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.feeRate, feeRate) || other.feeRate == feeRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fee,feeRate);

@override
String toString() {
  return 'Estimation(fee: $fee, feeRate: $feeRate)';
}


}

/// @nodoc
abstract mixin class $EstimationCopyWith<$Res>  {
  factory $EstimationCopyWith(Estimation value, $Res Function(Estimation) _then) = _$EstimationCopyWithImpl;
@useResult
$Res call({
 int fee,@JsonKey(name: 'fee_rate') double feeRate
});




}
/// @nodoc
class _$EstimationCopyWithImpl<$Res>
    implements $EstimationCopyWith<$Res> {
  _$EstimationCopyWithImpl(this._self, this._then);

  final Estimation _self;
  final $Res Function(Estimation) _then;

/// Create a copy of Estimation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fee = null,Object? feeRate = null,}) {
  return _then(_self.copyWith(
fee: null == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as int,feeRate: null == feeRate ? _self.feeRate : feeRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [Estimation].
extension EstimationPatterns on Estimation {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Estimation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Estimation() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Estimation value)  $default,){
final _that = this;
switch (_that) {
case _Estimation():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Estimation value)?  $default,){
final _that = this;
switch (_that) {
case _Estimation() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int fee, @JsonKey(name: 'fee_rate')  double feeRate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Estimation() when $default != null:
return $default(_that.fee,_that.feeRate);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int fee, @JsonKey(name: 'fee_rate')  double feeRate)  $default,) {final _that = this;
switch (_that) {
case _Estimation():
return $default(_that.fee,_that.feeRate);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int fee, @JsonKey(name: 'fee_rate')  double feeRate)?  $default,) {final _that = this;
switch (_that) {
case _Estimation() when $default != null:
return $default(_that.fee,_that.feeRate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Estimation implements Estimation {
  const _Estimation({required this.fee, @JsonKey(name: 'fee_rate') required this.feeRate});
  factory _Estimation.fromJson(Map<String, dynamic> json) => _$EstimationFromJson(json);

@override final  int fee;
@override@JsonKey(name: 'fee_rate') final  double feeRate;

/// Create a copy of Estimation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EstimationCopyWith<_Estimation> get copyWith => __$EstimationCopyWithImpl<_Estimation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EstimationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Estimation&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.feeRate, feeRate) || other.feeRate == feeRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fee,feeRate);

@override
String toString() {
  return 'Estimation(fee: $fee, feeRate: $feeRate)';
}


}

/// @nodoc
abstract mixin class _$EstimationCopyWith<$Res> implements $EstimationCopyWith<$Res> {
  factory _$EstimationCopyWith(_Estimation value, $Res Function(_Estimation) _then) = __$EstimationCopyWithImpl;
@override @useResult
$Res call({
 int fee,@JsonKey(name: 'fee_rate') double feeRate
});




}
/// @nodoc
class __$EstimationCopyWithImpl<$Res>
    implements _$EstimationCopyWith<$Res> {
  __$EstimationCopyWithImpl(this._self, this._then);

  final _Estimation _self;
  final $Res Function(_Estimation) _then;

/// Create a copy of Estimation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fee = null,Object? feeRate = null,}) {
  return _then(_Estimation(
fee: null == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as int,feeRate: null == feeRate ? _self.feeRate : feeRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
