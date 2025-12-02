/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
import 'package:reown_appkit/solana/solana_common/types.dart';
import 'package:reown_appkit/solana/solana_jsonrpc/jsonrpc.dart';
import 'package:reown_appkit/solana/solana_jsonrpc/models.dart';
import '../crypto/pubkey.dart';
import '../encodings/transaction_encoding.dart';
import '../messages/message.dart';
import '../transactions/nonce_account.dart';
import '../transactions/transaction.dart';
import '../types.dart';
import 'methods/index.dart';
import 'configs/index.dart';
import 'models/index.dart';

/// HTTP Connection
/// ------------------------------------------------------------------------------------------------

/// The HTTP JSON RPC method calls.
mixin HttpConnection {
  /// HTTP client (persistent connection).
  JsonRpcHttpClient get httpClient;

  /// HTTP client request configurations.
  JsonRpcClientConfig? get httpClientConfig => null;

  /// The default commitment level applied to all methods that query bank state.
  Commitment? get commitment;

  // /// The latest blockhash.
  // final BlockhashCache _blockhashCache = BlockhashCache();

  /// Makes a JSON RPC HTTP [method] call.
  ///
  /// ## Example
  /// ```
  /// final pubkey = Pubkey.fromBase58('CM78CPUeXjn8o3yroDHxUtKsZZgoy4GPkPPXfouKNH12');
  /// final method = GetAccountInfo(pubkey);
  /// final result = await connection.send(method);
  /// print(result); // JsonRpcSuccessResponse<...>
  /// ```
  Future<JsonRpcSuccessResponse<T>> send<S, T>(
    final JsonRpcMethod<S, T> method,
  ) => httpClient.send(
    method.request(commitment),
    method.response,
    config: httpClientConfig,
  );

  /// Makes a bulk JSON RPC HTTP method call.
  ///
  /// ## Example
  /// ```
  /// final builder = JsonRpcMethodBuilder();
  /// builder.add(GetBalance(Pubkey.fromBase58('CM78CPUeXjn8o3yroDHxUtKsZZgoy4GPkPPXfouKNH12')));
  /// builder.add(GetEpochInfo());
  /// final result = await connection.sendAll(builder);
  /// print(result); // [JsonRpcSuccessResponse<...>, JsonRpcSuccessResponse<EpochInfo>]
  /// ```
  Future<List<JsonRpcResponse<T>>> sendAll<S, T>(
    final JsonRpcMethodBuilder<S, T> builder, {
    final bool? eagerError,
  }) => httpClient.sendAll(
    builder.request(commitment),
    builder.response,
    config: httpClientConfig,
    eagerError: eagerError ?? false,
  );

  /// {@template solana_web3.Connection.getAccountInfo}
  /// Returns all information associated with the account of the provided [pubkey].
  /// {@endtemplate}
  Future<JsonRpcContextResponse<AccountInfo?>> getAccountInfoRaw(
    final Pubkey pubkey, {
    final GetAccountInfoConfig? config,
  }) => send(GetAccountInfo(pubkey, config: config));

  /// {@macro solana_web3.Connection.getAccountInfo}
  Future<AccountInfo?> getAccountInfo(
    final Pubkey pubkey, {
    final GetAccountInfoConfig? config,
  }) async => (await getAccountInfoRaw(pubkey, config: config)).result?.value;

  /// {@macro solana_web3.Connection.getAccountInfo} with [AccountEncoding.jsonParsed].
  Future<AccountInfo?> getParsedAccountInfo(
    final Pubkey pubkey, {
    final GetParsedAccountInfoConfig? config,
  }) => getAccountInfo(pubkey, config: config);

  /// {@template solana_web3.Connection.getBalance}
  /// Returns the balance of the account of provided [pubkey]
  /// {@endtemplate}
  Future<JsonRpcContextResponse<u64>> getBalanceRaw(
    final Pubkey pubkey, {
    final GetBalanceConfig? config,
  }) => send(GetBalance(pubkey, config: config));

  /// {@macro solana_web3.Connection.getBalance}
  Future<u64> getBalance(
    final Pubkey pubkey, {
    final GetBalanceConfig? config,
  }) async => (await getBalanceRaw(pubkey, config: config)).result!.value!;

  /// {@template solana_web3.Connection.getBlock}
  /// Returns identity and transaction information about a confirmed block at [slot] in the ledger.
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<Block?>> getBlockRaw(
    final u64 slot, {
    final GetBlockConfig? config,
  }) => send(GetBlock(slot, config: config));

  /// {@macro solana_web3.Connection.getBlock}
  Future<Block?> getBlock(
    final u64 slot, {
    final GetBlockConfig? config,
  }) async => (await getBlockRaw(slot, config: config)).result;

  /// {@template solana_web3.Connection.getBlockHeight}
  /// Returns the current block height of the node.
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<u64>> getBlockHeightRaw({
    final GetBlockHeightConfig? config,
  }) => send(GetBlockHeight(config: config));

  /// {@macro solana_web3.Connection.getBlockHeight}
  Future<u64> getBlockHeight({final GetBlockHeightConfig? config}) async =>
      (await getBlockHeightRaw(config: config)).result!;

  /// {@template solana_web3.Connection.getBlockProduction}
  /// Returns the recent block production information from the current or previous epoch.
  /// {@endtemplate}
  Future<JsonRpcContextResponse<BlockProduction>> getBlockProductionRaw({
    final GetBlockProductionConfig? config,
  }) => send(GetBlockProduction(config: config));

  /// {@macro solana_web3.Connection.getBlockProduction}
  Future<BlockProduction> getBlockProduction({
    final GetBlockProductionConfig? config,
  }) async => (await getBlockProductionRaw(config: config)).result!.value!;

  /// {@template solana_web3.Connection.getBlockCommitment}
  /// Returns the commitment for a particular block (slot).
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<BlockCommitment>> getBlockCommitmentRaw(
    final u64 slot,
  ) => send(GetBlockCommitment(slot));

  /// {@macro solana_web3.Connection.getBlockCommitment}
  Future<BlockCommitment> getBlockCommitment(final u64 slot) async =>
      (await getBlockCommitmentRaw(slot)).result!;

  /// {@template solana_web3.Connection.getBlocks}
  /// Returns a list of confirmed blocks between two slots.
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<List<u64>>> getBlocksRaw(
    final u64 startSlot, {
    final u64? endSlot,
    final GetBlocksConfig? config,
  }) => send(GetBlocks(startSlot, endSlot: endSlot, config: config));

  /// {@macro solana_web3.Connection.getBlocks}
  Future<List<u64>> getBlocks(
    final u64 startSlot, {
    final u64? endSlot,
    final GetBlocksConfig? config,
  }) async =>
      (await getBlocksRaw(startSlot, endSlot: endSlot, config: config)).result!;

  /// {@template solana_web3.Connection.getBlocksWithLimit}
  /// Returns a list of [limit] confirmed blocks starting at the given [slot].
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<List<u64>>> getBlocksWithLimitRaw(
    final u64 slot, {
    required final u64 limit,
    final GetBlocksWithLimitConfig? config,
  }) => send(GetBlocksWithLimit(slot, limit: limit, config: config));

  /// {@macro solana_web3.Connection.getBlocksWithLimit}
  Future<List<u64>> getBlocksWithLimit(
    final u64 slot, {
    required final u64 limit,
    final GetBlocksWithLimitConfig? config,
  }) async =>
      (await getBlocksWithLimitRaw(slot, limit: limit, config: config)).result!;

  /// {@template solana_web3.Connection.getBlockTime}
  /// Returns the estimated production time of a block.
  ///
  /// Each validator reports their UTC time to the ledger on a regular interval by intermittently
  /// adding a timestamp to a Vote for a particular block. A requested block's time is calculated
  /// from the stake-weighted mean of the Vote timestamps in a set of recent blocks recorded on the
  /// ledger.
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<i64?>> getBlockTimeRaw(final u64 slot) =>
      send(GetBlockTime(slot));

  /// {@macro solana_web3.Connection.getBlockTime}
  Future<i64?> getBlockTime(final u64 slot) async =>
      (await getBlockTimeRaw(slot)).result;

  /// {@template solana_web3.Connection.getClusterNodes}
  /// Returns information about all the nodes participating in the cluster.
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<List<ClusterNode>>> getClusterNodesRaw() =>
      send(GetClusterNodes());

  /// {@macro solana_web3.Connection.getClusterNodes}
  Future<List<ClusterNode>> getClusterNodes() async =>
      (await getClusterNodesRaw()).result!;

  /// {@template solana_web3.Connection.getEpochInfo}
  /// Returns information about the current epoch.
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<EpochInfo>> getEpochInfoRaw({
    final GetEpochInfoConfig? config,
  }) => send(GetEpochInfo(config: config));

  /// {@macro solana_web3.Connection.getEpochInfo}
  Future<EpochInfo> getEpochInfo({final GetEpochInfoConfig? config}) async =>
      (await getEpochInfoRaw(config: config)).result!;

  /// {@template solana_web3.Connection.getEpochSchedule}
  /// Returns the epoch schedule information from the cluster's genesis config.
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<EpochSchedule>> getEpochScheduleRaw() =>
      send(GetEpochSchedule());

  /// {@macro solana_web3.Connection.getEpochSchedule}
  Future<EpochSchedule> getEpochSchedule() async =>
      (await getEpochScheduleRaw()).result!;

  /// {@template solana_web3.Connection.getFeeForMessage}
  /// Returns the network fee that will be charged to send [message].
  /// {@endtemplate}
  Future<JsonRpcContextResponse<u64?>> getFeeForMessageRaw(
    final Message message, {
    final GetFeeForMessageConfig? config,
  }) {
    final String encoded = message.serialize().getString(BufferEncoding.base64);
    return getFeeForEncodedMessageRaw(encoded, config: config);
  }

  /// {@macro solana_web3.Connection.getFeeForMessage}
  Future<u64> getFeeForMessage(
    final Message message, {
    final GetFeeForMessageConfig? config,
  }) {
    final String encoded = message.serialize().getString(BufferEncoding.base64);
    return getFeeForEncodedMessage(encoded, config: config);
  }

  /// {@macro solana_web3.Connection.getFeeForMessage}
  Future<JsonRpcContextResponse<u64?>> getFeeForEncodedMessageRaw(
    final String message, {
    final GetFeeForMessageConfig? config,
  }) => send(GetFeeForMessage(message, config: config));

  /// {@macro solana_web3.Connection.getFeeForMessage}
  Future<u64> getFeeForEncodedMessage(
    final String message, {
    final GetFeeForMessageConfig? config,
  }) async {
    final u64? fee = (await getFeeForEncodedMessageRaw(
      message,
      config: config,
    )).result?.value;
    return fee != null
        ? Future.value(fee)
        : Future.error(const JsonRpcException('Invalid fee.'));
  }

  /// {@template solana_web3.Connection.getFirstAvailableBlock}
  /// Returns the slot of the lowest confirmed block that has not been purged from the ledger.
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<u64>> getFirstAvailableBlockRaw() =>
      send(GetFirstAvailableBlock());

  /// {@macro solana_web3.Connection.getFirstAvailableBlock}
  Future<u64> getFirstAvailableBlock() async =>
      (await getFirstAvailableBlockRaw()).result!;

  /// {@template solana_web3.Connection.getGenesisHash}
  /// Returns the genesis hash.
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<String>> getGenesisHashRaw() =>
      send(GetGenesisHash());

  /// {@macro solana_web3.Connection.getGenesisHash}
  Future<String> getGenesisHash() async => (await getGenesisHashRaw()).result!;

  /// {@template solana_web3.Connection.getHealth}
  /// Returns the current health of the node.
  ///
  /// If one or more --known-validator arguments are provided to solana-validator, "ok" is returned
  /// when the node has within HEALTH_CHECK_SLOT_DISTANCE slots of the highest known validator,
  /// otherwise an error is returned. "ok" is always returned if no known validators are provided.
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<HealthStatus>> getHealthRaw() =>
      send(GetHealth());

  /// {@macro solana_web3.Connection.getHealth}
  Future<HealthStatus> getHealth() async => (await getHealthRaw()).result!;

  /// {@template solana_web3.Connection.getHighestSnapshotSlot}
  /// Returns the highest slot information that the node has snapshots for.
  ///
  /// This will find the highest full snapshot slot, and the highest incremental snapshot slot based
  /// on the full snapshot slot, if there is one.
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<HighestSnapshotSlot>>
  getHighestSnapshotSlotRaw() => send(GetHighestSnapshotSlot());

  /// {@macro solana_web3.Connection.getHighestSnapshotSlot}
  Future<HighestSnapshotSlot> getHighestSnapshotSlot() async =>
      (await getHighestSnapshotSlotRaw()).result!;

  /// {@template solana_web3.Connection.getIdentity}
  /// Returns the identity pubkey for the current node.
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<Identity>> getIdentityRaw() =>
      send(GetIdentity());

  /// {@macro solana_web3.Connection.getIdentity}
  Future<Identity> getIdentity() async => (await getIdentityRaw()).result!;

  /// {@template solana_web3.Connection.getInflationGovernor}
  /// Returns the current inflation governor.
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<InflationGovernor>> getInflationGovernorRaw({
    final GetInflationGovernorConfig? config,
  }) => send(GetInflationGovernor(config: config));

  /// {@macro solana_web3.Connection.getInflationGovernor}
  Future<InflationGovernor> getInflationGovernor({
    final GetInflationGovernorConfig? config,
  }) async => (await getInflationGovernorRaw(config: config)).result!;

  /// {@template solana_web3.Connection.getInflationRate}
  /// Returns the specific inflation values for the current epoch.
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<InflationRate>> getInflationRateRaw() =>
      send(GetInflationRate());

  /// {@macro solana_web3.Connection.getInflationRate}
  Future<InflationRate> getInflationRate() async =>
      (await getInflationRateRaw()).result!;

  /// {@template solana_web3.Connection.getInflationReward}
  /// Returns the inflation / staking reward for a list of [addresses] for an epoch.
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<List<InflationReward?>>> getInflationRewardRaw(
    final Iterable<Pubkey> addresses, {
    final GetInflationRewardConfig? config,
  }) => send(GetInflationReward.map(addresses, config: config));

  /// {@macro solana_web3.Connection.getInflationReward}
  Future<List<InflationReward?>> getInflationReward(
    final Iterable<Pubkey> addresses, {
    final GetInflationRewardConfig? config,
  }) async => (await getInflationRewardRaw(addresses, config: config)).result!;

  /// {@template solana_web3.Connection.getLargestAccounts}
  /// Returns the 20 largest accounts, by lamport balance (results may be cached up to two hours).
  /// {@endtemplate}
  Future<JsonRpcContextResponse<List<LargeAccount>>> getLargestAccountsRaw({
    final GetLargestAccountsConfig? config,
  }) => send(GetLargestAccounts(config: config));

  /// {@macro solana_web3.Connection.getLargestAccounts}
  Future<List<LargeAccount>> getLargestAccounts({
    final GetLargestAccountsConfig? config,
  }) async => (await getLargestAccountsRaw(config: config)).result!.value!;

  /// {@template solana_web3.Connection.getLatestBlockhash}
  /// Returns the latest blockhash.
  /// {@endtemplate}
  Future<JsonRpcContextResponse<BlockhashWithExpiryBlockHeight>>
  getLatestBlockhashRaw({final GetLatestBlockhashConfig? config}) =>
      send(GetLatestBlockhash(config: config));

  /// {@macro solana_web3.Connection.getLatestBlockhash}
  Future<BlockhashWithExpiryBlockHeight> getLatestBlockhash({
    final GetLatestBlockhashConfig? config,
  }) async => (await getLatestBlockhashRaw(config: config)).result!.value!;

  /// {@template solana_web3.Connection.getLeaderSchedule}
  /// Returns the leader schedule for an epoch.
  ///
  /// The leader schedule with be fetched for the epoch that corresponds to the provided [slot]. If
  /// omitted, the leader schedule for the current epoch is fetched.
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<LeaderSchedule?>> getLeaderScheduleRaw({
    final u64? slot,
    final GetLeaderScheduleConfig? config,
  }) => send(GetLeaderSchedule(slot: slot, config: config));

  /// {@macro solana_web3.Connection.getLeaderSchedule}
  Future<LeaderSchedule> getLeaderSchedule({
    final u64? slot,
    final GetLeaderScheduleConfig? config,
  }) async => (await getLeaderScheduleRaw(slot: slot, config: config)).result!;

  /// {@template solana_web3.Connection.getMaxRetransmitSlot}
  /// Returns the max slot seen from retransmit stage.
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<u64>> getMaxRetransmitSlotRaw() =>
      send(GetMaxRetransmitSlot());

  /// {@macro solana_web3.Connection.getMaxRetransmitSlot}
  Future<u64> getMaxRetransmitSlot() async =>
      (await getMaxRetransmitSlotRaw()).result!;

  /// {@template solana_web3.Connection.getMaxShredInsertSlot}
  /// Returns the max slot seen from retransmit stage.
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<u64>> getMaxShredInsertSlotRaw() =>
      send(GetMaxShredInsertSlot());

  /// {@macro solana_web3.Connection.getMaxShredInsertSlot}
  Future<u64> getMaxShredInsertSlot() async =>
      (await getMaxShredInsertSlotRaw()).result!;

  /// {@template solana_web3.Connection.getMinimumBalanceForRentExemption}
  /// Returns the minimum balance required to make an account of size [length] rent exempt.
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<u64>> getMinimumBalanceForRentExemptionRaw(
    final usize length, {
    final GetMinimumBalanceForRentExemptionConfig? config,
  }) => send(GetMinimumBalanceForRentExemption(length, config: config));

  /// {@macro solana_web3.Connection.getMinimumBalanceForRentExemption}
  Future<u64> getMinimumBalanceForRentExemption(
    final usize length, {
    final GetMinimumBalanceForRentExemptionConfig? config,
  }) async => (await getMinimumBalanceForRentExemptionRaw(
    length,
    config: config,
  )).result!;

  /// {@template solana_web3.Connection.getMultipleAccounts}
  /// Returns the account information for a list of Pubkeys.
  /// {@endtemplate}
  Future<JsonRpcContextResponse<List<AccountInfo?>>> getMultipleAccountsRaw(
    final List<Pubkey> pubkeys, {
    final GetMultipleAccountsConfig? config,
  }) => send(GetMultipleAccounts.map(pubkeys, config: config));

  /// {@macro solana_web3.Connection.getMultipleAccounts}
  Future<List<AccountInfo?>> getMultipleAccounts(
    final List<Pubkey> pubkeys, {
    final GetMultipleAccountsConfig? config,
  }) async =>
      (await getMultipleAccountsRaw(pubkeys, config: config)).result!.value!;

  /// {@template solana_web3.Connection.getNonceAccount}
  /// Returns the account information for a nonce account.
  /// {@endtemplate}
  Future<JsonRpcContextResponse<NonceAccount?>> getNonceAccountRaw(
    final Pubkey nonceAccount, {
    final GetNonceAccountConfig? config,
  }) async {
    final response = await getAccountInfoRaw(nonceAccount, config: config);
    final JsonRpcResponseContext<AccountInfo?>? result = response.result;
    return JsonRpcContextResponse(
      jsonrpc: response.jsonrpc,
      result: result != null
          ? JsonRpcResponseContext(
              context: result.context,
              value: NonceAccount.tryFromAccountInfo(result.value),
            )
          : null,
      id: response.id,
    );
  }

  /// {@macro solana_web3.Connection.getNonceAccount}
  Future<NonceAccount?> getNonceAccount(
    final Pubkey nonceAccount, {
    final GetNonceAccountConfig? config,
  }) async =>
      (await getNonceAccountRaw(nonceAccount, config: config)).result?.value;

  /// {@template solana_web3.Connection.getProgramAccounts}
  /// Returns all accounts owned by the provided program Pubkey.
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<List<ProgramAccount>>> getProgramAccountsRaw(
    final Pubkey program, {
    final GetProgramAccountsConfig? config,
  }) => send(GetProgramAccounts(program, config: config));

  /// {@macro solana_web3.Connection.getProgramAccounts}
  Future<List<ProgramAccount>> getProgramAccounts(
    final Pubkey program, {
    final GetProgramAccountsConfig? config,
  }) async => (await getProgramAccountsRaw(program, config: config)).result!;

  /// {@template solana_web3.Connection.getRecentPerformanceSamples}
  /// Returns a list of recent performance samples, in reverse slot order. Performance samples are
  /// taken every 60 seconds and include the number of transactions and slots that occur in a given
  /// time window.
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<List<PerformanceSample>>>
  getRecentPerformanceSamplesRaw({final usize? limit}) =>
      send(GetRecentPerformanceSamples(limit: limit));

  /// {@macro solana_web3.Connection.getRecentPerformanceSamples}
  Future<List<PerformanceSample>> getRecentPerformanceSamples({
    final usize? limit,
  }) async => (await getRecentPerformanceSamplesRaw(limit: limit)).result!;

  /// {@template solana_web3.Connection.getRecentPrioritizationFees}
  /// Returns a list of prioritization fees from recent blocks.
  ///
  /// If [addresses] is provided, the response will reflect a fee to land a transaction locking all
  /// of the provided accounts as writable.
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<List<PrioritizationFee>>>
  getRecentPrioritizationFeesRaw([final List<Pubkey>? addresses]) =>
      send(GetRecentPrioritizationFees.map(addresses));

  /// {@macro solana_web3.Connection.getRecentPrioritizationFees}
  Future<List<PrioritizationFee>> getRecentPrioritizationFees([
    final List<Pubkey>? addresses,
  ]) async => (await getRecentPrioritizationFeesRaw(addresses)).result!;

  /// {@template solana_web3.Connection.getSignaturesForAddress}
  /// Returns signatures for confirmed transactions that include the given [address] in their
  /// accountKeys list. Returns signatures backwards in time from the provided signature or most
  /// recent confirmed block.
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<List<ConfirmedSignatureInfo>>>
  getSignaturesForAddressRaw(
    final Pubkey address, {
    final GetSignaturesForAddressConfig? config,
  }) => send(GetSignaturesForAddress(address, config: config));

  /// {@macro solana_web3.Connection.getSignaturesForAddress}
  Future<List<ConfirmedSignatureInfo>> getSignaturesForAddress(
    final Pubkey address, {
    final GetSignaturesForAddressConfig? config,
  }) async =>
      (await getSignaturesForAddressRaw(address, config: config)).result!;

  /// {@template solana_web3.Connection.getSignatureStatuses}
  /// Returns the statuses of [signatures].
  ///
  /// Unless the [GetSignatureStatusesConfig.searchTransactionHistory] configuration parameter is
  /// set to `true`, this method only searches the recent status cache of signatures, which retains
  /// statuses for all active slots plus MAX_RECENT_BLOCKHASHES rooted slots.
  /// {@endtemplate}
  Future<JsonRpcContextResponse<List<SignatureStatus?>>>
  getSignatureStatusesRaw(
    final List<String> signatures, {
    final GetSignatureStatusesConfig? config,
  }) => send(GetSignatureStatuses(signatures, config: config));

  /// {@macro solana_web3.Connection.getSignatureStatuses}
  Future<List<SignatureStatus?>> getSignatureStatuses(
    final List<String> signatures, {
    final GetSignatureStatusesConfig? config,
  }) async => (await getSignatureStatusesRaw(
    signatures,
    config: config,
  )).result!.value!;

  /// Returns the status of [signature].
  ///
  /// Unless the [GetSignatureStatusesConfig.searchTransactionHistory] configuration parameter is
  /// set to `true`, this method only searches the recent status cache of signatures, which retains
  /// statuses for all active slots plus MAX_RECENT_BLOCKHASHES rooted slots.
  Future<SignatureStatus?> getSignatureStatus(
    final String signature, {
    final GetSignatureStatusesConfig? config,
  }) async {
    final List<SignatureStatus?> statuses = await getSignatureStatuses([
      signature,
    ], config: config);
    return statuses.isNotEmpty ? statuses.first : null;
  }

  /// {@template solana_web3.Connection.getSlot}
  /// Returns the slot that has reached the given or default [GetSlotConfig.commitment] level.
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<u64>> getSlotRaw({
    final GetSlotConfig? config,
  }) => send(GetSlot(config: config));

  /// {@macro solana_web3.Connection.getSlot}
  Future<u64> getSlot({final GetSlotConfig? config}) async =>
      (await getSlotRaw(config: config)).result!;

  /// {@template solana_web3.Connection.getSlotLeader}
  /// Returns the current slot leader.
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<String>> getSlotLeaderRaw({
    final GetSlotLeaderConfig? config,
  }) => send(GetSlotLeader(config: config));

  /// {@macro solana_web3.Connection.getSlotLeader}
  Future<String> getSlotLeader({final GetSlotLeaderConfig? config}) async =>
      (await getSlotLeaderRaw(config: config)).result!;

  /// {@template solana_web3.Connection.getSlotLeaders}
  /// Returns the slot leaders for a given slot range.
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<List<String>>> getSlotLeadersRaw(
    final u64 start, {
    required final u64 limit,
  }) => send(GetSlotLeaders(start, limit: limit));

  /// {@macro solana_web3.Connection.getSlotLeaders}
  Future<List<String>> getSlotLeaders(
    final u64 start, {
    required final u64 limit,
  }) async => (await getSlotLeadersRaw(start, limit: limit)).result!;

  /// {@template solana_web3.Connection.getStakeActivation}
  /// Returns epoch activation information for a stake account.
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<StakeActivation>> getStakeActivationRaw(
    final Pubkey account, {
    final GetStakeActivationConfig? config,
  }) => send(GetStakeActivation(account, config: config));

  /// {@macro solana_web3.Connection.getStakeActivation}
  Future<StakeActivation> getStakeActivation(
    final Pubkey account, {
    final GetStakeActivationConfig? config,
  }) async => (await getStakeActivationRaw(account, config: config)).result!;

  /// {@template solana_web3.Connection.getStakeMinimumDelegation}
  /// Returns the stake minimum delegation in lamports.
  /// {@endtemplate}
  Future<JsonRpcContextResponse<u64>> getStakeMinimumDelegationRaw({
    final GetStakeMinimumDelegationConfig? config,
  }) => send(GetStakeMinimumDelegation(config: config));

  /// {@macro solana_web3.Connection.getStakeMinimumDelegation}
  Future<u64> getStakeMinimumDelegation({
    final GetStakeMinimumDelegationConfig? config,
  }) async =>
      (await getStakeMinimumDelegationRaw(config: config)).result!.value!;

  /// {@template solana_web3.Connection.getSupply}
  /// Returns information about the current supply.
  /// {@endtemplate}
  Future<JsonRpcContextResponse<Supply>> getSupplyRaw({
    final GetSupplyConfig? config,
  }) => send(GetSupply(config: config));

  /// {@macro solana_web3.Connection.getSupply}
  Future<Supply> getSupply({final GetSupplyConfig? config}) async =>
      (await getSupplyRaw(config: config)).result!.value!;

  /// {@template solana_web3.Connection.getTokenAccountBalance}
  /// Returns the token balance of an SPL Token [account].
  /// {@endtemplate}
  Future<JsonRpcContextResponse<TokenAmount>> getTokenAccountBalanceRaw(
    final Pubkey account, {
    final GetTokenAccountBalanceConfig? config,
  }) => send(GetTokenAccountBalance(account, config: config));

  /// {@macro solana_web3.Connection.getTokenAccountBalance}
  Future<TokenAmount> getTokenAccountBalance(
    final Pubkey account, {
    final GetTokenAccountBalanceConfig? config,
  }) async =>
      (await getTokenAccountBalanceRaw(account, config: config)).result!.value!;

  /// {@template solana_web3.Connection.getTokenAccountsByDelegate}
  /// Returns all SPL Token accounts approved by [delegate].
  /// {@endtemplate}
  Future<JsonRpcContextResponse<List<TokenAccount>>>
  getTokenAccountsByDelegateRaw(
    final Pubkey delegate, {
    required final TokenAccountsFilter filter,
    final GetTokenAccountsByDelegateConfig? config,
  }) => send(
    GetTokenAccountsByDelegate(delegate, filter: filter, config: config),
  );

  /// {@macro solana_web3.Connection.getTokenAccountsByDelegate}
  Future<List<TokenAccount>> getTokenAccountsByDelegate(
    final Pubkey delegate, {
    required final TokenAccountsFilter filter,
    final GetTokenAccountsByDelegateConfig? config,
  }) async => (await getTokenAccountsByDelegateRaw(
    delegate,
    filter: filter,
    config: config,
  )).result!.value!;

  /// {@template solana_web3.Connection.getTokenAccountsByOwner}
  /// Returns the token owner of an SPL Token [account].
  /// {@endtemplate}
  Future<JsonRpcContextResponse<List<TokenAccount>>> getTokenAccountsByOwnerRaw(
    final Pubkey account, {
    required final TokenAccountsFilter filter,
    final GetTokenAccountsByOwnerConfig? config,
  }) => send(GetTokenAccountsByOwner(account, filter: filter, config: config));

  /// {@macro solana_web3.Connection.getTokenAccountsByOwner}
  Future<List<TokenAccount>> getTokenAccountsByOwner(
    final Pubkey account, {
    required final TokenAccountsFilter filter,
    final GetTokenAccountsByOwnerConfig? config,
  }) async => (await getTokenAccountsByOwnerRaw(
    account,
    filter: filter,
    config: config,
  )).result!.value!;

  /// {@template solana_web3.Connection.getTokenLargestAccounts}
  /// Returns the 20 largest accounts of a particular SPL Token type.
  /// {@endtemplate}
  Future<JsonRpcContextResponse<List<TokenAmount>>> getTokenLargestAccountsRaw(
    final Pubkey mint, {
    final GetTokenLargestAccountsConfig? config,
  }) => send(GetTokenLargestAccounts(mint, config: config));

  /// {@macro solana_web3.Connection.getTokenLargestAccounts}
  Future<List<TokenAmount>> getTokenLargestAccounts(
    final Pubkey mint, {
    final GetTokenLargestAccountsConfig? config,
  }) async =>
      (await getTokenLargestAccountsRaw(mint, config: config)).result!.value!;

  /// {@template solana_web3.Connection.getTokenSupply}
  /// Returns the total supply of an SPL Token type.
  /// {@endtemplate}
  Future<JsonRpcContextResponse<TokenAmount>> getTokenSupplyRaw(
    final Pubkey mint, {
    final GetTokenSupplyConfig? config,
  }) => send(GetTokenSupply(mint, config: config));

  /// {@macro solana_web3.Connection.getTokenSupply}
  Future<TokenAmount> getTokenSupply(
    final Pubkey mint, {
    final GetTokenSupplyConfig? config,
  }) async => (await getTokenSupplyRaw(mint, config: config)).result!.value!;

  /// {@template solana_web3.Connection.getTransaction}
  /// Returns transaction details for a confirmed transaction signature (base-58).
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<TransactionInfo?>> getTransactionRaw(
    final String signature, {
    final GetTransactionConfig? config,
  }) => send(GetTransaction(signature, config: config));

  /// {@macro solana_web3.Connection.getTransaction}
  Future<TransactionInfo?> getTransaction(
    final String signature, {
    final GetTransactionConfig? config,
  }) async => (await getTransactionRaw(signature, config: config)).result;

  /// {@template solana_web3.Connection.getTransactionCount}
  /// Returns the current [Transaction] count from the ledger.
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<u64>> getTransactionCountRaw({
    final GetTransactionCountConfig? config,
  }) => send(GetTransactionCount(config: config));

  /// {@macro solana_web3.Connection.getTransactionCount}
  Future<u64> getTransactionCount({
    final GetTransactionCountConfig? config,
  }) async => (await getTransactionCountRaw(config: config)).result!;

  /// {@template solana_web3.Connection.getVersion}
  /// Returns the current solana versions running on the node.
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<Version>> getVersionRaw() => send(GetVersion());

  /// {@macro solana_web3.Connection.getVersion}
  Future<Version> getVersion() async => (await getVersionRaw()).result!;

  /// {@template solana_web3.Connection.getVoteAccounts}
  /// Returns the account info and associated stake for all the voting accounts in the current bank.
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<VoteAccountStatus>> getVoteAccountsRaw({
    final GetVoteAccountsConfig? config,
  }) => send(GetVoteAccounts(config: config));

  /// {@macro solana_web3.Connection.getVoteAccounts}
  Future<VoteAccountStatus> getVoteAccounts({
    final GetVoteAccountsConfig? config,
  }) async => (await getVoteAccountsRaw(config: config)).result!;

  /// {@template solana_web3.Connection.isBlockhashValid}
  /// Returns whether a [blockhash] (base-58) is still valid or not.
  /// {@endtemplate}
  Future<JsonRpcContextResponse<bool>> isBlockhashValidRaw(
    final String blockhash, {
    final IsBlockhashValidConfig? config,
  }) => send(IsBlockhashValid(blockhash, config: config));

  /// {@macro solana_web3.Connection.isBlockhashValid}
  Future<bool> isBlockhashValid(
    final String blockhash, {
    final IsBlockhashValidConfig? config,
  }) async =>
      (await isBlockhashValidRaw(blockhash, config: config)).result!.value!;

  /// {@template solana_web3.Connection.minimumLedgerSlot}
  /// Returns the lowest slot that the node has information about in its ledger. This value may
  /// increase over time if the node is configured to purge older ledger data.
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<u64>> minimumLedgerSlotRaw() =>
      send(MinimumLedgerSlot());

  /// {@macro solana_web3.Connection.minimumLedgerSlot}
  Future<u64> minimumLedgerSlot() async =>
      (await minimumLedgerSlotRaw()).result!;

  /// {@template solana_web3.Connection.requestAirdrop}
  /// Requests an airdrop of [lamports] to [pubkey].
  ///
  /// Returns the transaction signature as a base-58 encoded string.
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<String>> requestAirdropRaw(
    final Pubkey pubkey,
    final u64 lamports, {
    final RequestAirdropConfig? config,
  }) => send(RequestAirdrop(pubkey, lamports, config: config));

  /// {@macro solana_web3.Connection.requestAirdrop}
  Future<String> requestAirdrop(
    final Pubkey pubkey,
    final u64 lamports, {
    final RequestAirdropConfig? config,
  }) async =>
      (await requestAirdropRaw(pubkey, lamports, config: config)).result!;

  /// {@template solana_web3.Connection.sendTransaction}
  /// Send a [Transaction] to the cluster for processing.
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<TransactionSignature>> sendTransactionRaw(
    Transaction transaction, {
    final SendTransactionConfig? config,
  }) async {
    // if (nonceInfo != null) {
    //   transaction.sign(signers);
    // } else {
    //   bool disableCache = false;
    //   for (;;) {
    //     final latestBlockhash = await _blockhashCache.get(this, disabled: disableCache);
    //     transaction = transaction.copyWith(
    //       recentBlockhash: latestBlockhash.blockhash,
    //       lastValidBlockHeight: latestBlockhash.lastValidBlockHeight,
    //     );

    //     transaction.sign(signers);
    //     final Uint8List? payerSignature = transaction.signature;
    //     if (payerSignature == null) {
    //       throw const TransactionException('No signature.'); // should never happen
    //     }

    //     final String signature = base64.encode(payerSignature);
    //     if (!_blockhashCache.transactionSignatures.contains(signature)) {
    //       // The signature of this transaction has not been seen before with the current
    //       // [latestBlockhash.blockhash], all done. Let's break
    //       _blockhashCache.transactionSignatures.add(signature);
    //       break;
    //     } else {
    //       // This transaction would be treated as duplicate (its derived signature matched to one of
    //       // the already recorded signatures). So, we must fetch a new blockhash for a different
    //       // signature by disabling our cache not to wait for the cache expiration
    //       // [BlockhashCache.timeout].
    //       disableCache = true;
    //     }
    //   }
    // }

    final defaultConfig =
        config ?? SendTransactionConfig(preflightCommitment: commitment);
    final BufferEncoding bufferEncoding = BufferEncoding.fromJson(
      defaultConfig.encoding.name,
    );
    final String signedTransaction = transaction.serialize().getString(
      bufferEncoding,
    );
    return sendSignedTransactionRaw(signedTransaction, config: config);
  }

  /// {@macro solana_web3.Connection.sendTransaction}
  Future<TransactionSignature> sendTransaction(
    final Transaction transaction, {
    final SendTransactionConfig? config,
  }) async => (await sendTransactionRaw(transaction, config: config)).result!;

  /// {@template solana_web3.Connection.sendSignedTransaction}
  /// Sends a signed [Transaction] to the cluster for processing.
  /// {@endtemplate}
  Future<JsonRpcSuccessResponse<TransactionSignature>> sendSignedTransactionRaw(
    final String signedTransaction, {
    final SendTransactionConfig? config,
  }) async {
    final defaultConfig =
        config ?? SendTransactionConfig(preflightCommitment: commitment);
    return send(SendTransaction(signedTransaction, config: defaultConfig));
  }

  /// {@macro solana_web3.Connection.sendSignedTransaction}
  Future<TransactionSignature> sendSignedTransaction(
    final String signedTransaction, {
    final SendTransactionConfig? config,
  }) async => (await sendSignedTransactionRaw(
    signedTransaction,
    config: config,
  )).result!;

  /// {@template solana_web3.Connection.sendSignedTransactions}
  /// Sends the signed [Transaction]s to the cluster for processing (default `base-64` encoding).
  /// {@endtemplate}
  ///
  /// If [eagerError] is true the method will return a list of [JsonRpcSuccessResponse]s or a
  /// [Future.error] with the first error found in the response.
  Future<List<JsonRpcResponse<TransactionSignature?>>>
  sendSignedTransactionsRaw(
    final List<String> signedTransactions, {
    final SendTransactionConfig? config,
    final bool? eagerError,
  }) async {
    final defaultConfig =
        config ?? SendTransactionConfig(preflightCommitment: commitment);
    final methods = signedTransactions.map(
      (tx) => SendTransaction(tx, config: defaultConfig),
    );
    return sendAll(
      JsonRpcMethodBuilder(methods.toList(growable: false)),
      eagerError: eagerError,
    );
  }

  /// {@macro solana_web3.Connection.sendSignedTransactions}
  ///
  /// If [eagerError] is true the method will return a list of non-null [TransactionSignature]s or a
  /// [Future.error] with the first error found in the response.
  Future<List<TransactionSignature?>> sendSignedTransactions(
    final List<String> signedTransactions, {
    final SendTransactionConfig? config,
    final bool? eagerError,
  }) async {
    final List<JsonRpcResponse<String?>> responses =
        await sendSignedTransactionsRaw(
          signedTransactions,
          config: config,
          eagerError: eagerError,
        );
    return responses
        .map<TransactionSignature?>(
          (final JsonRpcResponse response) =>
              response is JsonRpcSuccessResponse ? response.result : null,
        )
        .toList(growable: false);
  }

  /// {@template solana_web3.Connection.simulateTransaction}
  /// Simulates sending a [Transaction].
  /// {@endtemplate}
  Future<JsonRpcContextResponse<TransactionStatus>> simulateTransactionRaw(
    Transaction transaction, {
    final bool includeAccounts = false,
    final Commitment? commitment,
  }) async {
    // if (nonceInfo != null && signers != null) {
    //   transaction.sign(signers);
    // } else {
    //   bool disableCache = false;
    //   for (;;) {
    //     final latestBlockhash = await _blockhashCache.get(this, disabled: disableCache);
    //     transaction = transaction.copyWith(
    //       recentBlockhash: latestBlockhash.blockhash,
    //       lastValidBlockHeight: latestBlockhash.lastValidBlockHeight,
    //     );

    //     if (signers == null) {
    //       break;
    //     }

    //     transaction.sign(signers);
    //     final Uint8List? payerSignature = transaction.signature;
    //     if (payerSignature == null) {
    //       throw const TransactionException('No signature.'); // should never happen
    //     }

    //     final String signature = base64.encode(payerSignature);
    //     if (!_blockhashCache.simulatedSignatures.contains(signature) &&
    //         !_blockhashCache.transactionSignatures.contains(signature)) {
    //       // The signature of this transaction has not been seen before with the current
    //       // [latestBlockhash.blockhash], all done. Let's break
    //       _blockhashCache.simulatedSignatures.add(signature);
    //       break;
    //     } else {
    //       // This transaction would be treated as duplicate (its derived signature matched to one of
    //       // the already recorded signatures). So, we must fetch a new blockhash for a different
    //       // signature by disabling our cache not to wait for the cache expiration
    //       // [BlockhashCache.timeout].
    //       disableCache = true;
    //     }
    //   }
    // }

    final SimulateTransactionConfig config = SimulateTransactionConfig(
      commitment: commitment,
      encoding: TransactionEncoding.base64,
      accounts: includeAccounts
          ? AccountsFilter(
              addresses: transaction.message.nonProgramIds().toList(
                growable: false,
              ),
            )
          : null,
    );

    final String signedTransaction = transaction.serialize().getString(
      BufferEncoding.base64,
    );
    return send(SimulateTransaction(signedTransaction, config: config));
  }

  /// {@macro solana_web3.Connection.simulateTransaction}
  Future<TransactionStatus> simulateTransaction(
    final Transaction transaction, {
    final bool includeAccounts = false,
    final Commitment? commitment,
  }) async => (await simulateTransactionRaw(
    transaction,
    includeAccounts: includeAccounts,
    commitment: commitment,
  )).result!.value!;
}
