import '../models/card_details.dart';
import 'luhn_validator.dart';

class CardParser {
  static CardDetails parseCard(String rawText) {
    rawText = rawText
        .replaceAll('O', '0')
        .replaceAll('I', '1')
        .replaceAll('l', '1');

    String cardNumber = '';
    String expiryDate = '';
    String holderName = '';

    final lines = rawText.split('\n');

    final cardRegex = RegExp(r'(?:\d[ -]*?){13,19}');

    for (final line in lines) {
      final match = cardRegex.firstMatch(line);

      if (match != null) {
        String candidate = match.group(0)!;

        candidate = candidate.replaceAll(RegExp(r'[^0-9]'), '');

        if (LuhnValidator.isValidCard(candidate)) {
          cardNumber = candidate;
          break;
        }
      }
    }

    final expiryRegex = RegExp(r'(0[1-9]|1[0-2])[\/\-]?([0-9]{2})');

    final expiryMatch = expiryRegex.firstMatch(rawText);

    if (expiryMatch != null) {
      expiryDate =
      '${expiryMatch.group(1)}/${expiryMatch.group(2)}';
    }

    for (final line in lines) {
      final cleaned = line
          .trim()
          .replaceAll(RegExp(r'[^A-Za-z ]'), '');

      final upper = cleaned.toUpperCase();

      final ignoredWords = [
        'VISA',
        'VALID',
        'THRU',
        'MASTERCARD',
        'BANK',
        'CARD',
        'PLATINUM',
        'DEBIT',
        'CREDIT',
      ];

      bool shouldIgnore = ignoredWords.any(
            (word) => upper.contains(word),
      );

      if (!shouldIgnore &&
          cleaned.split(' ').length >= 2 &&
          cleaned.length > 5) {
        holderName = upper;
        break;
      }
    }

    return CardDetails(
      cardNumber: maskCard(cardNumber),
      expiryDate: expiryDate,
      holderName: holderName,
    );
  }

  static String maskCard(String number) {
    if (number.length < 4) return number;

    return 'XXXX XXXX XXXX ${number.substring(number.length - 4)}';
  }
}