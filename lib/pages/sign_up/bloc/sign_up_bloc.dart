import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

import '../../../data/data.dart';
import '../../../models/ModelProvider.dart';
import '../../../utils/utils.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends HydratedBloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpState(
    accountNumberController: TextEditingController(),
    accountAliasController: TextEditingController(),
    emailController: TextEditingController(),
    mobileController: TextEditingController(),
  )) {
    on<AccountNumberErased>(_onAccountNumberErased);
    on<AccountAliasErased>(_onAccountAliasErased);
    on<EmailTextErased>(_onEmailTextErased);
    on<MobileTextErased>(_onMobileTextErased);
    on<PitakardChecked>(_onPitakardChecked);
    on<AccountNumberChanged>(_onAccountNumberChanged);
    on<AccountAliasChanged>(_onAccountAliasChanged);
    on<EmailChanged>(_onEmailChanged);
    on<OtpCodeChanged>(_onOtpCodeChanged);
    on<MobileNumberChanged>(_onMobileNumberChanged);
    on<OtpCodeSent>(_onOtpCodeSent);
    on<OtpCodeVerified>(_onOtpCodeVerified);
    on<OtpCodeResent>(_onOtpCodeResent);
    on<UserImageChanged>(_onUserImageChanged);
    on<LostDataRetrieved>(_onLostDataRetrieved);
    on<LivenessImageBytesChanged>(_onLivenessImageBytesChanged);
    on<ValidIDTitleChanged>(_onValidIDChanged);
    on<FaceComparisonFetched>(_onFaceComparisonFetched);
    on<UploadImageToS3>(_onUploadImageToS3);
    on<HandleSignUp>(_onHandleSignUp);
    on<ImageUploadProgressed>(_onImageUploadProgressed);
    on<HydrateStateChanged>(_onHydrateStateChanged);
    on<WebviewMessageReceived>(_onWebviewMessageReceived);
    on<WebviewMessageSent>(_onWebviewMessageSent);
    on<BridgeTokenGenerated>(_onBridgeTokenGenerated);
    on<WebviewFetchLoadingStarted>(_onWebviewFetchLoadingStarted);
    on<WebviewFetchLoadingSucceeded>(_onWebviewFetchLoadingSucceeded);
    on<WebviewFetchFailed>(_onWebviewFetchFailed);
    on<WebviewFetchReset>(_onWebviewFetchReset);
  }

  void _onPitakardChecked(PitakardChecked event, Emitter<SignUpState> emit) {
    emit(state.copyWith(isPitakardExist: event.pitakardCheck));
  }

  void _onAccountNumberChanged(AccountNumberChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(accountNumber: AccountNumber.dirty(event.accountNumber)));
  }

  void _onAccountAliasChanged(AccountAliasChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(accountAlias: Name.dirty(event.accountAlias)));
  }

  void _onEmailChanged(EmailChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(email: Email.dirty(event.email)));
  }

  void _onMobileNumberChanged(MobileNumberChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(mobile: MobileNumber.dirty(event.mobile)));
  }

  void _onOtpCodeChanged(OtpCodeChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(otpCode: Integer.dirty(event.otpCode)));
  }

  void _onLivenessImageBytesChanged(LivenessImageBytesChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(livenessImageBytes: event.livenessImageBytesList));
  }

  Future<void> _onUserImageChanged(UserImageChanged event, Emitter<SignUpState> emit) async {
    await _isScannedTextExists(event.image, emit);
  }

  // *** LOST DATA RETRIEVER ***
  Future<void> _onLostDataRetrieved(LostDataRetrieved events, Emitter<SignUpState> emit) async {
    final ImagePicker picker = ImagePicker();
    final LostDataResponse response = await picker.retrieveLostData();
      
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
  }

  void _onValidIDChanged(ValidIDTitleChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(validIDTitle: DropdownData.dirty(event.validID)));
  }

  void _onAccountNumberErased(AccountNumberErased event, Emitter<SignUpState> emit) {
    state.accountNumberController.clear();
    emit(state.copyWith(accountNumber: const AccountNumber.pure()));
  }

  void _onAccountAliasErased(AccountAliasErased event, Emitter<SignUpState> emit) {
    state.accountAliasController.clear();
    emit(state.copyWith(accountAlias: const Name.pure()));
  }

  void _onEmailTextErased(EmailTextErased event, Emitter<SignUpState> emit) {
    state.emailController.clear();
    emit(state.copyWith(email: const Email.pure()));
  }

  void _onMobileTextErased(MobileTextErased event, Emitter<SignUpState> emit) {
    state.mobileController.clear();
    emit(state.copyWith(mobile: const MobileNumber.pure()));
  }

  // -------------------------- OTP ------------------------------- */
  Future<void> _onOtpCodeSent(OtpCodeSent event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(otpSendStatus: Status.loading));
    try {
      final response = await _fetchOtpHandler({
        "FunctionType": "send-otp",
        "Target": state.mobile.value,
        "Channel": "sms"
      });

      final Map<String, dynamic> jsonMap = jsonDecode(response.data!);
      final OtpApiResponse otpData = OtpApiResponse.fromJson(jsonMap);
      
      emit(
        otpData.otpApi.isSuccess
        ? state.copyWith(otpSendStatus: Status.success, message: otpData.otpApi.data!.message)
        : state.copyWith(otpSendStatus: Status.failure, message: otpData.otpApi.error)
      );
    } catch (e) {
      emit(state.copyWith(otpSendStatus: Status.failure, message: e.toString()));
    }
    emit(state.copyWith(otpSendStatus: Status.initial));
  }

  Future<void> _onOtpCodeVerified(OtpCodeVerified event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(otpVerifyStatus: Status.loading));
    try {
      final response = await _fetchOtpHandler({
        "FunctionType": "verify-otp",
        "Target": state.mobile.value,
        "Otp": event.otp,
      });

      final Map<String, dynamic> jsonMap = jsonDecode(response.data!);
      final OtpApiResponse otpData = OtpApiResponse.fromJson(jsonMap);
      emit(
        otpData.otpApi.isSuccess
        ? state.copyWith(otpVerifyStatus: Status.success, message: otpData.otpApi.data!.message)
        : state.copyWith(otpVerifyStatus: Status.failure, message: otpData.otpApi.error)
      );
    } catch (e) {
      emit(state.copyWith(otpVerifyStatus: Status.failure, message: e.toString()));
    }
    emit(state.copyWith(otpVerifyStatus: Status.initial));
  }

  Future<void> _onOtpCodeResent(OtpCodeResent event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(otpResendStatus: Status.loading));
    try {
      final response = await _fetchOtpHandler({
        "FunctionType": "resend-otp",
        "Target": state.mobile.value,
        "Channel": "sms"
      });

      final Map<String, dynamic> jsonMap = jsonDecode(response.data!);
      final OtpApiResponse otpData = OtpApiResponse.fromJson(jsonMap);
      emit(
        otpData.otpApi.isSuccess
        ? state.copyWith(otpResendStatus: Status.success, message: otpData.otpApi.data!.message)
        : state.copyWith(otpResendStatus: Status.failure, message: otpData.otpApi.error)
      );
    } catch (e) {
      emit(state.copyWith(otpResendStatus: Status.failure, message: e.toString()));  
    }
    emit(state.copyWith(otpResendStatus: Status.initial));
  }

  //** FACE COMPARISON */
  Future<void> _onFaceComparisonFetched(FaceComparisonFetched event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(faceComparisonStatus: Status.loading));
    
    try {
      final sourceImage = Uint8List.fromList(state.livenessImageBytes);
      final targetImage = await state.userImage!.readAsBytes();

      final req = {
        'SourceImageBytes': base64Encode(await compressList(sourceImage)),
        'TargetImageBytes': base64Encode(await compressList(targetImage)),
      };

      const graphQLDocument = '''
        query FaceComparison(\$data: AWSJSON!) {
          faceComparison(data: \$data)
        }
      ''';

      final echoRequest = GraphQLRequest<String>(
        document: graphQLDocument,
        variables: <String, dynamic> {
          "data": jsonEncode(req) 
        }
      );

      final response = await Amplify.API.query(request: echoRequest).response;
      final Map<String, dynamic> jsonMap = jsonDecode(response.data!);
      final res = FaceComparisonResponse.fromJson(jsonMap);
      
      if (res.faceComparison.ok) {
        if(res.faceComparison.isFirstMatchAbove(90)) {
          add(UploadImageToS3());
          // add(HandleSignUp());

          emit(state.copyWith(faceComparisonStatus: Status.success, similarity: res.faceComparison.firstSimilarity));
        } else {
          emit(state.copyWith(faceComparisonStatus: Status.failure, message: TextString.imageNotMatch));
        }
      } else {
        emit(state.copyWith(faceComparisonStatus: Status.failure, message: TextString.imageNotMatch));
      }
    } catch (e) {
      emit(state.copyWith(faceComparisonStatus: Status.failure, message: e.toString()));
    }
  }

  // *** UPLOAD IMAGE TO S3 ***
  Future<void> _onUploadImageToS3(UploadImageToS3 event, Emitter<SignUpState> emit) async {
    final userImage = state.userImage;
    final livenessImage = state.livenessImageBytes;
    emit(state.copyWith(uploadStatus: Status.loading));

    if (userImage == null || livenessImage.isEmpty) {
      emit(state.copyWith(uploadStatus: Status.failure, message: TextString.imageNotSelected));
      return;
    }

    try {
      int? totalA;
      int? totalB;
      int transferredA = 0;
      int transferredB = 0;
      
      // helper function for updating combined progress
      void updateProgress() {
        if (totalA != null && totalB != null) {
          final total = (totalA ?? 0) + (totalB ?? 0);
          final transferred = transferredA + transferredB;
          final double progress = total == 0 ? 0 : transferred / total;
          emit(state.copyWith(uploadStatus: Status.progress, progress: progress));
        }
      }

      final uploadA = Amplify.Storage.uploadFile(
        localFile: AWSFile.fromData(livenessImage),
        path: StoragePath.fromString('picture-submission/${_rawBytesName(livenessImage, state.email.value)}'), // path must be edited in resource (amplify) folder
        onProgress: (progress) {
          totalA ??= progress.totalBytes;
          transferredA = progress.transferredBytes;
          updateProgress();
        },
      ).result;

      final uploadB = Amplify.Storage.uploadFile(
        localFile: AWSFile.fromPath(userImage.path),
        path: StoragePath.fromString('picture-submission/${_fileName(userImage, state.email.value)}'), // path must be edited in resource (amplify) folder
        onProgress: (progress) {
          totalB ??= progress.totalBytes;
          transferredB = progress.transferredBytes;
          updateProgress();
        },
      ).result;

      // Wait for both uploads
      final results = await Future.wait([uploadA, uploadB]);
      add(HandleSignUp(results));
      emit(state.copyWith(uploadStatus: Status.success, message: TextString.signUpComplete));
    } on StorageException catch (e) {
      emit(state.copyWith(uploadStatus: Status.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(uploadStatus: Status.failure, message: TextString.error));
    }
  }

  void _onImageUploadProgressed(ImageUploadProgressed event, Emitter<SignUpState> emit) {
    emit(state.copyWith(uploadStatus: Status.progress, progress: event.progress));
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
      final signup = SignupRequest(
        accountNumber: state.accountNumber.value,
        accountAlias: state.accountAlias.value,
        email: state.email.value,
        mobileNumber: state.mobile.value,
        details: jsonEncode(state.lastMessage),
        profileRef: event.results[0].uploadedItem.path,
        validIdRef: event.results[1].uploadedItem.path,
      );
      final request = ModelMutations.create(signup);
      final response = await Amplify.API.mutate(request: request).response;

      final createdSignupRequest = response.data;
      if (createdSignupRequest == null) {
        _emitErrorAndReset(emit, response.errors.first.message);
        return;
      }
      
      emit(state.copyWith(status: Status.success));
    } catch (_) {
      _emitErrorAndReset(emit, TextString.error);
    }
  }

  // *** HYDRATE STATE CHANGE ***
  void _onHydrateStateChanged(HydrateStateChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(isHydrated: event.isHydrated));
  }

  Future<void> _onWebviewMessageReceived(WebviewMessageReceived event, Emitter<SignUpState> emit) async {
    try {
      final data = jsonDecode(event.message);
      if (data is! Map<String, dynamic>) {
        emit(state.copyWith(webBridgeStatus: Status.failure, message: 'Invalid message format'));
        return;
      }

      final token = data['bridgeToken'] as String?;
      final payload = data['data'] as Map<String, dynamic>?;
      
      // ✅ Validate bridge token
      if (token == null || token != state.activeBridgeToken) {
        emit(state.copyWith(
          webBridgeStatus: Status.failure,
          message: 'Unauthorized or invalid bridgeToken',
        ));
        return;
      }

      emit(state.copyWith(webBridgeStatus: Status.success, lastMessage: payload));
    } catch (e) {
      emit(state.copyWith(webBridgeStatus: Status.failure, message: 'Malformed bridge message: $e'));
    }
  }

  void _onWebviewMessageSent(WebviewMessageSent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(outgoingMessage: event.data));
  }

  void _onBridgeTokenGenerated(BridgeTokenGenerated event, Emitter<SignUpState> emit) {
    final chars = dotenv.get('BRIDGE_TOKEN');
    final rand = Random.secure();
    final token = List.generate(32, (_) => chars[rand.nextInt(chars.length)]).join();
    
    emit(state.copyWith(activeBridgeToken: token));
  }

  void _onWebviewFetchLoadingStarted(WebviewFetchLoadingStarted event, Emitter<SignUpState> emit) {
    emit(state.copyWith(webviewStatus: Status.loading));
  }

  void _onWebviewFetchLoadingSucceeded(WebviewFetchLoadingSucceeded event, Emitter<SignUpState> emit) {
    emit(state.copyWith(webviewStatus: Status.success));
  }

  void _onWebviewFetchFailed(WebviewFetchFailed event, Emitter<SignUpState> emit) {
    emit(state.copyWith(webviewStatus: Status.failure, message: event.error));
  }

  void _onWebviewFetchReset(WebviewFetchReset event, Emitter<SignUpState> emit) {
    emit(state.copyWith(webviewStatus: Status.initial));
  }

  // * ============================== UTILITY METHODS ============================== * //
  Future<GraphQLResponse<String>> _fetchOtpHandler(Map<String, String> req) async {
    const graphQLDocument = '''
      query OtpApi(\$data: AWSJSON!) {
        otpApi(data: \$data)
      }
    ''';

    final echoRequest = GraphQLRequest<String>(
      document: graphQLDocument,
      variables: <String, dynamic> {
        "data": jsonEncode(req)
      }
    );

    return await Amplify.API.query(request: echoRequest).response;
  }

  // *** TEXT SCANNING ***
  Future<void> _isScannedTextExists(XFile? image, Emitter<SignUpState> emit) async {
    if (state.validIDTitle.isNotValid) {
      emit(state.copyWith(imageStatus: Status.failure, message: TextString.selectImage));
      return;
    }

    if (image == null) {
      emit(state.copyWith(imageStatus: Status.failure, message: TextString.imageNotSelected));
      return;
    }

    emit(state.copyWith(imageStatus: Status.loading));
    
    try {
      final imageBytes = await image.readAsBytes();
      
      final req =  {
        "ImageBytes": base64Encode(await compressList(imageBytes)) 
      };

      const graphQLDocument = '''
        query TextInImage(\$data: AWSJSON!) {
          textInImage(data: \$data)
        }
      ''';

      final echoRequest = GraphQLRequest<String>(
        document: graphQLDocument,
        variables: <String, dynamic> {
          "data": jsonEncode(req) 
        }
      );

      final response = await Amplify.API.query(request: echoRequest).response;
      final Map<String, dynamic> jsonMap = jsonDecode(response.data!);
      final result = TextInImageResponse.fromJson(jsonMap);
      final text = result.textInImage;

      if (text.isSuccess && text.data != null) {
        final idTitle = state.validIDTitle.value!.trim().toLowerCase();
        final isMatch = text.containsText(idTitle);
        // final first = _isTextExists(textDetectionList, state.firstName.value.trim().toLowerCase());
        // final last = _isTextExists(textDetectionList, state.lastName.value.trim().toLowerCase());

        // if (title && first && last) {
        if (isMatch) {
          emit(state.copyWith(imageStatus: Status.success, userImage: image));
        } else {
          emit(state.copyWith(imageStatus: Status.failure, message: TextString.imageNameMisMatch, userImage: null));
        }
      } else {
        emit(state.copyWith(imageStatus: Status.failure, message: TextString.imageEmpty, userImage: null));
      }
    } catch (e) {
      emit(state.copyWith(imageStatus: Status.failure, message: e.toString(), userImage: null));
    }
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

  String _fileName(XFile image, String email) {
    final sanitizedEmail = email.split('@').first.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    final type = image.path.split('.').last;
    return 'id_$sanitizedEmail.$type';
  }

  String _rawBytesName(List<int> raw, String email) {
    final uint8 = Uint8List.fromList(raw);
    final mime = lookupMimeType('', headerBytes: uint8) ?? 'bin';
    final ext = extensionFromMime(mime);
    final sanitizedEmail = email.split('@').first.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    return 'liveness_$sanitizedEmail.$ext';
  }

  @override
  Future<void> close() async {
    state.accountNumberController.dispose();
    state.accountAliasController.dispose();
    state.emailController.dispose();
    state.mobileController.dispose();
    return super.close();
  }

  @override
  SignUpState? fromJson(Map<String, dynamic> json) {
    final isHydrated = json['hydrate'] as bool;
    return isHydrated
    ? state.copyWith(
        emailController: TextEditingController()..text = json['email'] as String,
        mobileController: TextEditingController()..text = json['mobile_number'] as String,
        email: Email.dirty(json['email'] as String),
        mobile: MobileNumber.dirty(json['mobile_number'] as String),
        isHydrated: isHydrated
      )
    : state.copyWith(isHydrated: false);
  }

  @override
  Map<String, dynamic>? toJson(SignUpState state) {
    return state.isHydrated
    ? {
        'email': state.email.value,
        'mobile_number': state.mobile.value,
        'hydrate': state.isHydrated
      }
    : {'hydrate': false};
  }
}