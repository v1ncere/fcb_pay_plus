part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

// TEXTFEILD CLEARED
final class AccountNumberErased extends SignUpEvent {}

final class CardNumberErased extends SignUpEvent {}

final class AccountAliasErased extends SignUpEvent {}

final class EmailTextErased extends SignUpEvent {}

final class MobileTextErased extends SignUpEvent {}

final class LostDataRetrieved extends SignUpEvent {}

final class PitakardChecked extends SignUpEvent {
  const PitakardChecked(this.pitakardCheck);
  final bool pitakardCheck;

  @override
  List<Object> get props => [pitakardCheck];
}

final class AccountNumberChanged extends SignUpEvent {
  const AccountNumberChanged(this.accountNumber);
  final String accountNumber;

  @override
  List<Object> get props => [accountNumber];
}

final class CardNumberChanged extends SignUpEvent {
  const CardNumberChanged(this.cardNumber);
  final String cardNumber;

  @override
  List<Object> get props => [cardNumber];
}

final class AccountAliasChanged extends SignUpEvent {
  const AccountAliasChanged(this.accountAlias);
  final String accountAlias;

  @override
  List<Object> get props => [accountAlias];
}

final class EmailChanged extends SignUpEvent {
  const EmailChanged(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}

final class MobileNumberChanged extends SignUpEvent {
  const MobileNumberChanged(this.mobile);
  final String mobile;

  @override
  List<Object> get props => [mobile];
}

final class OtpCodeChanged extends SignUpEvent {
  const OtpCodeChanged(this.otpCode);
  final String otpCode;

  @override
  List<Object> get props => [otpCode];
}

final class UserImageChanged extends SignUpEvent {
  const UserImageChanged(this.image);
  final XFile? image;

  @override
  List<Object?> get props => [image];
}

final class LivenessImageBytesChanged extends SignUpEvent {
  const LivenessImageBytesChanged(this.livenessImageBytesList);
  final List<int> livenessImageBytesList;

  @override
  List<Object> get props => [livenessImageBytesList];
}

final class ValidIDTitleChanged extends SignUpEvent {
  const ValidIDTitleChanged(this.validID);
  final String validID;

  @override
  List<Object> get props => [validID];
}

final class OtpCodeSent extends SignUpEvent {}

final class OtpCodeVerified extends SignUpEvent {
  const OtpCodeVerified(this.otp);
  final String otp;

  @override
  List<Object> get props => [otp];
}

final class OtpCodeResent extends SignUpEvent {}

final class FaceComparisonFetched extends SignUpEvent {}

final class UploadImageToS3 extends SignUpEvent {}

final class ImageUploadProgressed extends SignUpEvent {
  const ImageUploadProgressed(this.progress);
  final double progress;

  @override
  List<Object> get props => [progress];
}

final class HandleSignUp extends SignUpEvent {
  const HandleSignUp(this.results);
  final List<StorageUploadFileResult<StorageItem>> results;

  @override
  List<Object> get props => [results];
}

final class HydrateStateChanged extends SignUpEvent {
  const HydrateStateChanged({required this.isHydrated});
  final bool isHydrated;

  @override
  List<Object> get props => [isHydrated];
}

final class WebviewMessageReceived extends SignUpEvent {
  final String message;
  const WebviewMessageReceived(this.message);

  @override
  List<Object> get props => [message];
}

final class WebviewMessageSent extends SignUpEvent {
  final Map<String, dynamic> data;
  const WebviewMessageSent(this.data);

  @override
  List<Object> get props => [data];
}

// Called when a new token is generated
final class BridgeTokenGenerated extends SignUpEvent {}

final class WebviewFetchLoadingStarted extends SignUpEvent {}

final class WebviewFetchLoadingSucceeded extends SignUpEvent {}

final class WebviewFetchFailed extends SignUpEvent {
  const WebviewFetchFailed(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}

final class WebviewFetchReset extends SignUpEvent {}