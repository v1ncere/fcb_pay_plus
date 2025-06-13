import 'dart:convert';

class ProcessTransactionResponse {
  final ProcessTransaction processTransaction;

  ProcessTransactionResponse({required this.processTransaction});

  factory ProcessTransactionResponse.fromJson(Map<String, dynamic> json) {
    final decoded = jsonDecode(json['processTransaction']); // decode the JSON string 
    return ProcessTransactionResponse(
      processTransaction: ProcessTransaction.fromJson(decoded)
    );
  }
}

class ProcessTransaction {
  final bool isSuccess;
  final TransactionData? data;
  final String? error;

  ProcessTransaction({required this.isSuccess, this.data, this.error});

  factory ProcessTransaction.fromJson(Map<String, dynamic> json) {
    String? parsedError;
    
    if (json['error'] != null) {
      final rawError = json['error'];
      try {
        final decoded = jsonDecode(rawError);
        if (decoded is List && decoded.isNotEmpty && decoded[0]['message'] != null) {
          parsedError = decoded.map((e) => e['message']).join('\n');
        } else {
          parsedError = decoded.toString();
        }
      } catch (_) {
        parsedError = rawError;
      }
    }
    
    return ProcessTransaction(
      isSuccess: json['isSuccess'] as bool,
      data: json['data'] != null ? TransactionData.fromMap(json['data']) : null,
      error: parsedError
    );
  }  
}

class TransactionData {
  final String transactionId;
  final double balance;
  final String receiptId;

  TransactionData({required this.transactionId, required this.balance, required this.receiptId});

  factory TransactionData.fromMap(Map<String, dynamic> map) {
    return TransactionData(
      transactionId: map['transactionId'] as String,
      balance: (map['balance'] as num).toDouble(),
      receiptId: map['receiptId'] as String
    );
  }  
}