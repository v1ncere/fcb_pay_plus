part of 'sign_up_bloc.dart';

class SignUpState extends Equatable with FormzMixin {
  const SignUpState({
    required this.emailController,
    required this.firstNameController,
    required this.lastNameController,
    required this.mobileController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.zipCodeController,
    //
    this.email = const Email.pure(),
    this.firstName = const Name.pure(),
    this.lastName = const Name.pure(),
    this.mobile = const MobileNumber.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmedPassword.pure(),
    this.userImage,
    this.similarity = 0.0,
    this.provinceList = const [],
    this.cityMunicipalityList = const [],
    this.barangayList = const [],
    this.province = const Name.pure(),
    this.cityMunicipality = const Name.pure(),
    this.barangay = const Name.pure(),
    this.zipCode = const Integer.pure(),
    this.livenessImageBytes = const [],
    this.validIDTitle = '',
    this.cityMunicipalStatus = Status.initial,
    this.provinceStatus = Status.initial,
    this.barangayStatus = Status.initial,
    this.zipCodeStatus = Status.initial,
    this.imageStatus = Status.initial,
    this.faceComparisonStatus = Status.initial,
    this.status = Status.initial,
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    this.progress = 0.0,
    this.message = '',
    this.isHydrated = false,
  });
  final TextEditingController emailController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController mobileController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController zipCodeController;
  //
  final Email email;
  final Name firstName;
  final Name lastName;
  final MobileNumber mobile;
  final Password password;
  final ConfirmedPassword confirmPassword;
  final XFile? userImage;
  final double similarity;
  final List<Province> provinceList;
  final List<CityMunicipality> cityMunicipalityList;
  final List<Barangay> barangayList;
  final Name province;
  final Name cityMunicipality;
  final Name barangay;
  final Integer zipCode;
  final List<int> livenessImageBytes;
  final String validIDTitle;
  final Status cityMunicipalStatus;
  final Status provinceStatus;
  final Status barangayStatus;
  final Status zipCodeStatus;
  final Status imageStatus;
  final Status faceComparisonStatus;
  final Status status;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final double progress;
  final String message;
  final bool isHydrated;

  SignUpState copyWith({
    // controllers
    TextEditingController? emailController,
    TextEditingController? firstNameController,
    TextEditingController? lastNameController,
    TextEditingController? mobileController,
    TextEditingController? passwordController,
    TextEditingController? confirmPasswordController,
    TextEditingController? zipCodeController,
    //
    Email? email,
    Name? firstName,
    Name? lastName,
    MobileNumber? mobile,
    Password? password,
    ConfirmedPassword? confirmPassword,
    XFile? userImage,
    double? similarity,
    List<Province>? provinceList,
    List<CityMunicipality>? cityMunicipalityList,
    List<Barangay>? barangayList,
    Name? province,
    Name? cityMunicipality,
    Name? barangay,
    Integer? zipCode,
    List<int>? livenessImageBytes,
    String? validIDTitle,
    Status? cityMunicipalStatus,
    Status? provinceStatus,
    Status? barangayStatus,
    Status? zipCodeStatus,
    Status? imageStatus,
    Status? faceComparisonStatus,
    Status? status,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    double? progress,
    String? message,
    bool? isHydrated,
  }) {
    return SignUpState(
        emailController: emailController ?? this.emailController,
        firstNameController: firstNameController ?? this.firstNameController,
        lastNameController: lastNameController ?? this.lastNameController,
        mobileController: mobileController ?? this.mobileController,
        passwordController: passwordController ?? this.passwordController,
        confirmPasswordController: confirmPasswordController ?? this.confirmPasswordController,
        zipCodeController: zipCodeController ?? this.zipCodeController,
        //
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        mobile: mobile ?? this.mobile,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        userImage: userImage ?? this.userImage,
        similarity: similarity ?? this.similarity,
        provinceList: provinceList ?? this.provinceList,
        cityMunicipalityList: cityMunicipalityList ?? this.cityMunicipalityList,
        barangayList: barangayList ?? this.barangayList,
        province: province ?? this.province,
        cityMunicipality: cityMunicipality ?? this.cityMunicipality,
        barangay: barangay ?? this.barangay,
        zipCode: zipCode ?? this.zipCode,
        livenessImageBytes: livenessImageBytes ?? this.livenessImageBytes,
        validIDTitle: validIDTitle ?? this.validIDTitle,
        cityMunicipalStatus: cityMunicipalStatus ?? this.cityMunicipalStatus,
        provinceStatus: provinceStatus ?? this.provinceStatus,
        barangayStatus: barangayStatus ?? this.barangayStatus,
        zipCodeStatus: zipCodeStatus ?? this.zipCodeStatus,
        imageStatus: imageStatus ?? this.imageStatus,
        faceComparisonStatus: faceComparisonStatus ?? this.faceComparisonStatus,
        status: status ?? this.status,
        obscurePassword: obscurePassword ?? this.obscurePassword,
        obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword,
        progress: progress ?? this.progress,
        message: message ?? this.message,
        isHydrated: isHydrated ?? this.isHydrated);
  }

  @override
  List<Object?> get props => [
    emailController,
    firstNameController,
    lastNameController,
    mobileController,
    passwordController,
    confirmPasswordController,
    zipCodeController,
    //
    email,
    firstName,
    lastName,
    mobile,
    password,
    confirmPassword,
    userImage,
    similarity,
    provinceList,
    cityMunicipalityList,
    barangayList,
    province,
    cityMunicipality,
    barangay,
    zipCode,
    livenessImageBytes,
    validIDTitle,
    cityMunicipalStatus,
    provinceStatus,
    barangayStatus,
    zipCodeStatus,
    imageStatus,
    faceComparisonStatus,
    status,
    obscurePassword,
    obscureConfirmPassword,
    progress,
    message,
    isHydrated,
    isValid
  ];

  @override
  List<FormzInput> get inputs => [
    email,
    firstName,
    lastName,
    mobile,
    password,
    confirmPassword
  ];
}
