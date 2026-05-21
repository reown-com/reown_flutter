import 'dart:convert';

import 'package:flutter/material.dart' hide Action;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit/reown_walletkit.dart';

import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/evm_service.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_radius.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_modals/wcp_gas_fee_view.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_modals/wcp_information_capture/wcp_collect_data_webview.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_modals/wcp_why_we_need_info.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_native_price_service.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_payment_util.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_shared_widgets.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_utils.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/widgets/wcp_option_row.dart';

/// Per-option state aggregated as we preload fee estimates in parallel.
/// [seq] is a monotonic counter scoped to this option, so a stale fetch for
/// option A can never overwrite a fresher state on A (or on B).
class _OptionPrep {
  _OptionPrep();
  WCPFeeEstimate? estimate;
  bool isFeeLoading = false;
  bool isPreloaded = false;
  bool hasApproval = false;
  int seq = 0;
}

enum _Page { select, review, info, gasFee }

class WCPPaymentDetailsWidget extends StatefulWidget {
  const WCPPaymentDetailsWidget({
    super.key,
    required this.paymentOptionsResponse,
    required this.paymentRequest,
    this.preferredUnit,
    this.showInfoPageNotifier,
    this.showReviewNotifier,
    this.showGasFeeNotifier,
    this.committedNotifier,
  });

  final PaymentOptionsResponse paymentOptionsResponse;
  final ConfirmPaymentRequest paymentRequest;
  final String? preferredUnit;
  final ValueNotifier<bool>? showInfoPageNotifier;
  final ValueNotifier<bool>? showReviewNotifier;
  final ValueNotifier<bool>? showGasFeeNotifier;

  /// Flips to true the moment the user taps PAY (and we are about to call
  /// `getRequiredPaymentActions`). Watched by the leading widget so the back
  /// arrow can be hidden — the WCPay wallet contract has no go-back path
  /// after this point.
  final ValueNotifier<bool>? committedNotifier;

  @override
  State<WCPPaymentDetailsWidget> createState() =>
      _WCPPaymentDetailsWidgetState();
}

class _WCPPaymentDetailsWidgetState extends State<WCPPaymentDetailsWidget> {
  final _walletKitService = GetIt.I<IWalletKitService>();
  late final PaymentOptionsResponse paymentOptionsResponse;
  late ConfirmPaymentRequest confirmRequest;
  final Set<String> _collectDataCompletedIds = {};
  final Map<String, _OptionPrep> _prep = {};

  bool _isProcessing = false;
  bool _committed = false;
  bool _isForward = true;
  bool _showReview = false;
  bool _showGasFee = false;

  /// The option the gas-fee explainer was opened for. Tracked separately
  /// from [confirmRequest.optionId] so that tapping a per-row info button on
  /// the select screen doesn't implicitly select the option.
  PaymentOption? _gasFeeOption;

  @override
  void initState() {
    super.initState();
    paymentOptionsResponse = widget.paymentOptionsResponse;
    confirmRequest = widget.paymentRequest;
    widget.showInfoPageNotifier?.addListener(_onInfoPageToggled);
    widget.showReviewNotifier?.addListener(_onReviewToggled);
    widget.showGasFeeNotifier?.addListener(_onGasFeeToggled);

    final preferred = findPreferredOption(
      paymentOptionsResponse.options,
      widget.preferredUnit,
    );
    if (preferred != null) {
      confirmRequest = confirmRequest.copyWith(optionId: preferred.id);
      if (paymentOptionsResponse.options.length > 1 &&
          !_needsCollectData(preferred)) {
        // Jump directly to review locally, but DON'T flip the external
        // `showReviewNotifier` — the leading widget keys the back arrow off
        // that notifier, and when the modal opens on review via a remembered
        // token the user has nowhere to go back to. As soon as the user taps
        // the pencil or any row, `_selectOption` / `_editSelection` will
        // sync the notifier again so the back arrow returns.
        _showReview = true;
      }
    }

    // Preload every option in parallel so users can compare fees at a glance.
    for (final option in paymentOptionsResponse.options) {
      _preloadFor(option);
    }
  }

  @override
  void dispose() {
    widget.showInfoPageNotifier?.removeListener(_onInfoPageToggled);
    widget.showReviewNotifier?.removeListener(_onReviewToggled);
    widget.showGasFeeNotifier?.removeListener(_onGasFeeToggled);
    super.dispose();
  }

  void _onInfoPageToggled() {
    setState(() {
      _isForward = widget.showInfoPageNotifier!.value;
    });
  }

  void _onReviewToggled() {
    if (!widget.showReviewNotifier!.value && _showReview) {
      setState(() => _showReview = false);
    }
  }

  void _onGasFeeToggled() {
    final next = widget.showGasFeeNotifier!.value;
    if (next == _showGasFee) return;
    setState(() => _showGasFee = next);
  }

  bool get _hasMultipleOptions => paymentOptionsResponse.options.length > 1;

  /// Returns the option matching `confirmRequest.optionId`, or `null` when no
  /// option is selected yet (multi-option flows open without a default — the
  /// user must tap a row to pick).
  PaymentOption? get _selectedOption {
    for (final option in paymentOptionsResponse.options) {
      if (option.id == confirmRequest.optionId) return option;
    }
    return null;
  }

  _OptionPrep _prepFor(PaymentOption option) =>
      _prep.putIfAbsent(option.id, _OptionPrep.new);

  bool _needsCollectData(PaymentOption option) {
    final url = option.collectData?.url;
    return url != null &&
        url.isNotEmpty &&
        !_collectDataCompletedIds.contains(option.id);
  }

  /// Estimates the approval fee for [option] using the inline [Action] list
  /// from `getPaymentOptions`. Those inline actions are preview-only — the
  /// committal `getRequiredPaymentActions` RPC fires once on PAY tap and is
  /// the source of truth for execution. When inline actions are absent we
  /// leave [state] empty and the row renders without a fee.
  Future<void> _preloadFor(PaymentOption option) async {
    final state = _prepFor(option);
    if (state.isPreloaded) return;
    if (option.actions.isEmpty) return;

    final seq = ++state.seq;
    final requiresApproval = wcpRequiresApproval(option.actions);
    setState(() {
      state.isPreloaded = true;
      state.hasApproval = requiresApproval;
      state.isFeeLoading = requiresApproval;
    });

    if (!requiresApproval) return;

    final approveTx = option.actions.firstWhere(
      (a) => a.walletRpc.method == 'eth_sendTransaction',
    );

    try {
      final service = _walletKitService.getChainService<EVMService>(
        chainId: approveTx.walletRpc.chainId,
      );
      final paramsList = jsonDecode(approveTx.walletRpc.params) as List;
      if (paramsList.isEmpty || paramsList.first is! Map) {
        if (!mounted || seq != state.seq) return;
        setState(() => state.isFeeLoading = false);
        return;
      }
      final decoded = Map<String, dynamic>.from(paramsList.first as Map);
      final feeWei = await service.estimatePayApprovalFee(decoded);
      if (!mounted || seq != state.seq) return;
      if (feeWei == null) {
        setState(() => state.isFeeLoading = false);
        return;
      }

      final nativeEstimate = WCPFeeEstimate(
        feeWei: feeWei,
        nativeSymbol: service.chainSupported.currency,
      );
      // Show native immediately while the fiat price RPC is still in flight.
      setState(() => state.estimate = nativeEstimate);

      final price = await WCPNativePriceService.instance.fetchNativeTokenPrice(
        chainId: approveTx.walletRpc.chainId,
        currency: paymentOptionsResponse.info?.amount.unit,
      );
      if (!mounted || seq != state.seq) return;
      setState(() {
        state.estimate = nativeEstimate.withFiat(price);
        state.isFeeLoading = false;
      });
    } catch (e) {
      debugPrint('[SampleWallet] estimatePayApprovalFee error: $e');
      if (!mounted || seq != state.seq) return;
      setState(() => state.isFeeLoading = false);
    }
  }

  /// Committal step: fires `getRequiredPaymentActions` exactly once to fetch
  /// the action list for the selected option, then hands it off to the
  /// orchestrator which executes them in order and posts `confirmPayment`.
  /// There is no go-back path after this — [_committed] is set so the
  /// leading widget and row affordances disable themselves.
  Future<void> _signAndPay() async {
    final selected = _selectedOption;
    if (selected == null) return;
    setState(() => _committed = true);
    widget.committedNotifier?.value = true;

    List<Action> actions;
    try {
      actions = await _walletKitService.getRequiredPaymentActions(
        selected.id,
        confirmRequest.paymentId,
      );
    } catch (e) {
      // Surface a typed PaymentStatus so the orchestrator can route the user
      // to the contextual result screen (with merchant info) instead of
      // crashing into the generic catch-all in `processPayment`.
      debugPrint('[SampleWallet] getRequiredPaymentActions error: $e');
      if (!mounted) return;
      Navigator.of(context).pop(PaymentStatus.failed);
      return;
    }

    if (!mounted) return;
    Navigator.of(context).pop((confirmRequest, actions));
  }

  /// Primary action on the review screen. The select screen no longer has a
  /// CTA — tapping a row advances directly via [_selectOption].
  Future<void> _handleConfirmOrNext() async {
    if (_isProcessing) return;
    final selected = _selectedOption;
    if (selected == null) return;
    if (_needsCollectData(selected)) {
      // Single-option flow that opened straight to review can still need
      // data collection. Run the webview, then stay on review.
      await _runCollectData(selected);
      return;
    }
    setState(() => _isProcessing = true);
    await _signAndPay();
  }

  Future<void> _selectOption(PaymentOption option) async {
    if (_committed || _isProcessing) return;
    if (option.id != _selectedOption?.id) {
      setState(() {
        confirmRequest = confirmRequest.copyWith(optionId: option.id);
      });
      _preloadFor(option);
    }
    // Per Figma, the select screen no longer has a primary CTA — tapping a
    // row advances directly. If the option needs data collection, run the
    // webview first and only then move to review.
    if (_needsCollectData(option)) {
      await _runCollectData(option);
    } else {
      setState(() => _showReview = true);
      widget.showReviewNotifier?.value = true;
    }
  }

  Future<void> _runCollectData(PaymentOption option) async {
    setState(() => _isProcessing = true);
    try {
      final result = await WCPCollectDataWebView.show(
        option.collectData!.url!,
        schema: option.collectData?.schema,
      );
      if (result == WCBottomSheetResult.next.name) {
        setState(() {
          _collectDataCompletedIds.add(option.id);
          _showReview = true;
        });
        widget.showReviewNotifier?.value = true;
      } else if (result is PaymentStatus) {
        if (mounted) Navigator.of(context).pop(result);
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  void _openGasFee(PaymentOption option) {
    if (_committed) return;
    setState(() {
      _gasFeeOption = option;
      _showGasFee = true;
    });
    widget.showGasFeeNotifier?.value = true;
  }

  void _openInfoPage() {
    if (_committed) return;
    widget.showInfoPageNotifier?.value = true;
  }

  void _closeGasFee() {
    setState(() {
      _showGasFee = false;
      _gasFeeOption = null;
    });
    widget.showGasFeeNotifier?.value = false;
  }

  void _editSelection() {
    if (_committed) return;
    setState(() => _showReview = false);
    widget.showReviewNotifier?.value = false;
  }

  _Page get _currentPage {
    final infoVisible = widget.showInfoPageNotifier?.value ?? false;
    if (infoVisible) return _Page.info;
    if (_showGasFee) return _Page.gasFee;
    // Review must have a resolved selection; otherwise fall back to select.
    final hasSelection = _selectedOption != null;
    if (hasSelection && (_showReview || !_hasMultipleOptions)) {
      return _Page.review;
    }
    return _Page.select;
  }

  Widget _buildSelectView(BuildContext context) {
    final paymentInfo = paymentOptionsResponse.info!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.s4),
        Center(
          child: SvgPicture.asset(
            'assets/Subtract.svg',
            width: 58.0,
            height: 58.0,
          ),
        ),
        const SizedBox(height: AppSpacing.s4),
        Center(
          child: Text(
            'Select a token to pay with',
            style: TextStyle(
              color: context.colors.textPrimary,
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.6,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: AppSpacing.s5),
        _OptionList(
          options: paymentOptionsResponse.options,
          collectDataCompletedIds: _collectDataCompletedIds,
          preps: _prep,
          onOptionSelected: _selectOption,
          // Per-row (i) only appears on collectData rows now and opens the
          // "Why do we collect personal details?" explainer.
          onOptionInfoTap: (_) => _openInfoPage(),
        ),
        const SizedBox(height: AppSpacing.s5),
        _MerchantFooter(
          merchant: paymentInfo.merchant,
          amount: paymentInfo.amount,
        ),
        const SizedBox(height: AppSpacing.s3),
      ],
    );
  }

  Widget _buildReviewView(BuildContext context) {
    final paymentInfo = paymentOptionsResponse.info!;
    final selected = _selectedOption;
    if (selected == null) return _buildSelectView(context);
    final prep = _prepFor(selected);
    final hasApproval = prep.hasApproval;
    final feeReady = prep.estimate != null && !prep.isFeeLoading;
    final selectedNeedsCollectData = _needsCollectData(selected);

    final buttonText = selectedNeedsCollectData
        ? 'Continue'
        : formatPayButtonLabel(
            merchantAmount: paymentInfo.amount,
            hasApprovalFee: hasApproval,
          );

    final showWhyLink = !selectedNeedsCollectData && hasApproval;
    final payEnabled = !_isProcessing;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.s5),
        WCPMerchantHeader(merchant: paymentInfo.merchant),
        const SizedBox(height: AppSpacing.s4),
        WCPPaymentDetails(paymentInfo: paymentInfo),
        const SizedBox(height: AppSpacing.s4),
        WCPOptionRow(
          option: selected,
          isSelected: true,
          showSelectedTint: false,
          testId:
              'pay-review-token-${selected.amount.display.networkName?.toLowerCase() ?? 'unknown'}',
          // Pencil edit only makes sense when there's somewhere else to go.
          // With a single option there's nothing to switch to, so hide it.
          action: selectedNeedsCollectData
              ? WCPOptionRowAction.infoRequired
              : _hasMultipleOptions
                  ? WCPOptionRowAction.edit
                  : WCPOptionRowAction.none,
          onActionTap: selectedNeedsCollectData
              ? null
              : _hasMultipleOptions
                  ? _editSelection
                  : null,
          feeEstimate: hasApproval ? prep.estimate : null,
          isFeeLoading: hasApproval && !feeReady,
        ),
        const SizedBox(height: AppSpacing.s5),
        WCPrimaryButton(
          onPressed: _handleConfirmOrNext,
          enabled: payEnabled,
          text: buttonText,
          testId: selectedNeedsCollectData
              ? 'pay-button-continue'
              : 'pay-button-pay',
        ),
        if (showWhyLink) ...[
          const SizedBox(height: AppSpacing.s3),
          Center(
            child: Semantics(
              container: true,
              identifier: 'pay-why-gas-fee-link',
              label: 'pay-why-gas-fee-link',
              child: GestureDetector(
                onTap: () => _openGasFee(selected),
                behavior: HitTestBehavior.opaque,
                child: Text(
                  'Why does ${selected.amount.display.assetSymbol} require a gas fee?',
                  style: TextStyle(
                    color: context.colors.textSecondary,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
        ],
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

  Widget _buildGasFeeView(BuildContext context) {
    // Explainer targets the option whose row's info button was tapped, or
    // (when reached from the review screen's "Why does X require…" link)
    // the option currently being reviewed.
    final option = _gasFeeOption ?? _selectedOption;
    if (option == null) return const SizedBox.shrink();
    final prep = _prepFor(option);
    return WCPGasFeeView(
      option: option,
      estimate: prep.estimate,
      onDismiss: _closeGasFee,
    );
  }

  Widget _pageFor(_Page page) {
    switch (page) {
      case _Page.select:
        return KeyedSubtree(
          key: const ValueKey('select'),
          child: _buildSelectView(context),
        );
      case _Page.review:
        return KeyedSubtree(
          key: const ValueKey('review'),
          child: _buildReviewView(context),
        );
      case _Page.info:
        return KeyedSubtree(
          key: const ValueKey('info'),
          child: _buildInfoView(context),
        );
      case _Page.gasFee:
        return KeyedSubtree(
          key: const ValueKey('gasFee'),
          child: _buildGasFeeView(context),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final paymentInfo = paymentOptionsResponse.info;
    if (paymentInfo == null) return const SizedBox.shrink();

    final page = _currentPage;

    // Once PAY is committed the WCPay one-call contract forbids escape.
    // Hiding the back arrow isn't enough — `showModalBottomSheet` defaults
    // to `enableDrag: true`, so a swipe-down would still pop the route. The
    // PopScope blocks that path (and any future system back-gesture).
    return PopScope(
      canPop: !_committed,
      child: _buildAnimatedBody(page),
    );
  }

  Widget _buildAnimatedBody(_Page page) {
    return ClipRect(
      child: AnimatedSize(
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
            final isInfoOrGas = child.key == const ValueKey('info') ||
                child.key == const ValueKey('gasFee');
            final beginOffset = Offset(
              isInfoOrGas
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
          child: _pageFor(page),
        ),
      ),
    );
  }
}

class _OptionList extends StatelessWidget {
  const _OptionList({
    required this.options,
    required this.collectDataCompletedIds,
    required this.preps,
    required this.onOptionSelected,
    required this.onOptionInfoTap,
  });

  final List<PaymentOption> options;
  final Set<String> collectDataCompletedIds;
  final Map<String, _OptionPrep> preps;
  final ValueChanged<PaymentOption> onOptionSelected;
  final ValueChanged<PaymentOption> onOptionInfoTap;

  bool _optionNeedsCollectData(PaymentOption option) {
    final url = option.collectData?.url;
    return url != null &&
        url.isNotEmpty &&
        !collectDataCompletedIds.contains(option.id);
  }

  WCPOptionRowAction _actionFor(PaymentOption option) {
    // The per-row (i) is reserved for "Why do we collect personal details?" on
    // options that gate behind a webview. Gas-fee explainers live on the
    // review screen ("Why does X require a gas fee?" link), not per row.
    if (_optionNeedsCollectData(option)) {
      return WCPOptionRowAction.infoRequired;
    }
    return WCPOptionRowAction.none;
  }

  @override
  Widget build(BuildContext context) {
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
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.s2),
                ...options.asMap().entries.map((entry) {
                  final index = entry.key;
                  final option = entry.value;
                  final prep = preps.putIfAbsent(option.id, _OptionPrep.new);
                  // Select-screen rows are uniform — no in-place selection
                  // state since tapping advances directly. Test ids use a
                  // plain `pay-option-$index` (Maestro's documented
                  // convention) instead of carrying a `-selected` suffix
                  // that the new flow can't honor before the user taps.
                  return WCPOptionRow(
                    option: option,
                    isSelected: false,
                    showSelectedTint: false,
                    testId: 'pay-option-$index',
                    action: _actionFor(option),
                    onTap: () => onOptionSelected(option),
                    onActionTap: () => onOptionInfoTap(option),
                    feeEstimate: prep.hasApproval ? prep.estimate : null,
                    isFeeLoading: prep.hasApproval &&
                        (prep.estimate == null || prep.isFeeLoading),
                  );
                }),
                const SizedBox(height: AppSpacing.s2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MerchantFooter extends StatelessWidget {
  const _MerchantFooter({required this.merchant, required this.amount});
  final MerchantInfo merchant;
  final PayAmount amount;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final logo = merchant.iconUrl;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Pay ${formatPayAmount(amount)} to ${merchant.name}',
          style: TextStyle(
            color: colors.textSecondary,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        if (logo != null && logo.isNotEmpty) ...[
          const SizedBox(width: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.sm),
            child: Image.network(
              logo,
              width: 16,
              height: 16,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
            ),
          ),
        ],
      ],
    );
  }
}
