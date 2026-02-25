import 'dart:convert';

import 'package:flutter/material.dart' hide Action;
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit/reown_walletkit.dart';

import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/evm_service.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_radius.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_modals/wcp_information_capture/wcp_collect_data_browser.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_modals/wcp_why_we_need_info.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_shared_widgets.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_utils.dart';

class WCPPaymentDetailsWidget extends StatefulWidget {
  const WCPPaymentDetailsWidget({
    super.key,
    required this.paymentOptionsResponse,
    required this.paymentRequest,
    this.infoButtonNotifier,
    this.showInfoPageNotifier,
  });

  final PaymentOptionsResponse paymentOptionsResponse;
  final ConfirmPaymentRequest paymentRequest;
  final ValueNotifier<bool>? infoButtonNotifier;
  final ValueNotifier<bool>? showInfoPageNotifier;

  @override
  State<WCPPaymentDetailsWidget> createState() =>
      _WCPPaymentDetailsWidgetState();
}

class _WCPPaymentDetailsWidgetState extends State<WCPPaymentDetailsWidget> {
  final _walletKitService = GetIt.I<IWalletKitService>();
  late final PaymentOptionsResponse paymentOptionsResponse;
  late ConfirmPaymentRequest confirmRequest;
  final Set<String> _collectDataCompletedIds = {};
  bool _isProcessing = false;
  bool _isForward = true;

  @override
  void initState() {
    super.initState();
    paymentOptionsResponse = widget.paymentOptionsResponse;
    confirmRequest = widget.paymentRequest;
    widget.showInfoPageNotifier?.addListener(_onInfoPageToggled);
  }

  @override
  void dispose() {
    widget.showInfoPageNotifier?.removeListener(_onInfoPageToggled);
    super.dispose();
  }

  void _onInfoPageToggled() {
    setState(() {
      _isForward = widget.showInfoPageNotifier!.value;
    });
  }

  PaymentOption get _selectedOption {
    return paymentOptionsResponse.options.firstWhere(
      (e) => e.id == confirmRequest.optionId,
    );
  }

  bool _needsCollectData(PaymentOption option) {
    final url = option.collectData?.url;
    return url != null &&
        url.isNotEmpty &&
        !_collectDataCompletedIds.contains(option.id);
  }

  String _sign(Action action) {
    final method = action.walletRpc.method;
    final chainId = action.walletRpc.chainId;
    final params = action.walletRpc.params;
    final service = _walletKitService.getChainService<EVMService>(
      chainId: chainId,
    );
    switch (method) {
      case 'eth_signTypedData_v4':
        final decodedParams = jsonDecode(params) as List<dynamic>;
        final typedData = decodedParams.last;
        return service.ethSignTypedDataV4(typedData);
      case 'personal_sign':
        throw UnimplementedError('personal_sign not yet implemented');
      default:
        throw UnimplementedError('Unsupported signing method: $method');
    }
  }

  Future<void> _signAndPay() async {
    try {
      final actions = List<Action>.from(_selectedOption.actions);
      if (actions.isEmpty) {
        final requiredActions =
            await _walletKitService.getRequiredPaymentActions(
          _selectedOption.id,
          confirmRequest.paymentId,
        );
        actions.addAll(requiredActions);
      }
      final signatures = actions.map((action) => _sign(action)).toList();
      confirmRequest = confirmRequest.copyWith(signatures: signatures);
      Navigator.of(context).pop(confirmRequest);
    } catch (e) {
      Navigator.of(context).pop(e);
    }
  }

  Future<void> _handleConfirmOrNext() async {
    if (_isProcessing) return;
    if (_needsCollectData(_selectedOption)) {
      setState(() => _isProcessing = true);
      try {
        final result = await WCPCollectDataBrowser.show(
          _selectedOption.collectData!.url!,
        );
        if (result == WCBottomSheetResult.next.name) {
          setState(() {
            _collectDataCompletedIds.add(_selectedOption.id);
          });
          widget.infoButtonNotifier?.value = false;
        } else if (result is PaymentStatus) {
          // Payment expired or failed during data collection — let the
          // orchestrator show the result modal.
          if (mounted) Navigator.of(context).pop(result);
        }
      } finally {
        if (mounted) setState(() => _isProcessing = false);
      }
    } else {
      await _signAndPay();
    }
  }

  Widget _buildDetailsView(BuildContext context) {
    final paymentInfo = paymentOptionsResponse.info!;
    final selectedNeedsCollectData = _needsCollectData(_selectedOption);
    final buttonText = selectedNeedsCollectData
        ? 'Continue'
        : 'Pay ${formatPayAmount(paymentInfo.amount)}';

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox.square(dimension: 20.0),
        WCPMerchantHeader(merchant: paymentInfo.merchant),
        const SizedBox(height: AppSpacing.s4),
        WCPPaymentDetails(paymentInfo: paymentInfo),
        const SizedBox(height: AppSpacing.s3),
        WCPPaymentOptionList(
          options: paymentOptionsResponse.options,
          selectedOption: _selectedOption,
          collectDataCompletedIds: _collectDataCompletedIds,
          onOptionSelected: (option) {
            setState(() {
              confirmRequest = confirmRequest.copyWith(optionId: option.id);
            });
          },
        ),
        const SizedBox(height: AppSpacing.s5),
        WCPrimaryButton(
          onPressed: _handleConfirmOrNext,
          enabled: !_isProcessing,
          text: buttonText,
        ),
      ],
    );
  }

  Widget _buildInfoView(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: AppSpacing.s7),
        const WCPWhyWeNeedInfoBody(),
        const SizedBox(height: AppSpacing.s7),
        WCPrimaryButton(
          onPressed: () => widget.showInfoPageNotifier!.value = false,
          text: 'Got it!',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final paymentInfo = paymentOptionsResponse.info;
    if (paymentInfo == null) {
      return const SizedBox.shrink();
    }

    final showInfoPageNotifier = widget.showInfoPageNotifier;
    if (showInfoPageNotifier != null) {
      return ClipRect(
        child: ValueListenableBuilder<bool>(
          valueListenable: showInfoPageNotifier,
          builder: (context, showInfo, _) {
            return AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeInOut,
                layoutBuilder: (currentChild, previousChildren) {
                  return Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      ...previousChildren.map((child) => Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            child: child,
                          )),
                      if (currentChild != null) currentChild,
                    ],
                  );
                },
                transitionBuilder: (child, animation) {
                  final isInfoView = child.key == const ValueKey('info');
                  final beginOffset = Offset(
                    isInfoView
                        ? (_isForward ? 0.3 : -0.3)
                        : (_isForward ? -0.3 : 0.3),
                    0.0,
                  );
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: beginOffset,
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: showInfo
                    ? KeyedSubtree(
                        key: const ValueKey('info'),
                        child: _buildInfoView(context),
                      )
                    : KeyedSubtree(
                        key: const ValueKey('details'),
                        child: _buildDetailsView(context),
                      ),
              ),
            );
          },
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
      ),
      padding: EdgeInsets.zero,
      child: _buildDetailsView(context),
    );
  }
}

class DefaultLogo extends StatelessWidget {
  final String text;
  const DefaultLogo({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: context.colors.onBackgroundInvert,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class WCPPaymentOptionList extends StatelessWidget {
  const WCPPaymentOptionList({
    super.key,
    required this.selectedOption,
    required this.options,
    required this.collectDataCompletedIds,
    required this.onOptionSelected,
  });

  final PaymentOption selectedOption;
  final List<PaymentOption> options;
  final Set<String> collectDataCompletedIds;
  final ValueChanged<PaymentOption> onOptionSelected;

  bool _optionNeedsCollectData(PaymentOption option) {
    final url = option.collectData?.url;
    return url != null &&
        url.isNotEmpty &&
        !collectDataCompletedIds.contains(option.id);
  }

  @override
  Widget build(BuildContext context) {
    final selectedCompleted =
        collectDataCompletedIds.contains(selectedOption.id);
    final singleOptionReady =
        options.length == 1 && !_optionNeedsCollectData(options.first);

    if (selectedCompleted || singleOptionReady) {
      return _ConfirmedPaymentOption(option: selectedOption);
    }

    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.transparent,
          Colors.black,
          Colors.black,
          Colors.transparent,
        ],
        stops: [0.0, 0.06, 0.94, 1.0],
      ).createShader(bounds),
      blendMode: BlendMode.dstIn,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 280),
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            scrollbars: false,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.s4),
                ...options.map((option) {
                  final isSelected = option.id == selectedOption.id;
                  final hasCollectData = _optionNeedsCollectData(option);
                  return _PaymentOptionItem(
                    option: option,
                    isSelected: isSelected,
                    hasCollectData: hasCollectData,
                    onTap: () {
                      if (!isSelected) {
                        onOptionSelected(option);
                      }
                    },
                  );
                }),
                const SizedBox(height: AppSpacing.s4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PaymentOptionItem extends StatelessWidget {
  const _PaymentOptionItem({
    required this.option,
    required this.isSelected,
    required this.hasCollectData,
    required this.onTap,
  });

  static const _selectionDuration = Duration(milliseconds: 220);
  static const _selectionCurve = Curves.easeOutCubic;

  final PaymentOption option;
  final bool isSelected;
  final bool hasCollectData;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final display = option.amount.display;
    final colors = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: _selectionDuration,
        curve: _selectionCurve,
        decoration: BoxDecoration(
          color: colors.foregroundPrimary,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? colors.accent : Colors.transparent,
            width: 1,
          ),
        ),
        margin: const EdgeInsets.only(bottom: 6.0),
        height: 68.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: IgnorePointer(
                  child: AnimatedOpacity(
                    duration: _selectionDuration,
                    curve: _selectionCurve,
                    opacity: isSelected ? 1.0 : 0.0,
                    child: Container(color: colors.foregroundAccentPrimary010),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s5),
                child: Row(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: 16.0,
                          backgroundImage: NetworkImage(display.iconUrl ?? ''),
                        ),
                        if ((display.networkIconUrl ?? '').isNotEmpty)
                          Positioned(
                            bottom: -2,
                            right: -2,
                            child: Container(
                              padding: const EdgeInsets.all(1.5),
                              decoration: BoxDecoration(
                                color: colors.backgroundSecondary,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: CircleAvatar(
                                radius: 8.0,
                                backgroundImage:
                                    NetworkImage(display.networkIconUrl ?? ''),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: AppSpacing.s2),
                    Text(
                      formatPayAmount(option.amount),
                      style: TextStyle(
                        color: colors.textPrimary,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Spacer(),
                    if (hasCollectData)
                      AnimatedContainer(
                        duration: _selectionDuration,
                        curve: _selectionCurve,
                        height: 28.0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.s2,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? colors.accent.withValues(alpha: 0.9)
                              : colors.foregroundTertiary,
                          borderRadius: BorderRadius.circular(AppSpacing.s2),
                        ),
                        alignment: Alignment.center,
                        child: AnimatedDefaultTextStyle(
                          duration: _selectionDuration,
                          curve: _selectionCurve,
                          style: TextStyle(
                            color:
                                isSelected ? Colors.white : colors.textPrimary,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                          child: const Text('Info required'),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConfirmedPaymentOption extends StatelessWidget {
  const _ConfirmedPaymentOption({required this.option});

  final PaymentOption option;

  @override
  Widget build(BuildContext context) {
    final display = option.amount.display;
    final colors = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: colors.foregroundPrimary,
        borderRadius: BorderRadius.circular(16.0),
      ),
      height: 68.0,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s5),
      alignment: Alignment.center,
      child: Row(
        children: [
          Text(
            'Pay with',
            style: TextStyle(
              color: colors.textTertiary,
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              fontFamily: 'KH Teka',
            ),
          ),
          const Spacer(),
          Text(
            formatPayAmount(option.amount),
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              fontFamily: 'KH Teka',
            ),
          ),
          const SizedBox(width: AppSpacing.s2),
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 16.0,
                backgroundImage: NetworkImage(display.iconUrl ?? ''),
              ),
              if ((display.networkIconUrl ?? '').isNotEmpty)
                Positioned(
                  bottom: -2,
                  right: -2,
                  child: Container(
                    padding: const EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      color: colors.foregroundPrimary,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: CircleAvatar(
                      radius: 8.0,
                      backgroundImage:
                          NetworkImage(display.networkIconUrl ?? ''),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class PaymentDetailRow extends StatelessWidget {
  const PaymentDetailRow({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.iconColor,
    this.showChevron = false,
    this.onTap,
  });

  final String label;
  final String value;
  final IconData? icon;
  final Color? iconColor;
  final bool showChevron;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final row = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(color: colors.textSecondary, fontSize: 16.0)),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 6),
            ],
            Text(value,
                style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500)),
            if (showChevron) ...[
              const SizedBox(width: 6),
              Icon(Icons.chevron_right, color: colors.textTertiary, size: 20),
            ],
          ],
        ),
      ],
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: row,
        ),
      );
    }

    return row;
  }
}
