import 'package:reown_appkit/modal/models/public/appkit_social_options.dart';

class FeaturesConfig {
  final bool? enableAnalytics;
  final bool enableEmail;
  final List<AppKitSocialOption> socials;
  final bool showMainWallets;

  FeaturesConfig({
    this.enableAnalytics,
    this.enableEmail = false,
    this.socials = const [],
    this.showMainWallets = true,
  });
}
