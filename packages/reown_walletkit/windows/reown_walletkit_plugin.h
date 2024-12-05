#ifndef FLUTTER_PLUGIN_REOWN_WALLETKIT_PLUGIN_H_
#define FLUTTER_PLUGIN_REOWN_WALLETKIT_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace reown_walletkit {

class ReownWalletkitPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  ReownWalletkitPlugin();

  virtual ~ReownWalletkitPlugin();

  // Disallow copy and assign.
  ReownWalletkitPlugin(const ReownWalletkitPlugin&) = delete;
  ReownWalletkitPlugin& operator=(const ReownWalletkitPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace reown_walletkit

#endif  // FLUTTER_PLUGIN_REOWN_WALLETKIT_PLUGIN_H_
