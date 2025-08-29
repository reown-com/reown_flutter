import 'package:example/providers/reown_pos_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DtcAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final bool showBackButton;
  const DtcAppBar({super.key, this.showBackButton = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posInstance = ref.read(reownPosProvider);
    return AppBar(
      backgroundColor: const Color(0xFF4CAF50),
      elevation: 0,
      // leading: showBackButton
      //     ? IconButton(
      //         icon: const Icon(Icons.arrow_back, color: Colors.white),
      //         onPressed: () => Navigator.pop(context),
      //       )
      //     : null,
      leading: const SizedBox.shrink(),
      title: Column(
        children: [
          Text(
            posInstance.reOwnSign!.metadata.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            posInstance.reOwnSign!.metadata.description,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
