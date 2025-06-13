import 'dart:io';
import 'package:intl/intl.dart';

class Currency {
  // php symbol formatter
  static String php = NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'PHP').currencySymbol;
  //
  static RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  // 
  static String Function(Match) mathFunc = (Match match) => '${match[1]},';
  // comma every 3 digits formatter
  static NumberFormat fmt = NumberFormat('###,##0.00', 'en_US');
}
