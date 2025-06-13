import 'dart:async';
import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';

part 'receipt_event.dart';
part 'receipt_state.dart';

class ReceiptBloc extends Bloc<ReceiptEvent, ReceiptState> {
  ReceiptBloc() : super(const ReceiptState()) {
    on<ReceiptFetched>(_onReceiptFetched);
  }

  Future<void> _onReceiptFetched(ReceiptFetched event, Emitter<ReceiptState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final request = ModelQueries.get(Receipt.classType, ReceiptModelIdentifier(id: event.id));
      final response = await Amplify.API.query(request: request).response;
      // 
      if (!response.hasErrors) {
        final receipt = response.data;
        //
        if (receipt != null) {
          final Map<String, dynamic> newData = jsonDecode(receipt.data!);
          emit(state.copyWith(status: Status.success, receiptMap: newData));
        } else {
          emit(state.copyWith(status: Status.failure, message: TextString.empty));
        }
      } else {
        emit(state.copyWith(status: Status.failure, message: response.errors.first.message));
      }
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: TextString.error));
    }
  }
}