/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:json_annotation/json_annotation.dart'
    show JsonSerializable, JsonEnum, $enumDecode;
import 'package:reown_appkit/solana/solana_borsh/borsh.dart';
import 'package:reown_appkit/solana/solana_borsh/codecs.dart';
import 'package:reown_appkit/solana/solana_borsh/models.dart'
    show BorshObjectSized, RustEnum;
import 'package:reown_appkit/solana/solana_borsh/types.dart'
    show BorshSchemaSized;
import 'package:reown_appkit/solana/solana_common/types.dart' show u8, u64;
import '../../crypto/pubkey.dart';

part 'state.g.dart';

/// Data V2
/// ------------------------------------------------------------------------------------------------

class DataV2 {
  const DataV2({
    required this.name,
    required this.symbol,
    required this.uri,
    required this.sellerFeeBasisPoints,
    this.creators,
    this.collection,
    this.uses,
  });

  /// The on-chain name of the token, limited to 32 bytes. For instance "Degen Ape #1 ".
  final String name;

  /// The on-chain symbol of the token, limited to 10 bytes. For instance "DAPE".
  final String symbol;

  /// The URI of the token, limited to 200 bytes. This URI points to an off-chain JSON file that
  /// contains additional data following a certain standard. You can learn more about this JSON
  /// standard [here](https://docs.metaplex.com/programs/token-metadata/token-standard). The JSON
  /// file can either be stored in a traditional server (e.g. using AWS) or using a permanent
  /// storage solution such as using Arweave.
  final String uri;

  /// The royalties shared by the creators in basis points — i.e. 550 means 5.5%. Whilst this field
  /// is used by virtually all NFT marketplaces, it is not enforced by the Token Metadata program
  /// itself.
  final int sellerFeeBasisPoints;

  /// An array of creators and their share of the royalties. This array is limited to 5 creators.
  /// Note that, because the Creators field is an array of variable length, we cannot guarantee the
  /// byte position of any field that follows.
  final List<MetadataCreator>? creators;

  /// This field optionally links to the Mint address of another NFT that acts as a Collection NFT.
  final MetadataCollection? collection;

  /// This field can make NFTs usable. Meaning you can load it with a certain amount of "uses" and
  /// use it until it has run out. You can learn more about using NFTs
  /// [here](https://docs.metaplex.com/programs/token-metadata/using-nfts).
  final MetadataUses? uses;
}

/// Metadata Creator
/// ------------------------------------------------------------------------------------------------

@JsonSerializable(explicitToJson: true)
class MetadataCreator extends BorshObjectSized {
  /// An array of creators and their share of the royalties. This array is limited to 5 creators.
  /// Note that, because the Creators field is an array of variable length, we cannot guarantee the
  /// byte position of any field that follows (Notice the tilde ~ in the fields below). Each creator
  /// contains the following fields.
  const MetadataCreator({
    required this.address,
    required this.verified,
    required this.share,
  });

  /// The public key of the creator.
  final Pubkey address;

  /// A boolean indicating if the creator signed the NFT. It is important to check this field to
  /// ensure the authenticity of the creator.
  final bool verified;

  /// The creator's shares of the royalties in percentage (1 byte) — i.e. 55 means 55%. Similarly to
  /// the Seller Fee Basis Points field, this is used by marketplaces but not enforced by the Token
  /// Metadata program.
  final u8 share;

  /// {@macro solana_borsh.BorshObject.borshCodec}
  static BorshStructSizedCodec get codec => borsh.structSized({
        'address': borsh.pubkey,
        'verified': borsh.boolean,
        'share': borsh.u8,
      });

  @override
  BorshSchemaSized get borshSchema => codec.schema;

  /// {@macro solana_common.Serializable.fromJson}
  factory MetadataCreator.fromJson(final Map<String, dynamic> json) =>
      _$MetadataCreatorFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MetadataCreatorToJson(this);
}

/// Metadata Collection
/// ------------------------------------------------------------------------------------------------

@JsonSerializable(explicitToJson: true)
class MetadataCollection extends BorshObjectSized {
  /// Links to the Mint address of another NFT that acts as a Collection NFT. It contains the
  /// following sub-fields.
  const MetadataCollection({
    required this.verified,
    required this.key,
  });

  /// A boolean indicating if the owner of the Collection NFT signed this NFT. It is important to
  /// check this field to ensure the authenticity of the collection.
  final bool verified;

  /// The public key of the Collection NFT's Mint Account.
  final Pubkey key;

  /// {@macro solana_borsh.BorshObject.borshCodec}
  static BorshStructSizedCodec get codec => borsh.structSized({
        'verified': borsh.boolean,
        'key': borsh.pubkey,
      });

  @override
  BorshSchemaSized get borshSchema => codec.schema;

  /// {@macro solana_common.Serializable.fromJson}
  factory MetadataCollection.fromJson(final Map<String, dynamic> json) =>
      _$MetadataCollectionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MetadataCollectionToJson(this);
}

/// Metadata Use Method
/// ------------------------------------------------------------------------------------------------

@JsonEnum(valueField: 'index')
enum MetadataUseMethod {
  burn,
  multiple,
  single,
  ;
}

/// Metadata Use
/// ------------------------------------------------------------------------------------------------

@JsonSerializable()
class MetadataUses extends BorshObjectSized {
  /// Make NFTs usable, meaning you can load it with a certain amount of "uses" and use it until it
  /// has run out. You can learn more about using NFTs [here](https://docs.metaplex.com/programs/token-metadata/using-nfts).
  const MetadataUses({
    required this.useMethod,
    required this.remaining,
    required this.total,
  });

  /// An enum defining the use behaviour for the NFT.
  final MetadataUseMethod useMethod;

  /// The remaining amount of uses.
  final u64 remaining;

  /// The total amount of uses allowed in the first place.
  final u64 total;

  /// {@macro solana_borsh.BorshObject.borshCodec}
  static BorshStructSizedCodec get codec => borsh.structSized({
        'useMethod': borsh.enumeration(MetadataUseMethod.values),
        'remaining': borsh.u64,
        'total': borsh.u64,
      });

  @override
  BorshSchemaSized get borshSchema => codec.schema;

  /// {@macro solana_common.Serializable.fromJson}
  factory MetadataUses.fromJson(final Map<String, dynamic> json) =>
      _$MetadataUsesFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MetadataUsesToJson(this);
}

/// Metadata Collection Details V1 (Enum Variant)
/// ------------------------------------------------------------------------------------------------

@JsonSerializable()
class MetadataCollectionDetailsV1 extends BorshObjectSized {
  const MetadataCollectionDetailsV1({
    required this.size,
  });

  /// The size of the collection, i.e. the number of NFTs that are directly linked to this
  /// `Collection NFT`.
  final u64 size;

  /// {@macro solana_borsh.BorshObject.borshCodec}
  static BorshStructSizedCodec get codec => borsh.structSized({
        'size': borsh.u64,
      });

  @override
  BorshSchemaSized get borshSchema => codec.schema;

  /// {@macro solana_common.Serializable.fromJson}
  factory MetadataCollectionDetailsV1.fromJson(
          final Map<String, dynamic> json) =>
      _$MetadataCollectionDetailsV1FromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MetadataCollectionDetailsV1ToJson(this);
}

/// Metadata Collection Details
/// ------------------------------------------------------------------------------------------------

class MetadataCollectionDetails extends RustEnum {
  /// Allows us to differentiate Collection NFTs from Regular NFTs whilst adding additional context
  /// such as the amount of NFTs that are linked to the Collection NFT. You can learn more about the
  /// sized collections [here](https://docs.metaplex.com/programs/token-metadata/certified-collections#differentiating-regular-nfts-from-collection-nfts).
  const MetadataCollectionDetails._(
    super.index,
    super.codec,
  );

  /// {@macro solana_borsh.BorshObject.borshCodec}
  static BorshRustEnumSizedCodec get codec => borsh.rustEnumerationSized([
        borsh.tupleSized(
            [borsh.structSized(MetadataCollectionDetailsV1.codec.schema)]),
      ]);

  /// The [size] of the collection.
  static MetadataCollectionDetails v1(final u64 size) =>
      MetadataCollectionDetails._(0, [MetadataCollectionDetailsV1(size: size)]);
}
