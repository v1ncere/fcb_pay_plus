import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data.dart' hide Merchant;
import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';

part 'dropdown_event.dart';
part 'dropdown_state.dart';

class DropdownBloc extends Bloc<DropdownEvent, DropdownState> {
  final SqfliteRepositories _sqfliteRepositories;
  DropdownBloc({
    required SqfliteRepositories sqfliteRepositories,
  }) : _sqfliteRepositories = sqfliteRepositories,
  super(DropdownState(status: Status.loading)) {
    on<DropdownFetched>(_onDropdownFetched);
  }

  Future<void> _onDropdownFetched(DropdownFetched event, Emitter<DropdownState> emit) async {
    try {
      GraphQLRequest<PaginatedResult<Model>> request; 
      final modelName = event.node.replaceAll('/{owner}', '').trim(); // model name from widget node
      final modelType = ModelProvider.instance.getModelTypeByModelName(modelName); // dynamic modelType base on modelName string
      
      if (event.node.contains('/{owner}')) {
        final queryField = QueryField(fieldName: 'owner').eq(event.uid);
        request = ModelQueries.list(modelType, where: queryField);
      } else {
        request = ModelQueries.list(modelType);
      }
      final response = await Amplify.API.query(request: request).response;
      final items = response.data?.items;
      
      if (items != null && !response.hasErrors) {
        final model = items.whereType<Model>().toList();
        
        if (modelType == Merchant.classType) {
          final authUser = await Amplify.Auth.getCurrentUser();
          final merchants = await _sqfliteRepositories.getAllMerchants();
          final myMerchant = merchants.where((e) => e.owner == authUser.userId);
          model.addAll(myMerchant.map((e) => Merchant(
            id: e.id,
            name: e.name,
            qrCode: e.qrCode,
            tag: e.tag,
          )));
        }

        emit(
          model.isNotEmpty
          ? state.copyWith(status: Status.success, dropdowns: model)
          : state.copyWith(status: Status.failure, message: TextString.empty)
        );
      } else {
        emit(state.copyWith(status: Status.failure, message: response.errors.first.message));
      }
    } on AuthException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.message));
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: TextString.error));
    }
  }
}
