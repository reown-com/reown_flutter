/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:convert' show base64;
import 'package:reown_appkit/solana/solana_borsh/borsh.dart';
import 'package:reown_appkit/solana/solana_borsh/codecs.dart';
import 'package:reown_appkit/solana/solana_common/extensions.dart';
import 'package:reown_appkit/solana/solana_common/models.dart';
import '../../crypto/pubkey.dart';

/// Address Lookup Table State
/// ------------------------------------------------------------------------------------------------

class AddressLookupTableState extends Serializable {
  const AddressLookupTableState({
    this.typeIndex = 1,
    required this.deactivationSlot,
    required this.lastExtendedSlot,
    required this.lastExtendedSlotStartIndex,
    required this.authority,
    required this.addresses,
  });

  final int typeIndex;

  final BigInt deactivationSlot;

  final BigInt lastExtendedSlot;

  final int lastExtendedSlotStartIndex;

  final Pubkey? authority;

  final List<Pubkey> addresses;

  static BorshStructCodec get metaCodec => borsh.struct({
    'typeIndex': borsh.u32,
    'deactivationSlot': borsh.u64,
    'lastExtendedSlot': borsh.u64,
    'lastExtendedSlotStartIndex': borsh.u8,
    'authority': borsh.pubkey.option(),
  });

  /// {@macro solana_borsh.BorshObject.fromBorsh}
  static AddressLookupTableState fromBorsh(final Iterable<int> buffer) {
    const int metaLength = 56;
    const String addressesKey = 'addresses';
    final metaSchema = metaCodec.schema;
    final int addressesLength = (buffer.length - metaLength) ~/ 32;
    final addressesSchema = {
      addressesKey: borsh.arraySized(borsh.pubkey, addressesLength),
    };
    final Map<String, dynamic> json = borsh.decode(metaSchema, buffer);
    json.addAll(borsh.decode(addressesSchema, buffer.skip(metaLength)));
    return AddressLookupTableState.fromJson(json);
  }

  /// {@macro solana_borsh.BorshObject.tryFromBorsh}
  static AddressLookupTableState? tryFromBorsh(final Iterable<int>? buffer) =>
      buffer != null ? AddressLookupTableState.fromBorsh(buffer) : null;

  /// {@macro solana_borsh.BorshObject.fromBorshBase64}
  static AddressLookupTableState fromBorshBase64(final String encoded) =>
      AddressLookupTableState.fromBorsh(base64.decode(encoded));

  /// {@macro solana_borsh.BorshObject.tryFromBorshBase64}
  static AddressLookupTableState? tryFromBorshBase64(final String? encoded) =>
      encoded != null ? AddressLookupTableState.fromBorshBase64(encoded) : null;

  factory AddressLookupTableState.fromJson(final Map<String, dynamic> json) =>
      AddressLookupTableState(
        typeIndex: json['typeIndex'],
        deactivationSlot: json['deactivationSlot'],
        lastExtendedSlot: json['lastExtendedSlot'],
        lastExtendedSlotStartIndex: json['lastExtendedSlotStartIndex'],
        authority: Pubkey.tryFromBase58(json['authority']),
        addresses: IterableSerializable.fromJson(
          json['addresses'],
          Pubkey.fromBase58,
        ),
      );

  @override
  Map<String, dynamic> toJson() => {
    'typeIndex': typeIndex,
    'deactivationSlot': deactivationSlot,
    'lastExtendedSlot': lastExtendedSlot,
    'lastExtendedSlotStartIndex': lastExtendedSlotStartIndex,
    'authority': authority?.toBase58(),
    'addresses': addresses.toJson(),
  };
}

/// Address Lookup Table Account
/// ------------------------------------------------------------------------------------------------

class AddressLookupTableAccount extends Serializable {
  const AddressLookupTableAccount({required this.key, required this.state});

  final Pubkey key;

  final AddressLookupTableState state;

  bool get isActive {
    final u64Max = BigInt.parse('FFFFFFFFFFFFFFFF', radix: 16);
    return state.deactivationSlot == u64Max;
  }

  /// {@macro solana_common.Serializable.fromJson}
  factory AddressLookupTableAccount.fromJson(final Map<String, dynamic> json) =>
      AddressLookupTableAccount(
        key: json['key'],
        state: AddressLookupTableState.fromJson(json['state']),
      );

  @override
  Map<String, dynamic> toJson() => {'key': key, 'state': state.toJson()};
}
