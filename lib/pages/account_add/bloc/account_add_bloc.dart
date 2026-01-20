import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../data/data.dart';
import '../../../models/ModelProvider.dart' hide AccountType;
import '../../../utils/utils.dart';

part 'account_add_event.dart';
part 'account_add_state.dart';

final emptyAccount = Account(accountNumber: '', owner: '');

class AccountAddBloc extends Bloc<AccountAddEvent, AccountAddState> {
  AccountAddBloc() : super(AccountAddState()) {
    on<AccountTypeDropdownChanged>(_onAccountTypeDropdownChanged);
    on<AccountNumberChanged>(_onAccountNumberChanged);
    on<CardNumberChanged>(_onCardNumberChanged);
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    // on<BirthdateChanged>(_onBirthdateChanged);
    on<AccountFormSubmitted>(_onAccountFormSubmitted);
  }

  void _onAccountTypeDropdownChanged(AccountTypeDropdownChanged event, Emitter<AccountAddState> emit) {
    emit(state.copyWith(accountType: event.accountType));
  }

  void _onAccountNumberChanged(AccountNumberChanged event, Emitter<AccountAddState> emit) {
    emit(state.copyWith(accountNumber: AccountNumber.dirty(event.accountNumber)));
  }

  void _onCardNumberChanged(CardNumberChanged event, Emitter<AccountAddState> emit) {
    emit(state.copyWith(cardNumber: CardNumber.dirty(event.cardNumber)));
  }
  
  void _onFirstNameChanged(FirstNameChanged event, Emitter<AccountAddState> emit) {
    emit(state.copyWith(firstName: Name.dirty(event.firstName)));
  }

  void _onLastNameChanged(LastNameChanged event, Emitter<AccountAddState> emit) {
    emit(state.copyWith(lastName: Name.dirty(event.lastName)));  
  }
  
  // void _onBirthdateChanged(BirthdateChanged event, Emitter<AccountAddState> emit) {
  //   final dateString = DateFormat('dd/MM/yyyy').format(event.date); // format into dd/MM/yyyy
  //   final controller = TextEditingController(text: dateString);
  //   emit(state.copyWith(birthdateController: controller));
  // }

  Future<void> _onAccountFormSubmitted(AccountFormSubmitted event, Emitter<AccountAddState> emit) async {
    if (isFormValid()) {
      emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));
      try {
        if (!await isAccountExists()) {
          // TODO: change the getCurrentUser into secureStorage.getUsername
          final authUser = await Amplify.Auth.getCurrentUser();
          final acctNumber = state.accountNumber.value.replaceAll(RegExp(r'\s+'), '');
          final request = ModelMutations.create(
            Account(
              accountNumber: acctNumber,
              owner: authUser.userId,
              accountType: state.accountType.name,
              creditLimit: 0,
              expiry: TemporalDateTime(DateTime.now()),
              status: 'NA',
            )
          );
          final response = await Amplify.API.mutate(request: request).response;
          final data = response.data;
          
          emit(
            data != null && !response.hasErrors
            ? state.copyWith(formStatus: FormzSubmissionStatus.success, message: TextString.accountAddSuccess)
            : state.copyWith(formStatus: FormzSubmissionStatus.failure, message: TextString.accountAddFailure)
          );
        } else {
          emitError(emit, TextString.accountAlreadyLinked);
        }
      } on AuthException catch (e) {
        emit(state.copyWith(formStatus: FormzSubmissionStatus.failure, message: e.message));
      } on ApiException catch (e) {
        emit(state.copyWith(formStatus: FormzSubmissionStatus.failure, message: e.message));
      } catch (_) {
        emit(state.copyWith(formStatus: FormzSubmissionStatus.failure, message: TextString.error));
      }
    } else {
      emitError(emit, TextString.formError);
    }
  }

  // *** UTILITY METHODS *** 

  bool isFormValid() {
    final type = state.accountType; // AccountType enum
    if (type.isUnknown) { // if type not selected
      return false;
    }
    if (type.isSavings) { // if type is savings
      return state.isValid;
    }
    return isAccountNumberValid();
  }

  // bool isFormValid() {
  //   final type = state.accountType; // AccountType enum
  //   final birth = state.birthdateController.text;
  //   if (type.isUnknown || birth.isEmpty) { // if type is not selected
  //     return false;
  //   }
  //   if (type.isSA) { // if type is savings
  //     return state.isValid && isBirthdateValid();
  //   }
  //   return isAccountNumberValid() && isBirthdateValid();
  // }

  bool isAccountNumberValid() {
    final accountNumber = state.accountNumber.value;
    final isMatch = RegExp(r'^\d{3}-\d{4}-\d{6}-\d{1}$').hasMatch(accountNumber);
    return accountNumber.isNotEmpty && isMatch;
  }
  
  // bool isBirthdateValid() {
  //   final birthDate = state.birthdateController.text;
  //   final isMatch = RegExp(r'^(0[1-9]|1\d|2\d|3[01])/(0[1-9]|1[0-2])/(19[5-9]\d|20\d{2})$').hasMatch(birthDate);
  //   return birthDate.isNotEmpty && isMatch;
  // }

  Future<bool> isAccountExists() async {
    final account = state.accountNumber.value.replaceAll(RegExp(r'\s+'), '');
    final request = ModelQueries.get(Account.classType, AccountModelIdentifier(accountNumber: account));
    final response = await Amplify.API.query(request: request).response;
    final data = response.data;
    return data != null && data != emptyAccount;
  }

  void emitError(Emitter<AccountAddState> emit, String message) {
    emit(state.copyWith(formStatus: FormzSubmissionStatus.failure, message: message));
    emit(state.copyWith(formStatus: FormzSubmissionStatus.initial));
  }
}
