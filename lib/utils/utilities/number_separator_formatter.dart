import 'package:flutter/services.dart';

class NumberSeparatorFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;
    text = text.replaceAll(RegExp(r'(\s)|(\D)'), '');
    int offset = newValue.selection.start;
    String subText = newValue.text.substring(0, offset).replaceAll(RegExp(r'(\s)|(\D)'), '');
    int realTrimOffset = subText.length;
    StringBuffer buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      int nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(' ');
      }
      if (nonZeroIndex % 4 == 0 && subText.length == nonZeroIndex && nonZeroIndex > 4) {
        int moveCursorToRigth = nonZeroIndex ~/ 4 - 1;
        realTrimOffset += moveCursorToRigth;
      }
      if (nonZeroIndex % 4 != 0 && subText.length == nonZeroIndex) {
        int moveCursorToRigth = nonZeroIndex ~/ 4;
        realTrimOffset += moveCursorToRigth;
      }
    }

    String string = buffer.toString();

    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: realTrimOffset)
    );
  }
}

class CardNumberSeparatorFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;
    text = text.replaceAll(RegExp(r'(\s)|(\D)'), '');
    //int offset = newValue.selection.start;
    //String subText = newValue.text.substring(0, offset).replaceAll(RegExp(r'(\s)|(\D)'), '');
    //int realTrimOffset = subText.length;
    StringBuffer buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if (text.length > 3 && i == 2) {
        buffer.write('-');
      }
      if (text.length > 7 && i == 6) {
        buffer.write('-');
      }
      if (text.length > 13 && i == 12) {
        buffer.write('-');
      }
    }

    String string = buffer.toString();

    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length)
    );
  }
}
