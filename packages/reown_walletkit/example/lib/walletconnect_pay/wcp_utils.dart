import 'package:reown_walletkit/reown_walletkit.dart';

extension DateTimeExtension on DateTime {
  String get formatted {
    return '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
  }
}

/// Return the common currency symbol for a unit like "iso4217/USD" or "USD".
/// Falls back to the 3-letter ISO code if unknown.
String formatPayAmount(PayAmount payAmount) {
  if (!payAmount.unit.startsWith('iso4217')) {
    return payAmount.formatAmount();
  }

  final unitOrCode = payAmount.unit;
  final code = unitOrCode.contains('/')
      ? unitOrCode.split('/').last.toUpperCase()
      : unitOrCode.toUpperCase();

  const Map<String, String> symbols = {
    'USD': r'$',
    'EUR': '€',
    'GBP': '£',
    'JPY': '¥',
    'CAD': r'$',
    'AUD': r'$',
    'CHF': 'CHF',
    'CNY': '¥',
    'SEK': 'kr',
    'NOK': 'kr',
    'DKK': 'kr',
    'INR': '₹',
    'BRL': r'R$',
    'MXN': r'$',
    'ZAR': 'R',
    'SGD': r'$',
    'HKD': r'$',
    'NZD': r'$',
    'KRW': '₩',
    'RUB': '₽',
    'TRY': '₺',
    'PLN': 'zł',
    'THB': '฿',
    'IDR': 'Rp',
    'VND': '₫',
    'MYR': 'RM',
    'PHP': '₱',
    'ILS': '₪',
    'AED': 'د.إ',
    'SAR': '﷼'
  };

  final symbolOrCode = symbols[code] ?? code;
  return '$symbolOrCode${payAmount.formatAmount(withSymbol: false).trim()}';
}
