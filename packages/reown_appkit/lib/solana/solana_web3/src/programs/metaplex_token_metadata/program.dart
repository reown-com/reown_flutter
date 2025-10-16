/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:convert';
import 'package:reown_appkit/solana/solana_borsh/borsh.dart';
import 'package:reown_appkit/solana/solana_borsh/codecs.dart';
import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
import 'package:reown_appkit/solana/solana_common/extensions.dart';
import 'package:reown_appkit/solana/solana_common/types.dart';
import '../../constants/sysvar.dart';
import '../../crypto/pubkey.dart';
import '../../rpc/models/program_address.dart';
import '../../transactions/account_meta.dart';
import '../../transactions/transaction_instruction.dart';
import '../metaplex_token_metadata/state.dart';
import '../program.dart';
import '../system/program.dart';
import 'instruction.dart';

/// Metaplex Token Metadata Program
/// ------------------------------------------------------------------------------------------------

class MetaplexTokenMetadataProgram extends Program {
  MetaplexTokenMetadataProgram._()
    : super(Pubkey.fromBase58('metaqbxxUerdq28cj1RbAWkYQm3ybzjb6a8bt518x1s'));

  /// Internal singleton instance.
  static final MetaplexTokenMetadataProgram _instance =
      MetaplexTokenMetadataProgram._();

  /// The program id.
  static Pubkey get programId => _instance.pubkey;

  /// The metadata account seed.
  static const String metadataSeed = 'metadata';

  /// The edition account seed.
  static const String editionSeed = 'edition';

  @override
  Iterable<int> encodeInstruction<T extends Enum>(final T instruction) =>
      Buffer.fromUint8(
        (instruction as MetaplexTokenMetadataInstruction).discriminator,
      );

  /// Find the metadata account address of the given [mint].
  static ProgramAddress findMetadataAddress(final Pubkey mint) =>
      Pubkey.findProgramAddress([
        utf8.encode(metadataSeed),
        programId.toBytes(),
        mint.toBytes(),
      ], programId);

  /// Find the master edition account address of the given [mint].
  static ProgramAddress findEditionAddress(final Pubkey mint) =>
      Pubkey.findProgramAddress([
        utf8.encode(metadataSeed),
        programId.toBytes(),
        mint.toBytes(),
        utf8.encode(editionSeed),
      ], programId);

  // Codecs
  static BorshStringCodec get metadataNameCodec => borsh.string();
  static BorshStringCodec get metadataSymbolCodec => borsh.string();
  static BorshStringCodec get metadataUriCodec => borsh.string();
  static BorshUint16Codec get metadataSellerFeeBasisPointsCodec => borsh.u16;
  static BorshOptionSizedCodec get metadataCreatorsCodec =>
      borsh.vecSized(MetadataCreator.codec, 5).option();
  static BorshOptionSizedCodec get metadataCollectionCodec =>
      MetadataCollection.codec.option();
  static BorshOptionSizedCodec get metadataUsesCodec =>
      MetadataUses.codec.option();
  static BorshOptionSizedCodec get metadataCollectionDetailsCodec =>
      MetadataCollectionDetails.codec.option();

  /// This instruction enables us to update parts of the Metadata account. Note that some fields
  /// have constraints limiting how they can be updated. For instance, once the `isMutable` field is
  /// set to false, it cannot be changed back to true.
  ///
  /// Keys:
  /// - `[w]` [metadata] - Metadata key (pda of: 'metadata', program id, mint id).
  /// - `[s]` [updateAuthority] - Update authority info.
  ///
  /// Data:
  /// - [dataV2]
  ///
  ///   `name` - The on-chain name of the token, limited to 32 bytes. For instance "Degen Ape #1 ".
  ///
  ///   `symbol` - The on-chain symbol of the token, limited to 10 bytes. For instance "DAPE".
  ///
  ///   `uri` - The URI of the token, limited to 200 bytes. This URI points to an off-chain JSON
  ///     file that contains additional data following a certain standard. You can learn more about
  ///     this JSON standard [here](https://docs.metaplex.com/programs/token-metadata/token-standard).
  ///     The JSON file can either be stored in a traditional server (e.g. using AWS) or using a
  ///     permanent storage solution such as using Arweave.
  ///
  ///   `sellerFeeBasisPoints` - The royalties shared by the creators in basis points — i.e. 550
  ///     means 5.5%. Whilst this field is used by virtually all NFT marketplaces, it is not
  ///     enforced by the Token Metadata program itself.
  ///
  ///   `creators` - An array of creators and their share of the royalties. This array is limited to
  ///     5 creators. Note that, because the Creators field is an array of variable length, we
  ///     cannot guarantee the byte position of any field that follows.
  ///
  ///   `collection` - This field optionally links to the Mint address of another NFT that acts as
  ///     a Collection NFT.
  ///
  ///   `uses` - This field can make NFTs usable. Meaning you can load it with a certain amount of
  ///     "uses" and use it until it has run out. You can learn more about using NFTs
  ///     [here](https://docs.metaplex.com/programs/token-metadata/using-nfts).
  /// - [newUpdateAuthority] - The public key that is allowed to update this account.
  /// - [primarySaleHappened] - A boolean indicating if the token has already been sold at least
  ///     once. Once flipped to true, it cannot ever be False again. This field can affect the way
  ///     royalties are distributed.
  /// - [isMutable] - A boolean indicating if the Metadata Account can be updated. Once flipped to
  ///     false, it cannot ever be true again.
  static TransactionInstruction updateMetadataAccountV2({
    // Keys
    required final Pubkey metadata,
    required final Pubkey updateAuthority,
    // Data
    final DataV2? dataV2,
    final Pubkey? newUpdateAuthority,
    final bool? primarySaleHappened,
    final bool? isMutable,
  }) {
    final List<AccountMeta> keys = [
      AccountMeta.writable(metadata),
      AccountMeta.signer(updateAuthority),
    ];

    final booleanOption = borsh.boolean.option();
    final List<Iterable<u8>> data = [
      dataV2 != null ? const [1] : const [0], // Option flag
      if (dataV2 != null)
        [
          ...metadataNameCodec.encode(dataV2.name),
          ...metadataSymbolCodec.encode(dataV2.symbol),
          ...metadataUriCodec.encode(dataV2.uri),
          ...metadataSellerFeeBasisPointsCodec.encode(
            dataV2.sellerFeeBasisPoints,
          ),
          ...metadataCreatorsCodec.encode(dataV2.creators?.toJson()),
          ...metadataCollectionCodec.encode(dataV2.collection?.toJson()),
          ...metadataUsesCodec.encode(dataV2.uses?.toJson()),
        ],
      borsh.pubkey.option().encode(newUpdateAuthority?.toBase58()),
      booleanOption.encode(primarySaleHappened),
      booleanOption.encode(isMutable),
    ];

    return _instance.createTransactionIntruction(
      MetaplexTokenMetadataInstruction.updateMetadataAccountV2,
      keys: keys,
      data: data,
    );
  }

  /// This instruction creates and initializes a new Metadata account for a given Mint account. It
  /// is required that the Mint account has been created and initialized by the Token Program before
  /// executing this instruction.
  ///
  /// Keys:
  /// - `[w]` [metadata] - Metadata key (pda of: 'metadata', program id, mint id).
  /// - `[]` [mint] - Mint of token asset.
  /// - `[s]` [mintAuthority] - Mint authority.
  /// - `[s, w]` [payer] - Fee payer.
  /// - `[]` [updateAuthority] - Update authority info.
  ///
  /// Data:
  /// - [dataV2]
  ///
  ///   `name` - The on-chain name of the token, limited to 32 bytes. For instance "Degen Ape #1 ".
  ///
  ///   `symbol` - The on-chain symbol of the token, limited to 10 bytes. For instance "DAPE".
  ///
  ///   `uri` - The URI of the token, limited to 200 bytes. This URI points to an off-chain JSON
  ///     file that contains additional data following a certain standard. You can learn more about
  ///     this JSON standard [here](https://docs.metaplex.com/programs/token-metadata/token-standard).
  ///     The JSON file can either be stored in a traditional server (e.g. using AWS) or using a
  ///     permanent storage solution such as using Arweave.
  ///
  ///   `sellerFeeBasisPoints` - The royalties shared by the creators in basis points — i.e. 550
  ///     means 5.5%. Whilst this field is used by virtually all NFT marketplaces, it is not
  ///     enforced by the Token Metadata program itself.
  ///
  ///   `creators` - An array of creators and their share of the royalties. This array is limited to
  ///     5 creators. Note that, because the Creators field is an array of variable length, we
  ///     cannot guarantee the byte position of any field that follows.
  ///
  ///   `collection` - This field optionally links to the Mint address of another NFT that acts as
  ///     a Collection NFT.
  ///
  ///   `uses` - This field can make NFTs usable. Meaning you can load it with a certain amount of
  ///     "uses" and use it until it has run out. You can learn more about using NFTs
  ///     [here](https://docs.metaplex.com/programs/token-metadata/using-nfts).
  ///
  /// - [isMutable] - A boolean indicating if the Metadata Account can be updated. Once flipped to
  ///     false, it cannot ever be true again.
  /// - [collectionDetails] - Allows us to differentiate Collection NFTs from Regular NFTs whilst
  ///     adding additional context such as the amount of NFTs that are linked to the Collection
  ///     NFT.
  static TransactionInstruction createMetadataAccountV3({
    // Keys
    required final Pubkey metadata,
    required final Pubkey mint,
    required final Pubkey mintAuthority,
    required final Pubkey payer,
    required final Pubkey updateAuthority,
    // Data
    required final DataV2 dataV2,
    final bool isMutable = true,
    final MetadataCollectionDetails? collectionDetails,
  }) {
    final List<AccountMeta> keys = [
      AccountMeta.writable(metadata),
      AccountMeta(mint),
      AccountMeta.signer(mintAuthority),
      AccountMeta.signerAndWritable(payer),
      AccountMeta(updateAuthority),
      AccountMeta(SystemProgram.programId),
      AccountMeta(sysvarRentPubkey),
    ];

    final List<Iterable<u8>> data = [
      metadataNameCodec.encode(dataV2.name),
      metadataSymbolCodec.encode(dataV2.symbol),
      metadataUriCodec.encode(dataV2.uri),
      metadataSellerFeeBasisPointsCodec.encode(dataV2.sellerFeeBasisPoints),
      metadataCreatorsCodec.encode(dataV2.creators?.toJson()),
      metadataCollectionCodec.encode(dataV2.collection?.toJson()),
      metadataUsesCodec.encode(dataV2.uses?.toJson()),
      borsh.boolean.encode(isMutable),
      metadataCollectionDetailsCodec.encode(collectionDetails),
    ];

    return _instance.createTransactionIntruction(
      MetaplexTokenMetadataInstruction.createMetadataAccountV3,
      keys: keys,
      data: data,
    );
  }
}
