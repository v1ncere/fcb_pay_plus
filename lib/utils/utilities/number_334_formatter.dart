import 'package:flutter/services.dart';

class Group334Formatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    final buffer = StringBuffer();

    for (int i = 0; i < digits.length && i < 10; i++) {
      if (i == 3 || i == 6) buffer.write(' ');
      buffer.write(digits[i]);
    }

    final formatted = buffer.toString();

        // Calculate new cursor position:
    final newOffset = _calculateCursorOffset(
        oldValue: oldValue,
        newValue: newValue,
        formatted: formatted,
    );
    // place cursor at the end (simple & safe)
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: newOffset),
    );
  }

  int _calculateCursorOffset({
    required TextEditingValue oldValue,
    required TextEditingValue newValue,
    required String formatted,
  }) {
    final oldOffset = oldValue.selection.baseOffset;
    final newOffsetRaw = newValue.selection.baseOffset;

    // Keep offset within valid bounds:
    int offset = newOffsetRaw.clamp(0, formatted.length);

    // If editing near the added spacing, adjust:
    if (offset > 0 && offset < formatted.length && formatted[offset - 1] == ' ') {
      offset -= 1;
    }

    // If cursor was at end before, keep it at end:
    if (oldOffset >= oldValue.text.length) {
      offset = formatted.length;
    }

    return offset;
  }
}
