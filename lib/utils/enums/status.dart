enum Status { initial, loading, progress, canceled, success, authenticate, failure }

extension StatusX on Status {
  bool get isInitial => this == Status.initial;
  bool get isLoading => this == Status.loading;
  bool get isProgress => this == Status.progress;
  bool get isCanceled => this == Status.canceled;
  bool get isSuccess => this == Status.success;
  bool get isAuthenticate => this == Status.authenticate;
  bool get isFailure => this == Status.failure;
}