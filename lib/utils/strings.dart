class AppStrings {
  static const appName = 'PollStar';

  static const appStoreUrl = '';
  static const playStoreUrl = '';

  final String feedbackEmail = "talam@auroville.org.in";
  final String feedbackSubject = "$appName - Feedback";

  final String supportEmail = "";
  final String supportSubject = "$appName - Support";

  final String prefSession = "user_session";
  final String prefUseLocalAuth = "use_local_auth";

  /// Login Screen
  static const loginTitle = "Sign in";
  static const loginHint = "Registered Mobile Number";
  static const loginBtnTxt = "SIGN IN";
  static const errNumberNotRegistered =
      "The mobile number you entered is not registered with us";

  /// OTP Verification Screen
  static const otpVerificationTitle = "Verification Code";
  static const otpVerificationMsg =
      "We have sent a verification code via SMS to %s.\nPlease enter the code to continue.";
  static const otpResendBtn = "Resend verification code?";
  static const otpConfirmBtn = "CONTINUE";
  static const otpSuccessMsg = "OTP matched.\nLogging you in...";

  /// Home Screen
  static const inbox = "INBOX";
  static const outbox = "OUTBOX";

  /// Help Screen
  static const reportProblem = "Report a problem";
  static const emergencyMsg = "In case of emergency call";
  static const orWriteToUs = "or write to us";
  static const natureOfProblem = "Nature of problem";
  static const additionalInformation = "Additional information";
  static const additionalInformationHint = "Text here...";
  static const submit = "SUBMIT";

  /// Common Error messages
  static const error = "ERROR";
  static const okay = "OKAY";
  static const errUnknown =
      "We couldn't process further in this app. Please try again later.";
}
