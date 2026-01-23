part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  // TextEditingController
  final TextEditingController accountNumberController;
  final TextEditingController cardNumberController;
  final TextEditingController accountAliasController;
  final TextEditingController emailController;
  final TextEditingController mobileController;
  //
  final bool isPitakardExist;
  final AccountNumber accountNumber;
  final CardNumber cardNumber;
  final Name accountAlias;
  final Email email;
  final MobileNumber mobile;
  final Integer otpCode;
  //
  final XFile? userImage; // valid id image XFile
  final double similarity;
  final List<int> livenessImageBytes; // liveness image bytes
  final DropdownData validIDTitle;
  // Informational
  final double progress;
  final String message;
  final bool isHydrated;
  //
  final Map<String, dynamic> lastMessage;
  final Map<String, dynamic> outgoingMessage;
  final String activeBridgeToken;
  // Status
  final Status imageStatus;
  final Status faceComparisonStatus;
  final Status uploadStatus;
  final Status otpSendStatus;
  final Status otpVerifyStatus;
  final Status otpResendStatus;
  final Status webBridgeStatus;
  final Status webviewStatus;
  final Status status;

  const SignUpState({
    required this.accountNumberController,
    required this.cardNumberController,
    required this.accountAliasController,
    required this.emailController,
    required this.mobileController,
    this.isPitakardExist = true,
    this.accountNumber = const AccountNumber.pure(),
    this.cardNumber = const CardNumber.pure(),
    this.accountAlias = const Name.pure(),
    this.email = const Email.pure(),
    this.mobile = const MobileNumber.pure(),
    this.otpCode = const Integer.pure(),
    this.userImage,
    this.similarity = 0.0,
    this.livenessImageBytes = const [],
    this.validIDTitle = const DropdownData.pure(),
    this.progress = 0.0,
    this.message = '',
    this.isHydrated = false,
    this.lastMessage = const {},
    this.outgoingMessage = const {},
    this.activeBridgeToken = '',
    this.imageStatus = Status.initial,
    this.faceComparisonStatus = Status.initial,
    this.status = Status.initial,
    this.uploadStatus = Status.initial,
    this.otpSendStatus = Status.initial,
    this.otpVerifyStatus = Status.initial,
    this.otpResendStatus = Status.initial,
    this.webBridgeStatus = Status.initial,
    this.webviewStatus = Status.initial,
  });

  SignUpState copyWith({
    TextEditingController? accountNumberController,
    TextEditingController? cardNumberController,
    TextEditingController? accountAliasController,
    TextEditingController? emailController,
    TextEditingController? mobileController,
    bool? isPitakardExist,
    AccountNumber? accountNumber,
    CardNumber? cardNumber,
    Name? accountAlias,
    Email? email,
    MobileNumber? mobile,
    Integer? otpCode,
    XFile? userImage,
    double? similarity,
    List<int>? livenessImageBytes,
    DropdownData? validIDTitle,
    double? progress,
    String? message,
    bool? isHydrated,
    Map<String, dynamic>? lastMessage,
    Map<String, dynamic>? outgoingMessage,
    String? activeBridgeToken,
    Status? imageStatus,
    Status? faceComparisonStatus,
    Status? uploadStatus,
    Status? otpSendStatus,
    Status? otpVerifyStatus,
    Status? otpResendStatus,
    Status? webBridgeStatus,
    Status? webviewStatus,
    Status? status,
  }) {
    return SignUpState(
      accountNumberController: accountNumberController ?? this.accountNumberController,
      cardNumberController: cardNumberController ?? this.cardNumberController,
      accountAliasController: accountAliasController ?? this.accountAliasController,
      emailController: emailController ?? this.emailController,
      mobileController: mobileController ?? this.mobileController,
      isPitakardExist: isPitakardExist ?? this.isPitakardExist,
      accountNumber: accountNumber ?? this.accountNumber,
      accountAlias: accountAlias ?? this.accountAlias,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      otpCode: otpCode ?? this.otpCode,
      userImage: userImage ?? this.userImage,
      similarity: similarity ?? this.similarity,
      livenessImageBytes: livenessImageBytes ?? this.livenessImageBytes,
      validIDTitle: validIDTitle ?? this.validIDTitle,
      progress: progress ?? this.progress,
      message: message ?? this.message,
      isHydrated: isHydrated ?? this.isHydrated,
      lastMessage: lastMessage ?? this.lastMessage,
      outgoingMessage: outgoingMessage ?? this.outgoingMessage,
      activeBridgeToken: activeBridgeToken ?? this.activeBridgeToken,
      imageStatus: imageStatus ?? this.imageStatus,
      faceComparisonStatus: faceComparisonStatus ?? this.faceComparisonStatus,
      uploadStatus: uploadStatus ?? this.uploadStatus,
      otpSendStatus: otpSendStatus ?? this.otpSendStatus,
      otpVerifyStatus: otpVerifyStatus ?? this.otpVerifyStatus,
      otpResendStatus: otpResendStatus ?? this.otpResendStatus,
      webBridgeStatus: webBridgeStatus ?? this.webBridgeStatus,
      webviewStatus: webviewStatus ?? this.webviewStatus,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props {
    return [
      accountNumberController,
      cardNumberController,
      accountAliasController,
      emailController,
      mobileController,
      isPitakardExist,
      accountNumber,
      accountAlias,
      email,
      mobile,
      otpCode,
      userImage,
      similarity,
      livenessImageBytes,
      validIDTitle,
      progress,
      message,
      isHydrated,
      lastMessage,
      outgoingMessage,
      activeBridgeToken,
      imageStatus,
      faceComparisonStatus,
      uploadStatus,
      otpSendStatus,
      otpVerifyStatus,
      otpResendStatus,
      webBridgeStatus,
      webviewStatus,
      status,
    ];
  }
}
