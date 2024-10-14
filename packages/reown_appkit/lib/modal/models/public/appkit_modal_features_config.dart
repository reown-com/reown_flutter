import 'package:reown_appkit/modal/models/public/appkit_social_options.dart';

/// Object to pass to [featuresConfig:] parameter of ReownAppKitModal to enable or disable these extra features
class FeaturesConfig {
  final bool email;
  final List<AppKitSocialOption> socials;
  final bool showMainWallets;

  FeaturesConfig({
    this.email = true,
    this.socials = const [],
    this.showMainWallets = true,
  });
}
