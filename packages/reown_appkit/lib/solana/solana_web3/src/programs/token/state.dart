/// Authority Type
/// ------------------------------------------------------------------------------------------------
library;

enum AuthorityType {
  /// Authority to mint new tokens
  mintTokens,

  /// Authority to freeze any account associated with the Mint
  freezeAccount,

  /// Owner of a given token account
  accountOwner,

  /// Authority to close a token account
  closeAccount,
}
