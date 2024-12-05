#include "include/reown_walletkit/reown_walletkit_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "reown_walletkit_plugin.h"

void ReownWalletkitPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  reown_walletkit::ReownWalletkitPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
