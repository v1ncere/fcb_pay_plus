part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  // TextEditingController
  final TextEditingController accountNumberController;
  final TextEditingController accountAliasController;
  final TextEditingController emailController;
  final TextEditingController mobileController;
  //
  final bool isPitakardExist;
  final AccountNumber accountNumber;
  final Name accountAlias;
  final Email email;
  final MobileNumber mobile;
  //
  final XFile? userImage;
  final double similarity;
  final List<int> livenessImageBytes;
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
  final Status confirmStatus;
  final Status webBridgeStatus;
  final Status webviewStatus;
  final Status status;

  const SignUpState({
    required this.accountNumberController,
    required this.accountAliasController,
    required this.emailController,
    required this.mobileController,
    this.isPitakardExist = true,
    this.accountNumber = const AccountNumber.pure(),
    this.accountAlias = const Name.pure(),
    this.email = const Email.pure(),
    this.mobile = const MobileNumber.pure(),
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
    this.confirmStatus = Status.initial,
    this.webBridgeStatus = Status.initial,
    this.webviewStatus = Status.initial,
  });

  SignUpState copyWith({
    TextEditingController? accountNumberController,
    TextEditingController? accountAliasController,
    TextEditingController? emailController,
    TextEditingController? mobileController,
    bool? isPitakardExist,
    AccountNumber? accountNumber,
    Name? accountAlias,
    Email? email,
    MobileNumber? mobile,
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
    Status? confirmStatus,
    Status? webBridgeStatus,
    Status? webviewStatus,
    Status? status,
  }) {
    return SignUpState(
      accountNumberController: accountNumberController ?? this.accountNumberController,
      accountAliasController: accountAliasController ?? this.accountAliasController,
      emailController: emailController ?? this.emailController,
      mobileController: mobileController ?? this.mobileController,
      isPitakardExist: isPitakardExist ?? this.isPitakardExist,
      accountNumber: accountNumber ?? this.accountNumber,
      accountAlias: accountAlias ?? this.accountAlias,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
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
      confirmStatus: confirmStatus ?? this.confirmStatus,
      webBridgeStatus: webBridgeStatus ?? this.webBridgeStatus,
      webviewStatus: webviewStatus ?? this.webviewStatus,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props {
    return [
      accountNumberController,
      accountAliasController,
      emailController,
      mobileController,
      isPitakardExist,
      accountNumber,
      accountAlias,
      email,
      mobile,
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
      confirmStatus,
      webBridgeStatus,
      webviewStatus,
      status,
    ];
  }
}
