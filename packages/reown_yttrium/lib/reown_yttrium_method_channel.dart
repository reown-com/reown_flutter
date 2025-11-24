import 'package:reown_yttrium/channels/erc6492_channel.dart';
import 'package:reown_yttrium/channels/wallet_pay_channel.dart';
import 'reown_yttrium_platform_interface.dart';

/// An implementation of [ReownYttriumPlatform] that uses method channels.
class MethodChannelReownYttrium extends ReownYttriumPlatform {
  @override
  MethodChannelErc6492 get erc6492Channel => MethodChannelErc6492();

  @override
  MethodChannelWalletPay get walletPayChannel => MethodChannelWalletPay();
}
