import 'dart:convert';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:aws_signature_v4/aws_signature_v4.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:http/http.dart' as http;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/utils.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends HydratedBloc<SignUpEvent, SignUpState> {
  SignUpBloc()  : super(SignUpState(
          emailController: TextEditingController(),
          firstNameController: TextEditingController(),
          lastNameController: TextEditingController(),
          mobileController: TextEditingController(),
          passwordController: TextEditingController(),
          confirmPasswordController: TextEditingController(),
          zipCodeController: TextEditingController(),
        )) {
    on<EmailChanged>(_onEmailChanged);
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    on<MobileNumberChanged>(_onMobileNumberChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<UserImageChanged>(_onUserImageChanged);
    on<ProvinceChanged>(_onProvinceChanged);
    on<CityMunicipalityChanged>(_onCityMunicipalityChanged);
    on<BarangayChanged>(_onBarangayChanged);
    on<LostDataRetrieved>(_onLostDataRetrieved);
    on<EmailTextErased>(_onEmailTextErased);
    on<FirstNameTextErased>(_onFirstNameTextErased);
    on<LastNameTextErased>(_onLastNameTextErased);
    on<MobileTextErased>(_onMobileTextErased);
    on<PasswordTextErased>(_onPasswordTextErased);
    on<ConfirmPasswordTextErased>(_onConfirmPasswordTextErased);
    on<ZipCodeErased>(_onZipCodeErased);
    on<PasswordObscured>(_onPasswordObscured);
    on<ConfirmPasswordObscured>(_onConfirmPasswordObscured);
    on<ProvinceFetched>(_onProvinceFetched);
    on<MunicipalFetched>(_onMunicipalFetched);
    on<BarangayFetched>(_onBarangayFetched);
    on<ZipCodeFetched>(_onZipCodeFetched);
    on<ZipCodeChanged>(_onZipCodeChanged);
    on<LivenessImageBytesChanged>(_onLivenessImageBytesChanged);
    on<ValidIDTitleChanged>(_onValidIDChanged);
    on<StatusRefreshed>(_onStatusRefreshed);
    on<FaceComparisonFetched>(_onFaceComparisonFetched);
    on<UploadImageToS3>(_onUploadImageToS3);
    on<HandleSignUp>(_onHandleSignUp);
    on<HandleSignUpResult>(_onHandleSignupResult);
    on<ImageUploadProgressed>(_onImageUploadProgressed);
    on<PinCodeSubmitted>(_onPinCodeSubmitted);
    on<AuthSignupStepConfirmed>(_onAuthSignupStepConfirmed);
    on<AuthSignupStepDone>(_onAuthSignupStepDone);
    on<HydrateStateChanged>(_onHydrateStateChanged);
  }
  final ImagePicker _picker = ImagePicker();

  void _onEmailChanged(EmailChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(email: Email.dirty(event.email)));
  }

  void _onFirstNameChanged(FirstNameChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(firstName: Name.dirty(event.firstName)));
  }

  void _onLastNameChanged(LastNameChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(lastName: Name.dirty(event.lastName)));
  }

  void _onMobileNumberChanged(MobileNumberChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(mobile: MobileNumber.dirty(event.mobile)));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(password: Password.dirty(event.password)));
  }

  void _onConfirmPasswordChanged(ConfirmPasswordChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(confirmPassword: ConfirmedPassword.dirty(password: event.password, value: event.confirmPassword)));
  }

  void _onProvinceChanged(ProvinceChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(province: Name.dirty(event.province)));
  }

  void _onCityMunicipalityChanged(CityMunicipalityChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(cityMunicipality: Name.dirty(event.cityMunicipality)));
  }

  void _onBarangayChanged(BarangayChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(barangay: Name.dirty(event.barangay)));
  }

  void _onZipCodeChanged(ZipCodeChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(zipCode: Integer.dirty(event.zipCode)));
  }

  void _onLivenessImageBytesChanged(LivenessImageBytesChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(livenessImageBytes: event.livenessImageBytesList));
  }

  Future<void> _onUserImageChanged(UserImageChanged event, Emitter<SignUpState> emit) async {
    await _isScannedTextExists(event.image, emit);
  }

  // *** LOST DATA RETRIEVER ***
  Future<void> _onLostDataRetrieved(LostDataRetrieved events, Emitter<SignUpState> emit) async {
    try {
      final response = await _picker.retrieveLostData();
      
      if (response.isEmpty) {
        return;
      }

      emit(state.copyWith(imageStatus: Status.loading));
      final xFile = response.file;

      if (xFile != null) {
        await _isScannedTextExists(xFile, emit);
      } else {
        emit(state.copyWith(imageStatus: Status.failure, message: response.exception?.message ?? TextString.error));
      }
    } catch (_) {
      emit(state.copyWith(imageStatus: Status.failure, message: TextString.error));
    }
  }

  void _onValidIDChanged(ValidIDTitleChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(validIDTitle: event.validID));
  }

  void _onEmailTextErased(EmailTextErased event, Emitter<SignUpState> emit) {
    state.emailController.clear();
    emit(state.copyWith(email: const Email.pure()));
  }

  void _onFirstNameTextErased(FirstNameTextErased event, Emitter<SignUpState> emit) {
    state.firstNameController.clear();
    emit(state.copyWith(firstName: const Name.pure()));
  }

  void _onLastNameTextErased(LastNameTextErased event, Emitter<SignUpState> emit) {
    state.lastNameController.clear();
    emit(state.copyWith(lastName: const Name.pure()));
  }

  void _onMobileTextErased(MobileTextErased event, Emitter<SignUpState> emit) {
    state.mobileController.clear();
    emit(state.copyWith(mobile: const MobileNumber.pure()));
  }

  void _onPasswordTextErased(PasswordTextErased event, Emitter<SignUpState> emit) {
    state.passwordController.clear();
    emit(state.copyWith(password: const Password.pure()));
  }

  void _onConfirmPasswordTextErased(ConfirmPasswordTextErased event, Emitter<SignUpState> emit) {
    state.confirmPasswordController.clear();
    emit(state.copyWith(confirmPassword: const ConfirmedPassword.pure(password: '')));
  }

  void _onZipCodeErased(ZipCodeErased event, Emitter<SignUpState> emit) {
    state.zipCodeController.clear();
    emit(state.copyWith(zipCode: const Integer.pure()));
  }

  void _onPasswordObscured(PasswordObscured event, Emitter<SignUpState> emit) {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void _onConfirmPasswordObscured(ConfirmPasswordObscured event, Emitter<SignUpState> emit) {
    emit(state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword));
  }

  void _onZipCodeFetched(ZipCodeFetched event, Emitter<SignUpState> emit) {
    emit(state.copyWith(zipCodeStatus: Status.success));
  }

  // *** FETCH PROVINCE FROM URL ***
  Future<void> _onProvinceFetched(ProvinceFetched event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(provinceStatus: Status.loading));
    
    try {
      final url = Uri.https(dotenv.get('ADDRESS_HOST'), '/api/provinces.json');
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final List<dynamic> parsedData = json.decode(response.body);
        final provincies = parsedData.map((e) => Province.fromJson(e)).toList();
        provincies.sort((a, b) => a.name.compareTo(b.name));
        final noneProvince = Province('', 'N/A', '', '');
        emit(state.copyWith(provinceStatus: Status.success, provinceList: [noneProvince, ...provincies]));
      } else {
        emit(state.copyWith(provinceStatus: Status.failure, message: response.body));
      }
    } catch (_) {
      emit(state.copyWith(provinceStatus: Status.failure, message: TextString.error));
    }
  }

  // *** FETCH CITY/MUNICIPALITY FROM URL ***
  Future<void> _onMunicipalFetched(MunicipalFetched event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(cityMunicipalStatus: Status.loading));
    
    try {
      if (event.provinceCode.isEmpty) {
        final url = Uri.https(dotenv.get('ADDRESS_HOST'), '/api/cities-municipalities.json');
        final response = await http.get(url);
        
        if (response.statusCode == 200) {
          final List<dynamic> parsed = json.decode(response.body);
          final municipalities = parsed.map((e) => CityMunicipality.fromJson(e)).toList();
          final newMunicipalities = municipalities.where((e) => e.provinceCode == false).toList()
          ..sort((a, b) => a.name.compareTo(b.name));
          emit(state.copyWith(cityMunicipalStatus: Status.success, cityMunicipalityList: newMunicipalities));
        } else {
          emit(state.copyWith(cityMunicipalStatus: Status.failure, message: response.body));
        }
      } else {
        final url = Uri.https(dotenv.get('ADDRESS_HOST'), '/api/provinces/${event.provinceCode}/cities-municipalities.json');
        final response = await http.get(url);
        
        if (response.statusCode == 200) {
          final List<dynamic> parsed = json.decode(response.body);
          final municipalities = parsed.map((e) => CityMunicipality.fromJson(e)).toList();
          municipalities.sort((a, b) => a.name.compareTo(b.name));
          emit(state.copyWith(cityMunicipalStatus: Status.success, cityMunicipalityList: municipalities));
        } else {
          emit(state.copyWith(cityMunicipalStatus: Status.failure, message: response.body));
        }
      }
    } catch (_) {
      emit(state.copyWith(cityMunicipalStatus: Status.failure, message: TextString.error));
    }
  }

  // *** FETCH BARANGAY FROM URL ***
  Future<void> _onBarangayFetched(BarangayFetched event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(barangayStatus: Status.loading));
    
    try {
      if (event.municipalityCode.isEmpty) return;
      final url = Uri.https(dotenv.get("ADDRESS_HOST"), '/api/cities-municipalities/${event.municipalityCode}/barangays.json');
      final response = await http.get(url);
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        final barangays = jsonResponse.map((e) => Barangay.fromJson(e)).toList();
        barangays.sort((a, b) => a.name.compareTo(b.name));
        emit(state.copyWith(barangayStatus: Status.success, barangayList: barangays));
      } else {
        emit(state.copyWith(barangayStatus: Status.failure, message: response.body));
      }
    } catch (_) {
      emit(state.copyWith(barangayStatus: Status.failure, message: TextString.error));
    }
  }

  void _onStatusRefreshed(StatusRefreshed event, Emitter<SignUpState> emit) {
    emit(state.copyWith(
      barangayStatus: Status.initial, 
      barangayList: [],
      zipCodeStatus: Status.initial,
      zipCode: Integer.pure(),
    ));
  }


  // *** FACE COMPARISON ***
  Future<void> _onFaceComparisonFetched(FaceComparisonFetched event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(faceComparisonStatus: Status.loading));
    
    try {
      final scope = AWSCredentialScope(region: dotenv.get('COGNITO_REGION'), service: AWSService(dotenv.get('SERVICE')));
      final endpoint = Uri.https(dotenv.get('FACE_COMPARISON_HOST'), dotenv.get('FACE_COMPARISON_PATH'));
      final sourceImage = Uint8List.fromList(state.livenessImageBytes);
      final targetImage = await state.userImage!.readAsBytes();

      final request = AWSHttpRequest(
        method: AWSHttpMethod.post,
        uri: endpoint,
        headers: {
          AWSHeaders.host: endpoint.host,
          AWSHeaders.contentType: 'application/json',
        },
        body: utf8.encode(json.encode({
          'sourceImageBytes': base64Encode(await compressList(sourceImage)),
          'targetImageBytes': base64Encode(await compressList(targetImage)),
        })),
      );
      
      final signer = await _awsSigV4Signer();
      final signedRequest = await signer.sign(request, credentialScope: scope);
      final httpRequest = http.Request(signedRequest.method.value, signedRequest.uri)
      ..headers.addAll(signedRequest.headers)
      ..bodyBytes = await signedRequest.bodyBytes;

      final streamResponse = await httpRequest.send();
      final response = await http.Response.fromStream(streamResponse);

      if (response.statusCode == 200) {
        final Map<String, dynamic> map = jsonDecode(response.body);
        
        if (map.containsKey('FaceMatches') && (map['FaceMatches'] as List).isNotEmpty) {
          final List<dynamic> faceMatches = map['FaceMatches'];
          final double similarity = faceMatches.first['Similarity'] as double;

          if(similarity >= 90) {
            // add(UploadImageToS3()); // proceed to upload
            add(HandleSignUp());
            emit(state.copyWith(faceComparisonStatus: Status.success, similarity: similarity));
          } else {
            emit(state.copyWith(faceComparisonStatus: Status.failure, message: TextString.imageNotMatch));
          }
        } else {
          emit(state.copyWith(faceComparisonStatus: Status.failure, message: TextString.imageNotMatch));
        }
      } else {
        final Map<String, dynamic> map = jsonDecode(response.body);
        String message = map['message'] ?? TextString.error;
        emit(state.copyWith(faceComparisonStatus: Status.failure, message: message));
      }
    } catch (e) {
      emit(state.copyWith(faceComparisonStatus: Status.failure, message: TextString.error));
    }
  }

  // *** UPLOAD IMAGE TO S3 ***
  Future<void> _onUploadImageToS3(UploadImageToS3 event, Emitter<SignUpState> emit) async {
    final image = state.userImage;
    
    if (image == null) {
      emit(state.copyWith(uploadStatus: Status.failure, message: TextString.imageNotSelected));
      return;
    }
    emit(state.copyWith(uploadStatus: Status.loading));

    try {
      await Amplify.Storage.uploadFile(
        localFile: AWSFile.fromPath(image.path),
        path: StoragePath.fromString('picture-submission/${_fileName(image)}'), // path must be edited in resource
        onProgress: (progress) {
          emit(state.copyWith(uploadStatus: Status.progress));
          add(ImageUploadProgressed(progress.transferredBytes / progress.totalBytes));
        },
      ).result;

      emit(state.copyWith(uploadStatus: Status.success, message: TextString.signUpComplete));
    } on StorageException catch (e) {
      emit(state.copyWith(uploadStatus: Status.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(uploadStatus: Status.failure, message: TextString.error));
    }
  }

  void _onImageUploadProgressed(ImageUploadProgressed event, Emitter<SignUpState> emit) {
    emit(state.copyWith(progress: event.progress));
  }

  // *** SIGN UP METHOD ***
  Future<void> _onHandleSignUp(HandleSignUp event, Emitter<SignUpState> emit) async {
    final image = state.userImage;
    
    if (image == null) {
      _emitErrorAndReset(emit, TextString.imageNotSelected);
      return;
    }
    emit(state.copyWith(status: Status.loading));
    
    try {
      final result = await Amplify.Auth.signUp(
        username: state.email.value.trim(),
        password: state.password.value.trim(),
        options: SignUpOptions(
          userAttributes: {
            AuthUserAttributeKey.email: state.email.value.trim(),
            AuthUserAttributeKey.phoneNumber: '+63${state.mobile.value.trim()}',
            AuthUserAttributeKey.familyName: state.lastName.value.trim(),
            AuthUserAttributeKey.givenName: state.firstName.value.trim(),
            AuthUserAttributeKey.profile: 'picture-submission/${_fileName(image)}',
            AuthUserAttributeKey.address: '${state.barangay.value.trim()}, ${state.cityMunicipality.value.trim()}, ${state.province.value.trim()} ${state.zipCode.value.trim()}'
          }
        ),
      );
      add(HandleSignUpResult(result));
      add(const HydrateStateChanged(isHydrated: false));
    } on AuthException catch (e) {
      _emitErrorAndReset(emit, e.message);
    } catch (_) {
      _emitErrorAndReset(emit, TextString.error);
    }
  }

  // * PINCODE SUBMITTED * //
  Future<void> _onPinCodeSubmitted(PinCodeSubmitted event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(confirmStatus: Status.loading));
    try {
      fetchCognitoAuthSession();
      final result = await Amplify.Auth.confirmSignUp(
        username: state.email.value.trim(),
        confirmationCode: event.code.trim(),
      );
      add(HandleSignUpResult(result));
    } on AuthException catch (e) {
      emit(state.copyWith(confirmStatus: Status.failure, message: 'Error confirming user: ${e.message}'));
    } catch (e) {
      emit(state.copyWith(confirmStatus: Status.failure, message: 'Error confirming user: ${e.toString()}'));
    }
    emit(state.copyWith(confirmStatus: Status.initial));
  }

  // *** SIGN UP RESULT ***
  Future<void> _onHandleSignupResult(HandleSignUpResult event, Emitter<SignUpState> emit) async {
    final step = event.result.nextStep.signUpStep;
    switch (step) {
      case AuthSignUpStep.confirmSignUp:
        add(AuthSignupStepConfirmed(event.result));
        break;
      case AuthSignUpStep.done:
        add(AuthSignupStepDone(event.result));
        break;
    }
  }

  // *** CONFIRM SIGN UP ***
  void _onAuthSignupStepConfirmed(AuthSignupStepConfirmed event, Emitter<SignUpState> emit) {
    final details = event.result.nextStep.codeDeliveryDetails!;
    emit(state.copyWith(
      status: Status.canceled,
      message: 'A confirmation code has been sent to ${details.destination}.' 'Please check your ${details.deliveryMedium.name} for the code.'
    ));
  }

  // *** SIGN UP DONE ***
  void _onAuthSignupStepDone(AuthSignupStepDone event, Emitter<SignUpState> emit) {
    emit(state.copyWith(status: Status.success, message: TextString.signUpComplete));
    add(UploadImageToS3());
  }

  // *** HYDRATE STATE CHANGE ***
  void _onHydrateStateChanged(HydrateStateChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(isHydrated: event.isHydrated));
  }

  // * ============================== UTILITY METHODS ============================== * //

  Future<void> fetchCognitoAuthSession() async {
    try {
      final cognitoPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
      final result = await cognitoPlugin.fetchAuthSession();
      final identityId = result.identityIdResult.value;
      safePrint("Current user's identity ID: $identityId");
    } on AuthException catch (e) {
      safePrint('Error retrieving auth session: ${e.message}');
    }
  } 

  // *** TEXT SCANNING ***
  Future<void> _isScannedTextExists(XFile? image, Emitter<SignUpState> emit) async {
    if (state.validIDTitle.isEmpty) {
      emit(state.copyWith(imageStatus: Status.failure, message: TextString.selectImage));
      return;
    }

    if (image == null) {
      emit(state.copyWith(imageStatus: Status.failure, message: TextString.imageNotSelected));
      return;
    }

    emit(state.copyWith(imageStatus: Status.loading));
    
    try {
      final scope = AWSCredentialScope(region: dotenv.get('COGNITO_REGION'), service: AWSService(dotenv.get('SERVICE')));
      final endpoint = Uri.https(dotenv.get('TEXT_IN_IMAGE_HOST'), dotenv.get('TEXT_IN_IMAGE_PATH'));
      final imageBytes = await image.readAsBytes();

      final request = AWSHttpRequest(
        method: AWSHttpMethod.post,
        uri: endpoint,
        headers: {
          AWSHeaders.host: endpoint.host,
          AWSHeaders.contentType: 'application/json',
        },
        body: utf8.encode(json.encode({
          "imageBytes": base64Encode(await compressList(imageBytes))
        })),
      );
      
      final signer = await _awsSigV4Signer();
      final signedRequest = await signer.sign(request, credentialScope: scope);
      final httpRequest = http.Request(signedRequest.method.value, signedRequest.uri)
      ..headers.addAll(signedRequest.headers)
      ..bodyBytes = await signedRequest.bodyBytes;

      final streamResponse = await httpRequest.send();
      final response = await http.Response.fromStream(streamResponse);

      if (response.statusCode == 200) {
        final Map<String, dynamic> map = jsonDecode(response.body);
        
        if (map['TextDetections'].isNotEmpty) {
          List<dynamic> textDetectionList = map['TextDetections'];
          final title = _isTextExists(textDetectionList, state.validIDTitle.trim().toLowerCase());
          final first = _isTextExists(textDetectionList, state.firstName.value.trim().toLowerCase());
          final last = _isTextExists(textDetectionList, state.lastName.value.trim().toLowerCase());
          
          if (title && first && last) {
            emit(state.copyWith(imageStatus: Status.success, userImage: image));
          } else {
            emit(state.copyWith(imageStatus: Status.failure, message: TextString.imageNameMisMatch, userImage: null));
          }
        } else {
          emit(state.copyWith(imageStatus: Status.failure, message: TextString.imageEmpty, userImage: null));
        }
      } else {
        final Map<String, dynamic> map = jsonDecode(response.body);
        final message = map['message'] ?? TextString.error;
        emit(state.copyWith(imageStatus: Status.failure, message: message, userImage: null));
      }
    } catch (_) {
      emit(state.copyWith(imageStatus: Status.failure, message: TextString.error, userImage: null));
    }
  }

  bool _isTextExists(List<dynamic> list, String text) {
    for (var item in list) {
      final detectedText = item['DetectedText'].toString().replaceAll(',', '');
      final newText = detectedText.toLowerCase().trim();
      if (newText.contains(text)) {
        return true;
      }
    }
    return false;
  }

  Future<Uint8List> compressList(Uint8List list) async {
    final result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 1280,
      minWidth: 720,
      quality: 75,
      rotate: 135,
    );
    return result;
  }

  void _emitErrorAndReset(Emitter<SignUpState> emit, String message) {
    emit(state.copyWith(status: Status.failure, message: message));
    emit(state.copyWith(status: Status.initial));
  }

  String _fileName(XFile image) {
    final email = state.email.value.split('@').first;
    final newEmail = email.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    final type = image.path.split('.').last;
    return '$newEmail.$type';
  }

  Future<AWSSigV4Signer> _awsSigV4Signer() async {
    final cognito = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
    final result = await cognito.fetchAuthSession();
    final credential = result.credentialsResult.value;

    return  AWSSigV4Signer(
      credentialsProvider: AWSCredentialsProvider(
        AWSCredentials(
          credential.accessKeyId,
          credential.secretAccessKey,
          credential.sessionToken,
        )
      )
    );
  }

  @override
  Future<void> close() async {
    state.emailController.dispose();
    state.firstNameController.dispose();
    state.lastNameController.dispose();
    state.mobileController.dispose();
    state.passwordController.dispose();
    state.confirmPasswordController.dispose();
    return super.close();
  }

  @override
  SignUpState? fromJson(Map<String, dynamic> json) {
    final isHydrated = json['hydrate'] as bool;
    return isHydrated
    ? state.copyWith(
        emailController: TextEditingController()
          ..text = json['email'] as String,
        firstNameController: TextEditingController()
          ..text = json['first_name'] as String,
        lastNameController: TextEditingController()
          ..text = json['last_name'] as String,
        mobileController: TextEditingController()
          ..text = json['mobile_number'] as String,
        passwordController: TextEditingController()
          ..text = json['password'] as String,
        confirmPasswordController: TextEditingController()
          ..text = json['confirm_password'] as String,
        //
        email: Email.dirty(json['email'] as String),
        firstName: Name.dirty(json['first_name'] as String),
        lastName: Name.dirty(json['last_name'] as String),
        mobile: MobileNumber.dirty(json['mobile_number'] as String),
        password: Password.dirty(json['password'] as String),
        confirmPassword: ConfirmedPassword.dirty(
          password: json['password'] as String, 
          value: json['confirm_password'] as String
        ),
        isHydrated: isHydrated
      )
    : state.copyWith(isHydrated: false);
  }

  @override
  Map<String, dynamic>? toJson(SignUpState state) {
    return state.isHydrated
    ? {
        'email': state.email.value,
        'first_name': state.firstName.value,
        'last_name': state.lastName.value,
        'mobile_number': state.mobile.value,
        'password': state.password.value,
        'confirm_password': state.confirmPassword.value,
        'hydrate': state.isHydrated
      }
    : {'hydrate': false};
  }
}

// Future<bool> _isScannedTextExists(XFile image) async {
//   final recognizedText = await textRecognizer.processImage(InputImage.fromFilePath(image.path));
//   await textRecognizer.close();
//   final fcb = _isTextExist(recognizedText, 'FIRST CONSOLIDATED BANK');
//   final pitakard = _isTextExist(recognizedText, 'PITAKArd');
//   final account = _isTextExist(recognizedText, '6064 29');
//   return fcb && pitakard && account;
// }

// bool _isTextExist(RecognizedText recognized, String text) {
//   for (TextBlock block in recognized.blocks) {
//     for (TextLine line in block.lines) {
//       if (line.text.contains(text)) {
//         return true;
//       }
//     }
//   }
//   return false;
// }