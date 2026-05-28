import '../models/bank_details.dart';

class PassbookParser {
  static BankDetails parsePassbook(String rawText) {
    rawText = rawText
        .replaceAll('O', '0')
        .replaceAll('I', '1')
        .replaceAll('l', '1');

    String accountName = '';
    String accountNumber = '';
    String ifscCode = '';

    final lines = rawText.split('\n');

    final ifscRegex = RegExp(r'[A-Z]{4}0[A-Z0-9]{6}');

    final ifscMatch = ifscRegex.firstMatch(rawText);

    if (ifscMatch != null) {
      ifscCode = ifscMatch.group(0)!;
    }

    final accountRegex = RegExp(r'\d{9,18}');

    for (final line in lines) {
      final match = accountRegex.firstMatch(line);

      if (match != null) {
        accountNumber = match.group(0)!;
        break;
      }
    }

    for (final line in lines) {
      final cleaned = line.trim();

      if (cleaned.length > 4 &&
          RegExp(r'^[A-Z ]+$').hasMatch(cleaned) &&
          !cleaned.contains('BANK') &&
          !cleaned.contains('STATE')) {
        accountName = cleaned;
        break;
      }
    }

    return BankDetails(
      accountName: accountName,
      accountNumber: accountNumber,
      ifscCode: ifscCode,
    );
  }
}