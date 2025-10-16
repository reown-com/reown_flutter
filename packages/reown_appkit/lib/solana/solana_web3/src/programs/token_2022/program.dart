/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../../crypto/pubkey.dart';
import '../program.dart';

/// Token Program 2022
/// ------------------------------------------------------------------------------------------------

class TokenProgram2022 extends Program {
  TokenProgram2022._()
    : super(Pubkey.fromBase58('TokenzQdBNbLqP5VEhdkAS6EPFLC1PHnBqCXEpPxuEb'));

  /// Internal singleton instance.
  static final TokenProgram2022 _instance = TokenProgram2022._();

  /// The program id.
  static Pubkey get programId => _instance.pubkey;

  // /// Initializes a new mint and optionally deposits all the newly minted
  // /// tokens in an account.
  // ///
  // /// The `InitializeMint` instruction requires no signers and MUST be
  // /// included within the same Transaction as the system program's
  // /// `CreateAccount` instruction that creates the account being initialized.
  // /// Otherwise another party can acquire ownership of the uninitialized
  // /// account.
  // ///
  // /// All extensions must be initialized before calling this instruction.
  // ///
  // /// Accounts expected by this instruction:
  // ///
  // ///   0. `[writable]` The mint to initialize.
  // ///   1. `[]` Rent sysvar
  // ///
  // InitializeMint {
  //     /// Number of base 10 digits to the right of the decimal place.
  //     decimals: u8,
  //     /// The authority/multisignature to mint tokens.
  //     #[cfg_attr(feature = "serde-traits", serde(with = "As::<DisplayFromStr>"))]
  //     mint_authority: Pubkey,
  //     /// The freeze authority/multisignature of the mint.
  //     #[cfg_attr(feature = "serde-traits", serde(with = "coption_fromstr"))]
  //     freeze_authority: COption<Pubkey>,
  // },
  // /// Initializes a new account to hold tokens.  If this account is associated
  // /// with the native mint then the token balance of the initialized account
  // /// will be equal to the amount of SOL in the account. If this account is
  // /// associated with another mint, that mint must be initialized before this
  // /// command can succeed.
  // ///
  // /// The `InitializeAccount` instruction requires no signers and MUST be
  // /// included within the same Transaction as the system program's
  // /// `CreateAccount` instruction that creates the account being initialized.
  // /// Otherwise another party can acquire ownership of the uninitialized
  // /// account.
  // ///
  // /// Accounts expected by this instruction:
  // ///
  // ///   0. `[writable]`  The account to initialize.
  // ///   1. `[]` The mint this account will be associated with.
  // ///   2. `[]` The new account's owner/multisignature.
  // ///   3. `[]` Rent sysvar
  // InitializeAccount,
  // /// Initializes a multisignature account with N provided signers.
  // ///
  // /// Multisignature accounts can used in place of any single owner/delegate
  // /// accounts in any token instruction that require an owner/delegate to be
  // /// present.  The variant field represents the number of signers (M)
  // /// required to validate this multisignature account.
  // ///
  // /// The `InitializeMultisig` instruction requires no signers and MUST be
  // /// included within the same Transaction as the system program's
  // /// `CreateAccount` instruction that creates the account being initialized.
  // /// Otherwise another party can acquire ownership of the uninitialized
  // /// account.
  // ///
  // /// Accounts expected by this instruction:
  // ///
  // ///   0. `[writable]` The multisignature account to initialize.
  // ///   1. `[]` Rent sysvar
  // ///   2. ..2+N. `[]` The signer accounts, must equal to N where 1 <= N <=
  // ///      11.
  // InitializeMultisig {
  //     /// The number of signers (M) required to validate this multisignature
  //     /// account.
  //     m: u8,
  // },
  // /// NOTE This instruction is deprecated in favor of `TransferChecked` or
  // /// `TransferCheckedWithFee`
  // ///
  // /// Transfers tokens from one account to another either directly or via a
  // /// delegate.  If this account is associated with the native mint then equal
  // /// amounts of SOL and Tokens will be transferred to the destination
  // /// account.
  // ///
  // /// If either account contains an `TransferFeeAmount` extension, this will fail.
  // /// Mints with the `TransferFeeConfig` extension are required in order to assess the fee.
  // ///
  // /// Accounts expected by this instruction:
  // ///
  // ///   * Single owner/delegate
  // ///   0. `[writable]` The source account.
  // ///   1. `[writable]` The destination account.
  // ///   2. `[signer]` The source account's owner/delegate.
  // ///
  // ///   * Multisignature owner/delegate
  // ///   0. `[writable]` The source account.
  // ///   1. `[writable]` The destination account.
  // ///   2. `[]` The source account's multisignature owner/delegate.
  // ///   3. ..3+M `[signer]` M signer accounts.
  // #[deprecated(
  //     since = "4.0.0",
  //     note = "please use `TransferChecked` or `TransferCheckedWithFee` instead"
  // )]
  // Transfer {
  //     /// The amount of tokens to transfer.
  //     amount: u64,
  // },
  // /// Approves a delegate.  A delegate is given the authority over tokens on
  // /// behalf of the source account's owner.
  // ///
  // /// Accounts expected by this instruction:
  // ///
  // ///   * Single owner
  // ///   0. `[writable]` The source account.
  // ///   1. `[]` The delegate.
  // ///   2. `[signer]` The source account owner.
  // ///
  // ///   * Multisignature owner
  // ///   0. `[writable]` The source account.
  // ///   1. `[]` The delegate.
  // ///   2. `[]` The source account's multisignature owner.
  // ///   3. ..3+M `[signer]` M signer accounts
  // Approve {
  //     /// The amount of tokens the delegate is approved for.
  //     amount: u64,
  // },
  // /// Revokes the delegate's authority.
  // ///
  // /// Accounts expected by this instruction:
  // ///
  // ///   * Single owner
  // ///   0. `[writable]` The source account.
  // ///   1. `[signer]` The source account owner or current delegate.
  // ///
  // ///   * Multisignature owner
  // ///   0. `[writable]` The source account.
  // ///   1. `[]` The source account's multisignature owner or current delegate.
  // ///   2. ..2+M `[signer]` M signer accounts
  // Revoke,
  // /// Sets a new authority of a mint or account.
  // ///
  // /// Accounts expected by this instruction:
  // ///
  // ///   * Single authority
  // ///   0. `[writable]` The mint or account to change the authority of.
  // ///   1. `[signer]` The current authority of the mint or account.
  // ///
  // ///   * Multisignature authority
  // ///   0. `[writable]` The mint or account to change the authority of.
  // ///   1. `[]` The mint's or account's current multisignature authority.
  // ///   2. ..2+M `[signer]` M signer accounts
  // SetAuthority {
  //     /// The type of authority to update.
  //     authority_type: AuthorityType,
  //     /// The new authority
  //     #[cfg_attr(feature = "serde-traits", serde(with = "coption_fromstr"))]
  //     new_authority: COption<Pubkey>,
  // },
  // /// Mints new tokens to an account.  The native mint does not support
  // /// minting.
  // ///
  // /// Accounts expected by this instruction:
  // ///
  // ///   * Single authority
  // ///   0. `[writable]` The mint.
  // ///   1. `[writable]` The account to mint tokens to.
  // ///   2. `[signer]` The mint's minting authority.
  // ///
  // ///   * Multisignature authority
  // ///   0. `[writable]` The mint.
  // ///   1. `[writable]` The account to mint tokens to.
  // ///   2. `[]` The mint's multisignature mint-tokens authority.
  // ///   3. ..3+M `[signer]` M signer accounts.
  // MintTo {
  //     /// The amount of new tokens to mint.
  //     amount: u64,
  // },
  // /// Burns tokens by removing them from an account.  `Burn` does not support
  // /// accounts associated with the native mint, use `CloseAccount` instead.
  // ///
  // /// Accounts expected by this instruction:
  // ///
  // ///   * Single owner/delegate
  // ///   0. `[writable]` The account to burn from.
  // ///   1. `[writable]` The token mint.
  // ///   2. `[signer]` The account's owner/delegate.
  // ///
  // ///   * Multisignature owner/delegate
  // ///   0. `[writable]` The account to burn from.
  // ///   1. `[writable]` The token mint.
  // ///   2. `[]` The account's multisignature owner/delegate.
  // ///   3. ..3+M `[signer]` M signer accounts.
  // Burn {
  //     /// The amount of tokens to burn.
  //     amount: u64,
  // },
  // /// Close an account by transferring all its SOL to the destination account.
  // /// Non-native accounts may only be closed if its token amount is zero.
  // ///
  // /// Accounts with the `TransferFeeAmount` extension may only be closed if the withheld
  // /// amount is zero.
  // ///
  // /// Mints may be closed if they have the `MintCloseAuthority` extension and their token
  // /// supply is zero
  // ///
  // /// Note that if the account to close has a `ConfidentialTransferExtension`, the
  // /// `ConfidentialTransferInstruction::EmptyAccount` instruction must precede this
  // /// instruction.
  // ///
  // /// Accounts expected by this instruction:
  // ///
  // ///   * Single owner
  // ///   0. `[writable]` The account to close.
  // ///   1. `[writable]` The destination account.
  // ///   2. `[signer]` The account's owner.
  // ///
  // ///   * Multisignature owner
  // ///   0. `[writable]` The account to close.
  // ///   1. `[writable]` The destination account.
  // ///   2. `[]` The account's multisignature owner.
  // ///   3. ..3+M `[signer]` M signer accounts.
  // CloseAccount,
  // /// Freeze an Initialized account using the Mint's freeze_authority (if
  // /// set).
  // ///
  // /// Accounts expected by this instruction:
  // ///
  // ///   * Single owner
  // ///   0. `[writable]` The account to freeze.
  // ///   1. `[]` The token mint.
  // ///   2. `[signer]` The mint freeze authority.
  // ///
  // ///   * Multisignature owner
  // ///   0. `[writable]` The account to freeze.
  // ///   1. `[]` The token mint.
  // ///   2. `[]` The mint's multisignature freeze authority.
  // ///   3. ..3+M `[signer]` M signer accounts.
  // FreezeAccount,
  // /// Thaw a Frozen account using the Mint's freeze_authority (if set).
  // ///
  // /// Accounts expected by this instruction:
  // ///
  // ///   * Single owner
  // ///   0. `[writable]` The account to freeze.
  // ///   1. `[]` The token mint.
  // ///   2. `[signer]` The mint freeze authority.
  // ///
  // ///   * Multisignature owner
  // ///   0. `[writable]` The account to freeze.
  // ///   1. `[]` The token mint.
  // ///   2. `[]` The mint's multisignature freeze authority.
  // ///   3. ..3+M `[signer]` M signer accounts.
  // ThawAccount,

  // /// Transfers tokens from one account to another either directly or via a
  // /// delegate.  If this account is associated with the native mint then equal
  // /// amounts of SOL and Tokens will be transferred to the destination
  // /// account.
  // ///
  // /// This instruction differs from Transfer in that the token mint and
  // /// decimals value is checked by the caller.  This may be useful when
  // /// creating transactions offline or within a hardware wallet.
  // ///
  // /// If either account contains an `TransferFeeAmount` extension, the fee is
  // /// withheld in the destination account.
  // ///
  // /// Accounts expected by this instruction:
  // ///
  // ///   * Single owner/delegate
  // ///   0. `[writable]` The source account.
  // ///   1. `[]` The token mint.
  // ///   2. `[writable]` The destination account.
  // ///   3. `[signer]` The source account's owner/delegate.
  // ///
  // ///   * Multisignature owner/delegate
  // ///   0. `[writable]` The source account.
  // ///   1. `[]` The token mint.
  // ///   2. `[writable]` The destination account.
  // ///   3. `[]` The source account's multisignature owner/delegate.
  // ///   4. ..4+M `[signer]` M signer accounts.
  // TransferChecked {
  //     /// The amount of tokens to transfer.
  //     amount: u64,
  //     /// Expected number of base 10 digits to the right of the decimal place.
  //     decimals: u8,
  // },
  // /// Approves a delegate.  A delegate is given the authority over tokens on
  // /// behalf of the source account's owner.
  // ///
  // /// This instruction differs from Approve in that the token mint and
  // /// decimals value is checked by the caller.  This may be useful when
  // /// creating transactions offline or within a hardware wallet.
  // ///
  // /// Accounts expected by this instruction:
  // ///
  // ///   * Single owner
  // ///   0. `[writable]` The source account.
  // ///   1. `[]` The token mint.
  // ///   2. `[]` The delegate.
  // ///   3. `[signer]` The source account owner.
  // ///
  // ///   * Multisignature owner
  // ///   0. `[writable]` The source account.
  // ///   1. `[]` The token mint.
  // ///   2. `[]` The delegate.
  // ///   3. `[]` The source account's multisignature owner.
  // ///   4. ..4+M `[signer]` M signer accounts
  // ApproveChecked {
  //     /// The amount of tokens the delegate is approved for.
  //     amount: u64,
  //     /// Expected number of base 10 digits to the right of the decimal place.
  //     decimals: u8,
  // },
  // /// Mints new tokens to an account.  The native mint does not support
  // /// minting.
  // ///
  // /// This instruction differs from MintTo in that the decimals value is
  // /// checked by the caller.  This may be useful when creating transactions
  // /// offline or within a hardware wallet.
  // ///
  // /// Accounts expected by this instruction:
  // ///
  // ///   * Single authority
  // ///   0. `[writable]` The mint.
  // ///   1. `[writable]` The account to mint tokens to.
  // ///   2. `[signer]` The mint's minting authority.
  // ///
  // ///   * Multisignature authority
  // ///   0. `[writable]` The mint.
  // ///   1. `[writable]` The account to mint tokens to.
  // ///   2. `[]` The mint's multisignature mint-tokens authority.
  // ///   3. ..3+M `[signer]` M signer accounts.
  // MintToChecked {
  //     /// The amount of new tokens to mint.
  //     amount: u64,
  //     /// Expected number of base 10 digits to the right of the decimal place.
  //     decimals: u8,
  // },
  // /// Burns tokens by removing them from an account.  `BurnChecked` does not
  // /// support accounts associated with the native mint, use `CloseAccount`
  // /// instead.
  // ///
  // /// This instruction differs from Burn in that the decimals value is checked
  // /// by the caller. This may be useful when creating transactions offline or
  // /// within a hardware wallet.
  // ///
  // /// Accounts expected by this instruction:
  // ///
  // ///   * Single owner/delegate
  // ///   0. `[writable]` The account to burn from.
  // ///   1. `[writable]` The token mint.
  // ///   2. `[signer]` The account's owner/delegate.
  // ///
  // ///   * Multisignature owner/delegate
  // ///   0. `[writable]` The account to burn from.
  // ///   1. `[writable]` The token mint.
  // ///   2. `[]` The account's multisignature owner/delegate.
  // ///   3. ..3+M `[signer]` M signer accounts.
  // BurnChecked {
  //     /// The amount of tokens to burn.
  //     amount: u64,
  //     /// Expected number of base 10 digits to the right of the decimal place.
  //     decimals: u8,
  // },
  // /// Like InitializeAccount, but the owner pubkey is passed via instruction data
  // /// rather than the accounts list. This variant may be preferable when using
  // /// Cross Program Invocation from an instruction that does not need the owner's
  // /// `AccountInfo` otherwise.
  // ///
  // /// Accounts expected by this instruction:
  // ///
  // ///   0. `[writable]`  The account to initialize.
  // ///   1. `[]` The mint this account will be associated with.
  // ///   2. `[]` Rent sysvar
  // InitializeAccount2 {
  //     /// The new account's owner/multisignature.
  //     owner: Pubkey,
  // },
  // /// Given a wrapped / native token account (a token account containing SOL)
  // /// updates its amount field based on the account's underlying `lamports`.
  // /// This is useful if a non-wrapped SOL account uses `system_instruction::transfer`
  // /// to move lamports to a wrapped token account, and needs to have its token
  // /// `amount` field updated.
  // ///
  // /// Accounts expected by this instruction:
  // ///
  // ///   0. `[writable]`  The native token account to sync with its underlying lamports.
  // SyncNative,
  // /// Like InitializeAccount2, but does not require the Rent sysvar to be provided
  // ///
  // /// Accounts expected by this instruction:
  // ///
  // ///   0. `[writable]`  The account to initialize.
  // ///   1. `[]` The mint this account will be associated with.
  // InitializeAccount3 {
  //     /// The new account's owner/multisignature.
  //     owner: Pubkey,
  // },
  // /// Like InitializeMultisig, but does not require the Rent sysvar to be provided
  // ///
  // /// Accounts expected by this instruction:
  // ///
  // ///   0. `[writable]` The multisignature account to initialize.
  // ///   1. ..1+N. `[]` The signer accounts, must equal to N where 1 <= N <=
  // ///      11.
  // InitializeMultisig2 {
  //     /// The number of signers (M) required to validate this multisignature
  //     /// account.
  //     m: u8,
  // },
  // /// Like InitializeMint, but does not require the Rent sysvar to be provided
  // ///
  // /// Accounts expected by this instruction:
  // ///
  // ///   0. `[writable]` The mint to initialize.
  // ///
  // InitializeMint2 {
  //     /// Number of base 10 digits to the right of the decimal place.
  //     decimals: u8,
  //     /// The authority/multisignature to mint tokens.
  //     #[cfg_attr(feature = "serde-traits", serde(with = "As::<DisplayFromStr>"))]
  //     mint_authority: Pubkey,
  //     /// The freeze authority/multisignature of the mint.
  //     #[cfg_attr(feature = "serde-traits", serde(with = "coption_fromstr"))]
  //     freeze_authority: COption<Pubkey>,
  // },
  // /// Gets the required size of an account for the given mint as a little-endian
  // /// `u64`.
  // ///
  // /// Return data can be fetched using `sol_get_return_data` and deserializing
  // /// the return data as a little-endian `u64`.
  // ///
  // /// Accounts expected by this instruction:
  // ///
  // ///   0. `[]` The mint to calculate for
  // GetAccountDataSize {
  //     /// Additional extension types to include in the returned account size
  //     extension_types: Vec<ExtensionType>,
  // },
  // /// Initialize the Immutable Owner extension for the given token account
  // ///
  // /// Fails if the account has already been initialized, so must be called before
  // /// `InitializeAccount`.
  // ///
  // /// Accounts expected by this instruction:
  // ///
  // ///   0. `[writable]`  The account to initialize.
  // ///
  // /// Data expected by this instruction:
  // ///   None
  // ///
  // InitializeImmutableOwner,
  // /// Convert an Amount of tokens to a UiAmount `string`, using the given mint.
  // ///
  // /// Fails on an invalid mint.
  // ///
  // /// Return data can be fetched using `sol_get_return_data` and deserialized with
  // /// `String::from_utf8`.
  // ///
  // /// Accounts expected by this instruction:
  // ///
  // ///   0. `[]` The mint to calculate for
  // AmountToUiAmount {
  //     /// The amount of tokens to convert.
  //     amount: u64,
  // },
  // /// Convert a UiAmount of tokens to a little-endian `u64` raw Amount, using the given mint.
  // ///
  // /// Return data can be fetched using `sol_get_return_data` and deserializing
  // /// the return data as a little-endian `u64`.
  // ///
  // /// Accounts expected by this instruction:
  // ///
  // ///   0. `[]` The mint to calculate for
  // UiAmountToAmount {
  //     /// The ui_amount of tokens to convert.
  //     ui_amount: &'a str,
  // },
  // /// Initialize the close account authority on a new mint.
  // ///
  // /// Fails if the mint has already been initialized, so must be called before
  // /// `InitializeMint`.
  // ///
  // /// The mint must have exactly enough space allocated for the base mint (82
  // /// bytes), plus 83 bytes of padding, 1 byte reserved for the account type,
  // /// then space required for this extension, plus any others.
  // ///
  // /// Accounts expected by this instruction:
  // ///
  // ///   0. `[writable]` The mint to initialize.
  // InitializeMintCloseAuthority {
  //     /// Authority that must sign the `CloseAccount` instruction on a mint
  //     #[cfg_attr(feature = "serde-traits", serde(with = "coption_fromstr"))]
  //     close_authority: COption<Pubkey>,
  // },
  // /// The common instruction prefix for Transfer Fee extension instructions.
  // ///
  // /// See `extension::transfer_fee::instruction::TransferFeeInstruction` for
  // /// further details about the extended instructions that share this instruction prefix
  // TransferFeeExtension(TransferFeeInstruction),
  // /// The common instruction prefix for Confidential Transfer extension instructions.
  // ///
  // /// See `extension::confidential_transfer::instruction::ConfidentialTransferInstruction` for
  // /// further details about the extended instructions that share this instruction prefix
  // ConfidentialTransferExtension,
  // /// The common instruction prefix for Default Account State extension instructions.
  // ///
  // /// See `extension::default_account_state::instruction::DefaultAccountStateInstruction` for
  // /// further details about the extended instructions that share this instruction prefix
  // DefaultAccountStateExtension,
  // /// Check to see if a token account is large enough for a list of ExtensionTypes, and if not,
  // /// use reallocation to increase the data size.
  // ///
  // /// Accounts expected by this instruction:
  // ///
  // ///   * Single owner
  // ///   0. `[writable]` The account to reallocate.
  // ///   1. `[signer, writable]` The payer account to fund reallocation
  // ///   2. `[]` System program for reallocation funding
  // ///   3. `[signer]` The account's owner.
  // ///
  // ///   * Multisignature owner
  // ///   0. `[writable]` The account to reallocate.
  // ///   1. `[signer, writable]` The payer account to fund reallocation
  // ///   2. `[]` System program for reallocation funding
  // ///   3. `[]` The account's multisignature owner/delegate.
  // ///   4. ..4+M `[signer]` M signer accounts.
  // ///
  // Reallocate {
  //     /// New extension types to include in the reallocated account
  //     extension_types: Vec<ExtensionType>,
  // },
  // /// The common instruction prefix for Memo Transfer account extension instructions.
  // ///
  // /// See `extension::memo_transfer::instruction::RequiredMemoTransfersInstruction` for
  // /// further details about the extended instructions that share this instruction prefix
  // MemoTransferExtension,
  // /// Creates the native mint.
  // ///
  // /// This instruction only needs to be invoked once after deployment and is permissionless,
  // /// Wrapped SOL (`native_mint::id()`) will not be available until this instruction is
  // /// successfully executed.
  // ///
  // /// Accounts expected by this instruction:
  // ///
  // ///   0. `[writeable,signer]` Funding account (must be a system account)
  // ///   1. `[writable]` The native mint address
  // ///   2. `[]` System program for mint account funding
  // ///
  // CreateNativeMint,
  // /// Initialize the non transferable extension for the given mint account
  // ///
  // /// Fails if the account has already been initialized, so must be called before
  // /// `InitializeMint`.
  // ///
  // /// Accounts expected by this instruction:
  // ///
  // ///   0. `[writable]`  The mint account to initialize.
  // ///
  // /// Data expected by this instruction:
  // ///   None
  // ///
  // InitializeNonTransferableMint,
  // /// The common instruction prefix for Interest Bearing extension instructions.
  // ///
  // /// See `extension::interest_bearing_mint::instruction::InterestBearingMintInstruction` for
  // /// further details about the extended instructions that share this instruction prefix
  // InterestBearingMintExtension,
  // /// The common instruction prefix for CPI Guard account extension instructions.
  // ///
  // /// See `extension::cpi_guard::instruction::CpiGuardInstruction` for
  // /// further details about the extended instructions that share this instruction prefix
  // CpiGuardExtension,
  // /// Initialize the permanent delegate on a new mint.
  // ///
  // /// Fails if the mint has already been initialized, so must be called before
  // /// `InitializeMint`.
  // ///
  // /// The mint must have exactly enough space allocated for the base mint (82
  // /// bytes), plus 83 bytes of padding, 1 byte reserved for the account type,
  // /// then space required for this extension, plus any others.
  // ///
  // /// Accounts expected by this instruction:
  // ///
  // ///   0. `[writable]` The mint to initialize.
  // ///
  // /// Data expected by this instruction:
  // ///   Pubkey for the permanent delegate
  // ///
  // InitializePermanentDelegate {
  //     /// Authority that may sign for `Transfer`s and `Burn`s on any account
  //     delegate: Pubkey,
  // },
}
