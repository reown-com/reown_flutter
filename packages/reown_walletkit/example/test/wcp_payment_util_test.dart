import 'package:flutter_test/flutter_test.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_native_price_service.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_payment_util.dart';

PaymentOption _option({
  required String id,
  required String unit,
  String symbol = 'USDC',
  String network = 'base',
  List<Action> actions = const [],
}) {
  return PaymentOption(
    id: id,
    account: 'eip155:8453:0x0',
    amount: PayAmount(
      unit: unit,
      value: '2720000000',
      display: AmountDisplay(
        assetSymbol: symbol,
        assetName: symbol,
        decimals: 6,
        networkName: network,
      ),
    ),
    etaSeconds: 0,
    actions: actions,
  );
}

const _approveTx = Action(
  walletRpc: WalletRpcAction(
    chainId: 'eip155:8453',
    method: 'eth_sendTransaction',
    params: '[]',
  ),
);

const _signTypedData = Action(
  walletRpc: WalletRpcAction(
    chainId: 'eip155:8453',
    method: 'eth_signTypedData_v4',
    params: '[]',
  ),
);

void main() {
  group('wcpRequiresApproval', () {
    test('true when any action is eth_sendTransaction', () {
      expect(wcpRequiresApproval([_approveTx, _signTypedData]), isTrue);
    });

    test('false for typed-data-only flow', () {
      expect(wcpRequiresApproval([_signTypedData]), isFalse);
    });

    test('false for empty actions', () {
      expect(wcpRequiresApproval(const []), isFalse);
    });
  });

  group('findPreferredOption', () {
    final options = [
      _option(id: 'a', unit: 'eip155:8453/erc20:0xUSDC'),
      _option(id: 'b', unit: 'eip155:137/erc20:0xUSDT', symbol: 'USDT'),
    ];

    test('returns the matching option when unit is present', () {
      final preferred = findPreferredOption(options, 'eip155:137/erc20:0xUSDT');
      expect(preferred?.id, 'b');
    });

    test('returns null when unit is null', () {
      expect(findPreferredOption(options, null), isNull);
    });

    test('returns null when unit is empty', () {
      expect(findPreferredOption(options, ''), isNull);
    });

    test('returns null when unit is not in options', () {
      expect(findPreferredOption(options, 'eip155:1/erc20:0xDAI'), isNull);
    });
  });

  group('formatNativeGas', () {
    test('returns placeholder for null inputs', () {
      expect(formatNativeGas(null, 'ETH'), '…');
      expect(formatNativeGas(BigInt.one, null), '…');
    });

    test('zero wei renders as zero', () {
      expect(formatNativeGas(BigInt.zero, 'ETH'), '0 ETH');
    });

    test('sub-1e-4 ether renders as < 0.0001', () {
      // 1 gwei = 1e9 wei = 1e-9 ether
      expect(formatNativeGas(BigInt.from(1000000000), 'ETH'), '< 0.0001 ETH');
    });

    test('0.001 ether keeps 6 decimals trimmed', () {
      // 0.001 ETH = 1e15 wei
      expect(formatNativeGas(BigInt.parse('1000000000000000'), 'ETH'),
          '0.001 ETH');
    });

    test('0.05 ether keeps 4 decimals trimmed', () {
      // 0.05 ETH = 5e16 wei
      expect(formatNativeGas(BigInt.parse('50000000000000000'), 'ETH'),
          '0.05 ETH');
    });
  });

  group('formatFiatGas', () {
    test('EUR puts the symbol after the value', () {
      expect(formatFiatGas(0.012, 'EUR'), '0.012€');
    });

    test('USD puts the symbol before the value', () {
      expect(formatFiatGas(1.5, 'USD'), r'$1.5');
    });

    test('zero or negative renders as currency zero', () {
      expect(formatFiatGas(0.0, 'EUR'), '€0.00');
    });

    test('unsupported code falls back to ISO suffix', () {
      expect(formatFiatGas(1.5, 'JPY'), '1.5 JPY');
    });

    test('values >= 1 use 2 decimal scale', () {
      expect(formatFiatGas(2.5, 'EUR'), '2.5€');
      expect(formatFiatGas(2.55, 'EUR'), '2.55€');
    });
  });

  group('formatInlineApprovalFee', () {
    test('null estimate returns null', () {
      expect(formatInlineApprovalFee(null), isNull);
    });

    test('prefers fiat display when available', () {
      final estimate = WCPFeeEstimate(
        feeWei: BigInt.parse('12000000000000000'),
        nativeSymbol: 'ETH',
        fiatValue: 0.012,
        fiatCurrency: 'EUR',
      );
      expect(formatInlineApprovalFee(estimate), '+0.012€');
    });

    test('falls back to native display when fiat is missing', () {
      final estimate = WCPFeeEstimate(
        feeWei: BigInt.parse('50000000000000000'),
        nativeSymbol: 'ETH',
      );
      expect(formatInlineApprovalFee(estimate), '+0.05 ETH');
    });
  });

  group('formatPayButtonLabel', () {
    const eur = PayAmount(
      unit: 'iso4217/EUR',
      value: '2500',
      display: AmountDisplay(
        assetSymbol: 'EUR',
        assetName: 'Euro',
        decimals: 0,
      ),
    );

    test('no approval fee → plain label', () {
      expect(
        formatPayButtonLabel(merchantAmount: eur, hasApprovalFee: false),
        startsWith('Pay '),
      );
      expect(
        formatPayButtonLabel(merchantAmount: eur, hasApprovalFee: false),
        isNot(contains('incl. gas fee')),
      );
    });

    test('with approval fee → label has gas suffix', () {
      expect(
        formatPayButtonLabel(merchantAmount: eur, hasApprovalFee: true),
        contains('(incl. gas fee)'),
      );
    });
  });

  group('WCPFeeEstimate.withFiat', () {
    test('returns same estimate when price is null', () {
      final base = WCPFeeEstimate(feeWei: BigInt.one, nativeSymbol: 'ETH');
      expect(base.withFiat(null).fiatValue, isNull);
    });

    test('applies price × ether to produce fiat', () {
      // 0.001 ETH × 3000 = 3.0 (using $3000/ETH).
      final base = WCPFeeEstimate(
        feeWei: BigInt.parse('1000000000000000'),
        nativeSymbol: 'ETH',
      );
      final priced =
          base.withFiat(NativeTokenPrice(price: 3000.0, currency: 'USD'));
      expect(priced.fiatValue, closeTo(3.0, 1e-9));
      expect(priced.fiatCurrency, 'USD');
    });

    test('skips fiat when ether is zero', () {
      final base = WCPFeeEstimate(feeWei: BigInt.zero, nativeSymbol: 'ETH');
      final priced =
          base.withFiat(NativeTokenPrice(price: 3000.0, currency: 'USD'));
      expect(priced.fiatValue, isNull);
    });
  });

  group('WCPNativePriceService.normalizeFiatCurrency', () {
    test('extracts code from iso4217 unit', () {
      expect(WCPNativePriceService.normalizeFiatCurrency('iso4217/EUR'), 'EUR');
      expect(WCPNativePriceService.normalizeFiatCurrency('iso4217/usd'), 'USD');
    });

    test('null falls back to USD', () {
      expect(WCPNativePriceService.normalizeFiatCurrency(null), 'USD');
    });

    test('unsupported currency falls back to USD', () {
      expect(WCPNativePriceService.normalizeFiatCurrency('iso4217/JPY'), 'USD');
    });
  });
}
