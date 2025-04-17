import 'package:flutter/services.dart';

class LicensePlateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final cleanText = newValue.text.toUpperCase().replaceAll(
      RegExp(r'[^A-Z0-9]'),
      '',
    );
    final formattedText = _formatLicensePlate(cleanText);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String _formatLicensePlate(String input) {
    final buffer = StringBuffer();

    final length = input.length;

    if (length >= 1) {
      buffer.write(input.substring(0, length >= 2 ? 2 : length));
    }
    if (length > 2) {
      buffer.write('-${input.substring(2, length >= 4 ? 4 : length)}');
    }
    if (length > 4) {
      buffer.write('-${input.substring(4, length >= 6 ? 6 : length)}');
    }

    return buffer.toString();
  }
}
