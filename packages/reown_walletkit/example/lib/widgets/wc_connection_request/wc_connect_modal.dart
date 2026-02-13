import 'package:flutter/material.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/models/chain_data.dart';
import 'package:reown_walletkit_wallet/models/chain_metadata.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';
import 'package:reown_walletkit_wallet/widgets/custom_button.dart';
import 'package:reown_walletkit_wallet/widgets/shared/app_icon_widget.dart';
import 'package:reown_walletkit_wallet/widgets/wc_connection_request/network_section.dart';
import 'package:reown_walletkit_wallet/widgets/wc_connection_request/verify_section.dart';

/// Result returned when the user approves a connection.
class ConnectApprovalResult {
  final Map<String, Namespace> namespaces;
  ConnectApprovalResult({required this.namespaces});
}

/// Result returned when the user approves a session auth request.
class AuthApprovalResult {
  final Set<String> selectedChainIds;
  final WCBottomSheetResult action;
  AuthApprovalResult({required this.selectedChainIds, required this.action});
}

/// Redesigned connect modal for session proposals and session auth requests.
class WCConnectModal extends StatefulWidget {
  const WCConnectModal({
    super.key,
    this.proposalData,
    this.sessionAuthPayload,
    required this.requester,
    this.verifyContext,
  });

  final ProposalData? proposalData;
  final SessionAuthPayload? sessionAuthPayload;
  final ConnectionMetadata? requester;
  final VerifyContext? verifyContext;

  bool get isAuthMode => sessionAuthPayload != null;

  @override
  State<WCConnectModal> createState() => _WCConnectModalState();
}

class _WCConnectModalState extends State<WCConnectModal> {
  late Set<String> _selectedChainIds;
  late List<ChainMetadata> _chains;

  @override
  void initState() {
    super.initState();
    _chains = _resolveChains();
    _selectedChainIds = _chains.map((c) => c.chainId).toSet();
  }

  List<ChainMetadata> _resolveChains() {
    final chainIds = <String>{};

    if (widget.isAuthMode) {
      // Auth mode: chains come directly from the payload
      for (final chain in widget.sessionAuthPayload!.chains) {
        chainIds.add(chain);
      }
    } else {
      // Proposal mode: extract chains from generatedNamespaces accounts
      final namespaces = widget.proposalData?.generatedNamespaces;
      if (namespaces != null) {
        for (final ns in namespaces.values) {
          for (final account in ns.accounts) {
            final parts = account.split(':');
            if (parts.length >= 2) {
              chainIds.add('${parts[0]}:${parts[1]}');
            }
          }
        }
      }
    }

    return chainIds.map((id) {
      final found =
          ChainsDataList.allChains.where((c) => c.chainId == id).firstOrNull;
      if (found != null) return found;
      // Create a fallback for unknown chains
      final parts = id.split(':');
      return ChainMetadata(
        chainId: id,
        name: id,
        logo: '',
        currency: '',
        color: Colors.grey,
        type: ChainType.values.firstWhere(
          (t) => t.name == (parts.isNotEmpty ? parts[0] : ''),
          orElse: () => ChainType.eip155,
        ),
        rpc: [],
      );
    }).toList();
  }

  Map<String, Namespace> _buildFilteredNamespaces() {
    final generatedNamespaces = widget.proposalData!.generatedNamespaces!;
    final filtered = <String, Namespace>{};

    for (final entry in generatedNamespaces.entries) {
      final ns = entry.value;
      final filteredAccounts = ns.accounts.where((account) {
        final parts = account.split(':');
        if (parts.length >= 2) {
          return _selectedChainIds.contains('${parts[0]}:${parts[1]}');
        }
        return false;
      }).toList();

      if (filteredAccounts.isNotEmpty) {
        filtered[entry.key] = Namespace(
          accounts: filteredAccounts,
          methods: ns.methods,
          events: ns.events,
        );
      }
    }
    return filtered;
  }

  void _onToggleChain(String chainId) {
    setState(() {
      if (_selectedChainIds.contains(chainId)) {
        _selectedChainIds.remove(chainId);
      } else {
        _selectedChainIds.add(chainId);
      }
    });
  }

  void _onCancel() {
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop(WCBottomSheetResult.reject);
    }
  }

  void _onConnect() {
    if (_selectedChainIds.isEmpty) return;
    if (!Navigator.canPop(context)) return;

    if (widget.isAuthMode) {
      Navigator.of(context).pop(
        AuthApprovalResult(
          selectedChainIds: Set.from(_selectedChainIds),
          action: WCBottomSheetResult.all,
        ),
      );
    } else {
      Navigator.of(context).pop(
        ConnectApprovalResult(namespaces: _buildFilteredNamespaces()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.requester == null) {
      return const Text('ERROR');
    }

    final colors = context.colors;
    final metadata = widget.requester!.metadata;
    final hasSelection = _selectedChainIds.isNotEmpty;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: AppSpacing.s2),
        // App icon
        Center(child: AppIcon(metadata: metadata, size: 64.0)),
        const SizedBox(height: AppSpacing.s3),
        // Title
        Text(
          'Connect your wallet to ${metadata.name}',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.s5),
        // Verify section
        Flexible(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                VerifySection(verifyContext: widget.verifyContext),
                const SizedBox(height: AppSpacing.s2),
                // Network section
                NetworkSection(
                  chains: _chains,
                  selectedChainIds: _selectedChainIds,
                  onToggleChain: _onToggleChain,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.s5),
        // Action buttons
        Row(
          children: [
            CustomButton(
              onTap: _onCancel,
              style: CustomButtonStyle.outlined,
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: AppSpacing.s3),
            CustomButton(
              onTap: hasSelection ? _onConnect : null,
              type: CustomButtonType.normal,
              child: Text(
                widget.isAuthMode ? 'Sign' : 'Connect',
                style: TextStyle(
                  color: colors.onAccent,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
