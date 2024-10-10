enum AppKitSocialOption {
  X,
  Apple,
  Discord,
  Farcaster;
  // GitHub,
  // Facebook,
  // Google,
  // Twitch,
  // Telegram,

  factory AppKitSocialOption.fromString(String value) {
    return AppKitSocialOption.values.firstWhere(
      (e) => e.name.toLowerCase() == value.toLowerCase(),
    );
  }
}
