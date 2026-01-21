import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../utils/utils.dart';

part 'home_webview_event.dart';
part 'home_webview_state.dart';

class HomeWebviewBloc extends Bloc<HomeWebviewEvent, HomeWebviewState> {
  HomeWebviewBloc() : super(HomeWebviewState()) {
    on<WebviewFetchLoadingStarted>(_onWebviewFetchLoadingStarted);
    on<WebviewFetchLoadingSucceeded>(_onWebviewFetchLoadingSucceeded);
    on<WebviewFetchFailed>(_onWebviewFetchFailed);
    on<WebviewFetchReset>(_onWebviewFetchReset);
  }

  void _onWebviewFetchLoadingStarted(WebviewFetchLoadingStarted event, Emitter<HomeWebviewState> emit) {
    emit(state.copyWith(status: Status.loading));
  }

  void _onWebviewFetchLoadingSucceeded(WebviewFetchLoadingSucceeded event, Emitter<HomeWebviewState> emit) {
    emit(state.copyWith(status: Status.success));
  }

  void _onWebviewFetchFailed(WebviewFetchFailed event, Emitter<HomeWebviewState> emit) {
    emit(state.copyWith(status: Status.failure, message: event.error));
  }

  void _onWebviewFetchReset(WebviewFetchReset event, Emitter<HomeWebviewState> emit) {
    emit(state.copyWith(status: Status.initial));
  }
}
