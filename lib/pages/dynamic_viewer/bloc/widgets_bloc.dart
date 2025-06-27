import 'dart:async';
import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';

part 'widgets_event.dart';
part 'widgets_state.dart';

final Account emptyAccount = Account(accountNumber: '', owner: '', ledgerStatus: '');
final DynamicWidget emptyWidget = DynamicWidget();

class WidgetsBloc extends Bloc<WidgetsEvent, WidgetsState> {
  WidgetsBloc() : super(WidgetsState(account: emptyAccount)) {
    on<SourceAccountFetched>(_onSourceAccountFetched);
    on<WidgetsFetched>(_onWidgetsFetched);
    on<UserIdFetched>(_onUserIdFetched);
    on<ExtraWidgetFetched>(_onExtraWidgetFetched);
    on<DynamicWidgetsValueChanged>(_onDynamicWidgetsValueChanged);
    on<ExtraWidgetsValueChanged>(_onExtraWidgetValueChanged);
    on<ButtonSubmitted>(_onButtonSubmitted);
  }
  final modelProvider = ModelProvider.instance;

  Future<void> _onSourceAccountFetched(SourceAccountFetched event, Emitter<WidgetsState> emit) async {
    emit(state.copyWith(accountStatus: Status.loading));
    try {
      final request = ModelQueries.get(Account.classType, AccountModelIdentifier(accountNumber: event.accountNumber));
      final response = await Amplify.API.query(request: request).response;
      final account = response.data;

      emit(
        account != null && !response.hasErrors
        ? state.copyWith(accountStatus: Status.success, account: account)
        : state.copyWith(accountStatus: Status.failure, message: response.errors.first.message)
      );
    } on ApiException catch (e) {
      emit(state.copyWith(accountStatus: Status.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(accountStatus: Status.failure, message: TextString.error));
    }
  }

  // fetched the user id from aws
  Future<void> _onUserIdFetched(UserIdFetched event, Emitter<WidgetsState> emit) async {
    emit(state.copyWith(userIdStatus: Status.loading));
    try {
      final authUser = await Amplify.Auth.getCurrentUser();
      emit(state.copyWith(userIdStatus: Status.success, uid: authUser.userId));
    } on AuthException catch (e) {
      emit(state.copyWith(userIdStatus: Status.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(userIdStatus: Status.failure, message: TextString.error));
    }
  }

  // 'button' is the parent of the 'widget' in the dynamic display
  Future<void> _onWidgetsFetched(WidgetsFetched event, Emitter<WidgetsState> emit) async {
    emit(state.copyWith(widgetStatus: Status.loading));
    try {
      final request = ModelQueries.list<DynamicWidget>(DynamicWidget.classType, where: DynamicWidget.BUTTON.eq(event.id));
      final response = await Amplify.API.query(request: request).response;
      final items = response.data?.items;

      if (!response.hasErrors && items != null) {
        final widgetList = items.whereType<DynamicWidget>().toList(); // convert into a non null value
        
        if (widgetList.isNotEmpty) {
          final hasData = await _dropdownHasData(widgetList);
          final widgets = widgetList.where((e) => e.widgetType != 'button').toList(); // get the non button widgets
          widgets.sort((a, b) => a.position!.compareTo(b.position!)); // sort widgets base on the [position]
          final button = widgetList.firstWhere((e) => e.widgetType == 'button', orElse: () => emptyWidget); // get the button widget

          emit(
            button != emptyWidget
            ? state.copyWith(widgetStatus: Status.success, widgetList: [...widgets, button], dropdownHasData: hasData)
            : state.copyWith(widgetStatus: Status.success, widgetList: widgets, dropdownHasData: hasData)
          );
        } else {
          emit(state.copyWith(widgetStatus: Status.failure, message: TextString.empty));
        }
      } else {
        emit(state.copyWith(widgetStatus: Status.failure, message: response.errors.first.message));
      }
    } on ApiException catch (e) {
      emit(state.copyWith(widgetStatus: Status.failure, message: e.message));
    } catch (_) {
      emit(state.copyWith(widgetStatus: Status.failure, message: TextString.error));
    }
  }

  // fetch extra widget base on Institution dropdown selection
  void _onExtraWidgetFetched(ExtraWidgetFetched event, Emitter<WidgetsState> emit) async {
    emit(state.copyWith(extraWidgetStatus: Status.loading));
    try {
      final request = ModelQueries.list(DynamicWidget.classType, where: DynamicWidget.MERCHANTEXTRAWIDGET.eq(event.id));
      final response = await Amplify.API.query(request: request).response;
      final items = response.data?.items;
      
      if (!response.hasErrors && items != null) {
        final extraWidgets = items.whereType<DynamicWidget>().toList();
        
        if (extraWidgets.isNotEmpty) {
          extraWidgets.sort((a, b) => a.position!.compareTo(b.position!));
          emit(state.copyWith(extraWidgetStatus: Status.success, extraWidgetList: extraWidgets));
        } else {
          emit(state.copyWith(extraWidgetStatus: Status.failure, message: TextString.empty));
        }
      } else {
        emit(state.copyWith(extraWidgetStatus: Status.failure, message: response.errors.first.message));
      }
    } on ApiException catch (e) {
      emit(state.copyWith(extraWidgetStatus: Status.failure, message: e.message));
    } catch (_) {
      emit(state.copyWith(extraWidgetStatus: Status.failure, message: TextString.error));
    }
  }

  // dynamic widget value changed
  void _onDynamicWidgetsValueChanged(DynamicWidgetsValueChanged event, Emitter<WidgetsState> emit) {
    // locate the [index] of the widget by matching the id in the widgetList.
    final index = state.widgetList.indexWhere((e) => e.id == event.id);
    // check if a widget with a matching id was found. [-1 means not found] 
    if (index != -1) {
      // create a copy of the current widgetList to update.
      final updatedDynamicWidget = List<DynamicWidget>.from(state.widgetList);
      // update the widget at the located index with the new content value.
      updatedDynamicWidget[index] = updatedDynamicWidget[index].copyWith(content: event.value); 
      emit(state.copyWith(widgetList: updatedDynamicWidget));
    }
  }

  // extra widget value changed
  void _onExtraWidgetValueChanged(ExtraWidgetsValueChanged event, Emitter<WidgetsState> emit) {
    // locate the [index] of the widget by matching the id in the List.
    final index = state.extraWidgetList.indexWhere((e) => e.id == event.id);
    // check if a widget with a matching id was found. [-1 means not found] 
    if (index != -1) {
      // create a copy of the current List
      final updatedExtraWidget = List<DynamicWidget>.from(state.extraWidgetList);
      // update the widget at the located index with the new content value.
      updatedExtraWidget[index] = updatedExtraWidget[index].copyWith(content: event.value); 
      emit(state.copyWith(extraWidgetList: updatedExtraWidget));
    }
  }

  // 
  Future<void> _onButtonSubmitted(ButtonSubmitted event, Emitter<WidgetsState> emit) async {
    emit(state.copyWith(submissionStatus: Status.loading));
    try {
      if (_areWidgetsValid(state.widgetList) && _areWidgetsValid(state.extraWidgetList)) {
        // transaction in Map
        final Map<String, dynamic> transaction = {
          if (_areRequiredWidgetsExist(state.widgetList))
            "DynamicWidgets": _mapConvert(state.widgetList),
          if (_areRequiredWidgetsExist(state.extraWidgetList))
            "ExtraWidgets": _mapConvert(state.extraWidgetList),
          "TransactionType": event.button.type!,
          "Owner": state.uid,
        };
        const graphQLDocument = '''
          query ProcessTransaction(\$data: AWSJSON!) {
            processTransaction(data: \$data)
          }
        ''';
        final echoRequest = GraphQLRequest<String>(
          document: graphQLDocument, 
          variables: <String, dynamic> {
            "data": jsonEncode(_cleanMap(transaction))
          }
        );
        final response = await Amplify.API.query(request: echoRequest).response;
        if (!response.hasErrors) {
          final Map<String, dynamic> jsonMap = jsonDecode(response.data!);
          final process = ProcessTransactionResponse.fromJson(jsonMap);

          emit(
            process.processTransaction.isSuccess
            ? state.copyWith(submissionStatus: Status.success, receiptId: process.processTransaction.data!.receiptId)
            : state.copyWith(submissionStatus: Status.failure, message: process.processTransaction.error)
          );
        } else {
          emit(state.copyWith(submissionStatus: Status.failure, message: response.errors.first.message));
        }
      } else {
        emit(state.copyWith(submissionStatus: Status.failure, message: TextString.incompleteForm));
      }
    } on ApiException catch (e) {
      emit(state.copyWith(submissionStatus: Status.failure, message: e.message));
    } catch (_) {
      emit(state.copyWith(submissionStatus: Status.failure, message: TextString.error));
    }
    emit(state.copyWith(submissionStatus: Status.initial));
  }

  // UTILITY FUNCTIONS =========================================================
  // check if list contains 'textfield' or 'dropdown' widget
  bool _areRequiredWidgetsExist<T extends dynamic>(List<T> list) {
    return list.any((e) => e.widgetType == 'textfield' || e.widgetType == 'dropdown');
  }

  Map<String, dynamic> _cleanMap(Map<String, dynamic> map) {
    final Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      if (value == null || (value is Map && value.isEmpty)) {
        return; // Skip nulls
      }
      newMap[key] = value; // Otherwise keep
    });
    return newMap;
  }

  // check all widgets if valid
  bool _areWidgetsValid<T extends dynamic>(List<T> list) {
    // regex for validating an [int] or [double with 2 decimal points]
    final regex = RegExp(r'^[-\\+]?\s*((\d{1,3}(,\d{3})*)|\d+)(\.\d{2})?$');
    // [STRING TEXTFIELD] match in the list
    final stringTextfield = list.where((e) => e.widgetType == 'textfield' && e.dataType == 'string');
    // [DOUBLE TEXTFIELD] match in the list
    final intTextfield = list.where((e) => e.widgetType == 'textfield' && e.dataType == 'int');
    // [STRING DROPDOWN] match in the list
    final stringDropdown = list.where((e) => e.widgetType == 'dropdown' && e.dataType == 'string');
    // [INT DROPDOWN] match in the list
    final intDropdown = list.where((e) => e.widgetType == 'dropdown' && e.dataType == 'int');
    // [STRING TEXTFIELD] exists [OR] contains data
    final isStringTextfieldValid = stringTextfield.isEmpty || stringTextfield.every((e) => e.content?.isNotEmpty == true);
    // [DOUBLE TEXTFIELD] exists [OR] contains data [AND] is valid [int/double]
    final isIntTextfieldValid = intTextfield.isEmpty || intTextfield.every((e) => e.content?.isNotEmpty == true && regex.hasMatch(e.content!));
    // [STRING DROPDOWN] exists [OR] contains data
    final isStringDropdownValid = stringDropdown.isEmpty || stringDropdown.every((e) => e.content?.isNotEmpty == true);
    // [INT DROPDOWN] exists [OR] contains data
    final isIntDropdownValid = intDropdown.isEmpty || intDropdown.every((e) => e.content?.isNotEmpty == true);
    // RETURN RESULT
    return isStringTextfieldValid && isIntTextfieldValid && isStringDropdownValid && isIntDropdownValid;
  }

  // // formatting dynamic list [content] into Map
  // Map<String, String> _widgetDataMap<T extends dynamic>(List<T> list) {
  //   final Map<String, String> map = {};
  //   for (final e in list) {
  //     if (e.widgetType == 'textfield' || e.widgetType == 'dropdown' || e.widgetType == 'multitextfield') {
  //       map[e.title] = e.content!; // store content into map
  //     }
  //   }
  //   return map;
  // }

  // formatting dynamic list [content] into map
  Map<String, dynamic> _mapConvert<T extends dynamic>(List<T> list) {
    final Map<String, dynamic> map = {};
    for (final item in list) {
      final dynamic e = item;
      if (e?.title != null && e?.content != null) {
        var value = e.content;
        if (value is String && isNumeric(value)) {
          value = parseNumeric(value)!;
        }
        map[e.title.toString().replaceAll(RegExp(r'\s+'), '')] = value; // remove spaces
      }
    }
    return map;
  }

  bool isNumeric(String s) {
    // Remove currency symbols and spaces
    final cleaned = s.replaceAll(RegExp(r'[^\d.,-]'), '').replaceAll(',', '');
    // Final check with tryParse
    return num.tryParse(cleaned) != null;
  }

  num? parseNumeric(String s) {
    final cleaned = s.replaceAll(RegExp(r'[^\d.,-]'), '').replaceAll(',', '');
    return num.tryParse(cleaned);
  }

  // check for empty dropdown data
  Future<bool> _dropdownHasData(List<DynamicWidget> widgetList) async {
    // mapped the widgetList for dropdown && not user_account
    final dropdowns = widgetList.where((e) => e.widgetType == 'dropdown' && !(e.node ?? '').contains('Account')).toList();
    
    if (dropdowns.isNotEmpty) {
      for (final e in dropdowns) {
        final node = (e.node ?? '').trim();
        if (node.isNotEmpty) {
          GraphQLRequest<PaginatedResult<Model>> request;
          final modelType = modelProvider.getModelTypeByModelName(node.replaceAll('/{owner}', '')); // get modelType dynamically base on node

          if (node.contains('/{owner}')) {
            final queryField = QueryField(fieldName: 'owner');
            request = ModelQueries.list(modelType, where: queryField.eq(state.uid));
          } else {
            request = ModelQueries.list(modelType);
          }
          final response = await Amplify.API.query(request: request).response;
          final items = response.data?.items;

          if (items == null || items.isEmpty) {
            return false; // return false if node exists but no value
          }
        }
      }
    }
    return true; // return true if dropdown is empty
  }
}