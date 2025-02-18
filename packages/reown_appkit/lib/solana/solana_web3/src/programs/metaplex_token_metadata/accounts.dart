/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:convert' show base64;
import 'package:json_annotation/json_annotation.dart';
import 'package:reown_appkit/solana/solana_borsh/borsh.dart';
import 'package:reown_appkit/solana/solana_borsh/codecs.dart';
import 'package:reown_appkit/solana/solana_borsh/models.dart';
import 'package:reown_appkit/solana/solana_borsh/types.dart';
import 'package:reown_appkit/solana/solana_web3/programs.dart';

import '../../rpc/models/account_info.dart';

part 'accounts.g.dart';

/// Master Edition Account
/// ------------------------------------------------------------------------------------------------

enum MasterEditionKey {
  v1(2),
  v2(6),
  ;

  const MasterEditionKey(this.discriminator);
  final int discriminator;
}

@JsonSerializable(explicitToJson: true)
class MasterEditionAccount extends BorshObjectSized {
  /// Master Edition Account Information.
  const MasterEditionAccount({
    required this.key,
    required this.supply,
    required this.maxSupply,
  });

  /// The discriminator of the account as an enum.
  final int key;

  /// The amount of NFTs printed from this Master Edition. This field is automatically computed by
  /// the program and cannot be manually updated. Once the Supply reaches the Max Supply, no more
  /// prints can be made from this Master Edition.
  final BigInt supply;

  /// The maximum number of times NFTs can be printed from this Master Edition. When set to None,
  /// the program will enable unlimited prints. You can disable NFT printing by setting the Max
  /// Supply to 0.
  final BigInt? maxSupply;

  /// {@macro solana_borsh.BorshObject.borshCodec}
  static BorshStructSizedCodec get codec => borsh.structSized({
        'key': borsh.u8,
        'supply': borsh.u64.string(),
        'maxSupply': borsh.u64.string().option(),
      });

  @override
  BorshSchemaSized get borshSchema => codec.schema;

  /// {@macro solana_borsh.BorshObject.fromBorsh}
  static MasterEditionAccount fromBorsh(final Iterable<int> buffer) =>
      borsh.deserialize(codec.schema, buffer, MasterEditionAccount.fromJson);

  /// {@macro solana_borsh.BorshObject.tryFromBorsh}
  static MasterEditionAccount? tryFromBorsh(final Iterable<int>? buffer) =>
      buffer != null ? MasterEditionAccount.fromBorsh(buffer) : null;

  /// {@macro solana_borsh.BorshObject.fromBorshBase64}
  static MasterEditionAccount fromBorshBase64(final String encoded) =>
      MasterEditionAccount.fromBorsh(base64.decode(encoded));

  /// {@macro solana_borsh.BorshObject.tryFromBorshBase64}
  static MasterEditionAccount? tryFromBorshBase64(final String? encoded) =>
      encoded != null ? MasterEditionAccount.fromBorshBase64(encoded) : null;

  /// Creates an instance of `this` class from an account [info].
  ///
  /// ```
  /// MasterEditionAccount.fromAccountInfo('AA==');
  /// ```
  factory MasterEditionAccount.fromAccountInfo(final AccountInfo info) {
    return info.isJson
        ? MasterEditionAccount.fromJson(info.jsonData)
        : MasterEditionAccount.fromBorshBase64(info.binaryData);
  }

  /// Creates an instance of `this` class from an account [info].
  ///
  /// Returns `null` if [info] is omitted.
  ///
  /// ```
  /// MasterEditionAccount.tryFromAccountInfo('AA==');
  /// ```
  static MasterEditionAccount? tryFromAccountInfo(final AccountInfo? info) =>
      info != null ? MasterEditionAccount.fromAccountInfo(info) : null;

  /// {@macro solana_common.Serializable.fromJson}
  factory MasterEditionAccount.fromJson(final Map<String, dynamic> json) =>
      _$MasterEditionAccountFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MasterEditionAccountToJson(this);
}

/// Metadata Account
/// ------------------------------------------------------------------------------------------------

enum MetadataKey {
  v1(4),
  ;

  const MetadataKey(this.discriminator);
  final int discriminator;
}

@JsonEnum(valueField: 'index')
enum TokenStandard {
  nonFungible,
  fungibleAsset,
  fungible,
  nonFungibleEdition,
  programmableNonFungible,
}

@JsonSerializable(explicitToJson: true)
class MetadataAccount extends BorshObject {
  /// Metadata Account Information.
  const MetadataAccount({
    required this.key,
    required this.updateAuthority,
    required this.mint,
    required this.name,
    required this.symbol,
    required this.uri,
    required this.sellerFeeBasisPoints,
    required this.creators,
    required this.primarySaleHappened,
    required this.isMutable,
    required this.editionNonce,
    required this.tokenStandard,
    required this.collection,
    required this.uses,
  });

  /// The discriminator of the account as an enum.
  final int key;

  /// The public key that is allowed to update this account.
  final String updateAuthority;

  /// The public key of the Mint Account it derives from.
  final String mint;

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

  /// A boolean indicating if the token has already been sold at least once. Once flipped to true,
  /// it cannot ever be False again. This field can affect the way royalties are distributed.
  final bool primarySaleHappened;

  /// A boolean indicating if the Metadata Account can be updated. Once flipped to false, it cannot
  /// ever be true again.
  final bool isMutable;

  /// A nonce used to verify the edition number of printed NFTs. It will only be set on Edition NFTs
  /// and not Master Edition NFTs.
  final int? editionNonce;

  /// This enum captures the fungibility of the token. You can learn more about the token standard
  /// [here](https://docs.metaplex.com/programs/token-metadata/token-standard).
  final TokenStandard? tokenStandard;

  /// This field optionally links to the Mint address of another NFT that acts as a Collection NFT.
  final MetadataCollection? collection;

  /// This field can make NFTs usable. Meaning you can load it with a certain amount of "uses" and
  /// use it until it has run out. You can learn more about using NFTs
  /// [here](https://docs.metaplex.com/programs/token-metadata/using-nfts).
  final MetadataUses? uses;

  // /// This optional enum allows us to differentiate Collection NFTs from Regular NFTs whilst adding
  // /// additional context such as the amount of NFTs that are linked to the Collection NFT. You can
  // /// learn more about the sized collections [here](https://docs.metaplex.com/programs/token-metadata/certified-collections#differentiating-regular-nfts-from-collection-nfts).
  // final MetadataCollectionDetails? collectionDetails;

  // /// This optional enum stores any data relevant to Programmable NFTs. The different variants of
  // /// the enum are used as versions so we can add more features later on without introducing
  // /// breaking changes. The latest version `V1` optionally contains the address of the RuleSet
  // /// defining authorization rules for the Programmable NFT. If no RuleSet is provided, then all
  // /// operations are allowed.
  // final programmableConfig;

  /// {@macro solana_borsh.BorshObject.borshCodec}
  static BorshStructCodec get codec => borsh.struct({
        'key': borsh.u8,
        'updateAuthority': borsh.pubkey,
        'mint': borsh.pubkey,
        'name': MetaplexTokenMetadataProgram.metadataNameCodec,
        'symbol': MetaplexTokenMetadataProgram.metadataSymbolCodec,
        'uri': MetaplexTokenMetadataProgram.metadataUriCodec,
        'sellerFeeBasisPoints':
            MetaplexTokenMetadataProgram.metadataSellerFeeBasisPointsCodec,
        'creators': MetaplexTokenMetadataProgram.metadataCreatorsCodec,
        'primarySaleHappened': borsh.boolean,
        'isMutable': borsh.boolean,
        'editionNonce': borsh.u8.option(),
        'tokenStandard': borsh.u8.option(),
        'collection': MetaplexTokenMetadataProgram.metadataCollectionCodec,
        'uses': MetaplexTokenMetadataProgram.metadataUsesCodec,
      });

  @override
  BorshSchema get borshSchema => codec.schema;

  /// {@macro solana_borsh.BorshObject.fromBorsh}
  static MetadataAccount fromBorsh(final Iterable<int> buffer) =>
      borsh.deserialize(codec.schema, buffer, MetadataAccount.fromJson);

  /// {@macro solana_borsh.BorshObject.tryFromBorsh}
  static MetadataAccount? tryFromBorsh(final Iterable<int>? buffer) =>
      buffer != null ? MetadataAccount.fromBorsh(buffer) : null;

  /// {@macro solana_borsh.BorshObject.fromBorshBase64}
  static MetadataAccount fromBorshBase64(final String encoded) =>
      MetadataAccount.fromBorsh(base64.decode(encoded));

  /// {@macro solana_borsh.BorshObject.tryFromBorshBase64}
  static MetadataAccount? tryFromBorshBase64(final String? encoded) =>
      encoded != null ? MetadataAccount.fromBorshBase64(encoded) : null;

  /// Creates an instance of `this` class from an account [info].
  ///
  /// ```
  /// MetadataAccount.fromAccountInfo('AA==');
  /// ```
  factory MetadataAccount.fromAccountInfo(final AccountInfo info) {
    return info.isJson
        ? MetadataAccount.fromJson(info.jsonData)
        : MetadataAccount.fromBorshBase64(info.binaryData);
  }

  /// Creates an instance of `this` class from an account [info].
  ///
  /// Returns `null` if [info] is omitted.
  ///
  /// ```
  /// MetadataAccount.tryFromAccountInfo('AA==');
  /// ```
  static MetadataAccount? tryFromAccountInfo(final AccountInfo? info) =>
      info != null ? MetadataAccount.fromAccountInfo(info) : null;

  /// {@macro solana_common.Serializable.fromJson}
  factory MetadataAccount.fromJson(final Map<String, dynamic> json) =>
      _$MetadataAccountFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MetadataAccountToJson(this);
}
