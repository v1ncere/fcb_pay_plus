class TextString {
  static const String appName = 'FCBPay';
  // local authentication
  static const String setupPin = 'Setup PIN';
  static const String createPin = 'Create PIN';
  static const String updatePin = 'Update PIN';
  static const String currentPin = 'Current PIN';
  static const String useSixDigitsPin = 'Use a 6-digit PIN';
  static const String enterYourPIN = 'Please enter your PIN';
  static const String confirmPin = 'Re-enter your PIN';
  static const String confirmPinSuccess = 'Your PIN code has been successfully created';
  static const String confirmPinFailure = 'The entered PIN codes do not match';
  static const String authenticationSuccess = 'Login Success';
  static const String authenticationFailure = 'Login Failed';
  static const String currentPinAccepted = 'PIN Accepted';
  static const String currentPinRejected = 'PIN Failed';
  static const String updatePinSuccess = 'Your PIN code has been successfully changed';
  // biometric authentication
  static const String localizedReason = 'Scan your fingerprint to authenticate';
  static const String authSuccess = 'Welcome! You\'re securely authenticated.';
  static const String authFailure = 'Oops! Authentication failed. Please try again';
  static const String biometricEnabled = 'Use fingerprint for authentication';
  static const String biometricDisabled = 'Biometric authentication is currently disabled. Enable it in settings for added security.';
  static const String biometricUnsupported = 'Sorry, your device doesn\'t support biometric authentication.';
  // network connectivity
  static const String internetError = 'No internet connection. Please check your network settings.';
  static const String disconnected = 'No connection. Swipe down to try again.';
  // form error
  static const String incompleteForm = 'Incomplete Form: Please review the form and make sure all required fields are filled in correctly.';
  static const String formError = 'Please complete all required fields before submitting your form. Thank you!';
  static const String invalidDate = 'Invalid date format. Please enter a valid date in the format: dd/MM/yyyy.';
  static const String registrationNote = 'Please verify your data for accuracy and completeness before proceeding with the registration.';
  // firebase 
  static const String verifyEmail = "Please verify your email address to continue. We've sent a verification link to your email.";
  static const String noEmail = 'Phone number not registered. Please sign up first.';
  static const String verifyRequest = "Registration account successful! We've sent a verification link to your email.";
  // FCB SLOGAN
  static const String slogan = 'Where Quality Service is a Commitment.';
  // OTP
  static const String otpSuccess = 'OTP verified. Access granted.';
  static const String otpExpired = "The authentication code has expired. Click 'Resend Code' to receive a new code.";
  // MULTIFACTOR AUTH
  static const String mfaTitle = 'Multi-Factor Authentication';
  // ACCOUNT
  static const String accountAlreadyLinked = 'An account with these details already exists. Please try again with different information.';
  static const String accountNotExist = 'The account you entered does not exist.';
  static const String accountEmpty = 'You need to register an account to proceed with this transaction.';
  static const String accountAddSuccess = 'Your new Account has been successfully created.';
  static const String accountAddFailure = "We couldn't create your account at this time. Please try again later.";
  // GENERAL ERROR
  static const String error = 'Oops! Something went wrong.';
  static const String empty = 'Empty';
  static const String dynamicEmptyFields = 'Oops! You forgot something. Please fill in this field.';
  static const String pageError = 'Oops! Something went wrong. Click here to refresh.';
  static const String dynamicAmountInvalid = 'Amount is invalid. Please try again.';
  static const String dynamicAmountRequired = 'Amount is required';
  // FACELIVENESS
  static const String faceLivenessSuccess = "Verification successful!";
  static const String faceLivenessFailed = 'Face verification failed. Please ensure your face is clearly visible and try again.';
  static const String faceScan = 'Scan your face';
  // IMAGE
  static const String imageNote = 'Note: Please upload a clear image of your valid ID, ensuring the card is readable by the app.';
  static const String imageRetake = 'Please retake the photo.';
  static const String imageEmpty = "We couldn't detect any text from your ID. Please try again in good lighting and ensure the entire ID is visible.";
  static const String imageNameMisMatch = "The name on your ID does not match your registered account name. Please ensure you're using the correct ID.";
  static const String imageError = 'Image is not a valid ID';
  static const String invalidImage = 'Invalid image';
  static const String selectImage = 'Please select valid ID';
  static const String imageNotSelected = "No photo selected. Please choose or take a photo of your ID to continue.";
  static const String imageNotMatch = 'No face matches found.';
  // PAYMENT
   static const String paymentNote = 'Please verify your data for accuracy and completeness before proceeding with the payment.';
  // transactions
  static const String transactionNote = 'Please verify your data for accuracy and completeness before proceeding with the transaction.';
  static const String transactionDisabled = 'Please contact support to enable this transaction.';
  static const String transactionSuccess = 'Transaction Successful!';
  // Login
  static const String resetPasswordDone = 'Password reset successful. Please log in using your new password.';
  static const String signUpConfirmed = 'Confirmed Successful!';
  static const String newPassword = 'Enter a new password to continue signing in';
  static const String resetPasswordFail = 'Password reset failed. Please try again.';
  // Sign up
  static const String signUpComplete = 'Sign up is complete';
  static const String submitText = "Processing your sign-up, please wait...";
  // QR CODE
  static const String merchantExists = 'Merchant has already been added.';
  static const String noMerchant = 'Merchant not found.';
}