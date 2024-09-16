class WalletRedirect {
  String? mobile;
  String? linkMode;
  String? desktop;
  String? web;

  WalletRedirect({
    this.mobile,
    this.linkMode,
    this.desktop,
    this.web,
  });

  bool get mobileOnly => desktop == null && web == null;
  bool get webOnly => desktop == null && mobile == null;
  bool get desktopOnly => mobile == null && web == null;

  Uri? get mobileUri => mobile != null ? Uri.parse(mobile!) : null;
  Uri? get webUri => web != null ? Uri.parse(web!) : null;
  Uri? get desktopUri => desktop != null ? Uri.parse(desktop!) : null;

  WalletRedirect copyWith({
    String? mobile,
    String? linkMode,
    String? desktop,
    String? web,
  }) {
    return WalletRedirect(
      mobile: mobile ?? this.mobile,
      linkMode: linkMode ?? this.linkMode,
      desktop: desktop ?? this.desktop,
      web: web ?? this.web,
    );
  }

  @override
  String toString() =>
      'mobile: $mobile (mobileOnly: $mobileOnly), desktop: $desktop (desktopOnly: $desktopOnly), web: $web (webOnly: $webOnly), linkMode: $linkMode';
}
