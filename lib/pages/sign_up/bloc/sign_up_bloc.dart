import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart' hide Emitter;
import 'package:aws_signature_v4/aws_signature_v4.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:http/http.dart' as http;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:image_picker/image_picker.dart';

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
    on<MobileNumberChanged>(_onMobileNumberChanged);
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
      // TODO: CREATE SUBMIT
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
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
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
          final title = _isTextExists(textDetectionList, state.validIDTitle.value!.trim().toLowerCase());
          // final first = _isTextExists(textDetectionList, state.firstName.value.trim().toLowerCase());
          // final last = _isTextExists(textDetectionList, state.lastName.value.trim().toLowerCase());
          
          // if (title && first && last) {
          if (title) {
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