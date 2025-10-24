import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';

class ReceiveMoneySheet extends StatefulWidget {
  const ReceiveMoneySheet({super.key, required this.appKitModal});
  final IReownAppKitModal appKitModal;

  @override
  State<ReceiveMoneySheet> createState() => _ReceiveMoneySheetState();
}

class _ReceiveMoneySheetState extends State<ReceiveMoneySheet> {
  final Map<ExchangeAsset, String> _params = {
    ethereumUSDC: '0xD6d14.....',
    ethereumUSDT: '0xD6d14.....',
    solanaUSDC: '3ZFT4Cwvy17q....',
    arbitrumUSDT: '0xD6d14.....',
    solanaUSDT: '3ZFT4Cwvy17q....',
    arbitrumUSDC: '0xD6d14.....',
    optimismUSDT: '0xD6d14.....',
    polygonUSDC: '0xD6d14.....',
    solanaSOL: '3ZFT4Cwvy17q....',
  };

  ExchangeAsset? _lastPicked;

  @override
  Widget build(BuildContext context) {
    final items = [
      _ReceiveItem(
        icon: Icons.blur_on_rounded,
        title: 'Pix',
        onTap: () {},
      ),
      _ReceiveItem(
        icon: Icons.swap_vert_circle_outlined,
        title: 'Top up from Exchanges',
        onTap: () async {
          try {
            final randomEntry =
                _params.entries.where((e) => e.key != _lastPicked).elementAt(
                      Random().nextInt(_params.length),
                    );
            _lastPicked = randomEntry.key;
            // Navigator.of(context).pop();
            // final networks = ReownAppKitModalNetworks.getAllSupportedNetworks();
            // await widget.appKitModal.selectChain(networks.first);
            await widget.appKitModal.openModalView(ReownAppKitModalDepositScreen());
            await widget.appKitModal.selectChain(null);
          } catch (_) {}
        },
      ),
      _ReceiveItem(
        icon: Icons.currency_exchange_rounded,
        title: 'Stablecoin',
        onTap: () {},
      ),
      _ReceiveItem(
        icon: Icons.token_outlined,
        title: 'Crypto',
        onTap: () {},
      ),
      _ReceiveItem(
        icon: Icons.account_balance_outlined,
        title: 'USD bank transfer',
        onTap: () {},
      ),
      _ReceiveItem(
        icon: Icons.link_outlined,
        title: 'Payment link',
        onTap: () {},
      ),
    ];

    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return Container(
      decoration: BoxDecoration(
          color: themeColors.background125,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40.0),
          ),
          border: Border(
              top: BorderSide(
            color: themeColors.background150,
          ))),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ===== GRAB HANDLE =====
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(top: 6, bottom: 12),
                decoration: BoxDecoration(
                  color: themeColors.foreground300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Header
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox.square(dimension: 8.0),
                  Text(
                    'Receive money',
                    style: TextStyle(
                      color: themeColors.foreground100,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      color: themeColors.foreground100,
                      size: 28.0,
                    ),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
              const SizedBox(height: 8),
              // Items
              ...items.map((e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: e,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReceiveItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ReceiveItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            const SizedBox.square(dimension: 8.0),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: themeColors.grayGlass005,
              ),
              child: Icon(icon, color: themeColors.foreground100),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: themeColors.foreground100,
                  fontSize: 15,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: themeColors.foreground100,
            ),
            const SizedBox.square(dimension: 10.0),
          ],
        ),
      ),
    );
  }
}

// Use this somewhere in your home screen
// void showReceiveMoneySheet(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     builder: (_) => const ReceiveMoneySheet(),
//   );
// }
