import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
import 'package:reown_appkit/modal/utils/core_utils.dart';
import 'package:reown_appkit/modal/utils/render_utils.dart';
import 'package:reown_appkit/reown_appkit.dart';

class AccountAvatar extends StatefulWidget {
  const AccountAvatar({
    super.key,
    required this.appKit,
    this.size = 40.0,
    this.disabled = false,
  });

  final IReownAppKitModal appKit;
  final double size;
  final bool disabled;

  @override
  State<AccountAvatar> createState() => _AccountAvatarState();
}

class _AccountAvatarState extends State<AccountAvatar> {
  String? _avatarUrl;
  String? _address;

  @override
  void initState() {
    super.initState();
    widget.appKit.addListener(_modalNotifyListener);
    _modalNotifyListener();
  }

  @override
  void dispose() {
    widget.appKit.removeListener(_modalNotifyListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.size / 2),
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            widget.disabled ? themeColors.foreground300 : Colors.transparent,
            BlendMode.saturation,
          ),
          child: (_avatarUrl ?? '').isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: _avatarUrl!,
                  httpHeaders: CoreUtils.getAPIHeaders(
                    widget.appKit.appKit!.core.projectId,
                  ),
                  fadeInDuration: const Duration(milliseconds: 500),
                  fadeOutDuration: const Duration(milliseconds: 500),
                )
              : GradientOrb(address: _address, size: widget.size),
        ),
      ),
    );
  }

  void _modalNotifyListener() {
    setState(() {
      try {
        _avatarUrl = widget.appKit.avatarUrl;
        final chainId = widget.appKit.selectedChain?.chainId ?? '';
        final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
          chainId,
        );
        _address = widget.appKit.session?.getAddress(namespace);
      } catch (_) {}
    });
  }
}

class GradientOrb extends StatelessWidget {
  const GradientOrb({
    super.key,
    this.address,
    this.size = 40.0,
  });
  final String? address;
  final double size;

  @override
  Widget build(BuildContext context) {
    List<Color> colors = RenderUtils.generateAvatarColors(address);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: colors[4],
            borderRadius: BorderRadius.circular(size / 2.0),
            boxShadow: [
              BoxShadow(
                color: themeColors.grayGlass025,
                spreadRadius: 1.0,
                blurRadius: 0.0,
              ),
            ],
          ),
        ),
        ..._buildGradients(colors..removeAt(4)),
      ],
    );
  }

  List<Widget> _buildGradients(List<Color> colors) {
    double size = 1.5;
    final gradients = colors.reversed.map((c) {
      size -= 0.1;
      return _gradient(c, size);
    }).toList();
    gradients.add(
      _gradient(Colors.white.withOpacity(0.8), 0.5),
    );
    return gradients;
  }

  Widget _gradient(Color color, double size) => Positioned.fill(
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [color, color, color.withOpacity(0.0)],
              stops: [0.0, size / 4, size],
              center: const Alignment(0.3, -0.3),
            ),
          ),
        ),
      );
}
