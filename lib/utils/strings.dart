class AppStrings {
  static const appName = 'PollStar';

  static const appStoreUrl = '';
  static const playStoreUrl = '';

  final String feedbackEmail = "";
  final String feedbackSubject = "$appName - Feedback";

  final String supportEmail = "";
  final String supportSubject = "$appName - Support";

  static const String urlPrivacyPolicy = "https://dsnl.in";

  static const int resendOtpTime = 19;

  /// Login Screen
  static const loginTitle = "Sign in";
  static const loginHint = "Registered mobile number";
  static const loginBtnTxt = "SIGN IN";
  static const loginMsg =
      "Please enter your mobile number registered with ${AppStrings.appName}";
  static const loginPrivacyPolicyHeading =
      "By clicking the 'Sign in' button, you agree to our ";
  static const privacyPolicy = "Privacy Policy";
  static const errNumberNotRegistered =
      "The mobile number you entered is not registered with us";
  static const errValidPhoneNumber = "Enter a valid mobile number.";

  /// OTP Verification Screen
  static const otpVerificationTitle = "Verification Code";
  static const otpVerificationMsg =
      "We have sent a verification code via SMS to";
  static const otpVerificationMsg2 = "Please enter the code to continue.";
  static const otpResendBtn = "Resend verification code?";
  static const otpResendMessage1 = "Wait %s second to resend OTP";
  static const otpResendMessage2 = "Wait %s seconds to resend OTP";
  static const otpConfirmBtn = "CONTINUE";
  static const otpSuccessMsg = "OTP matched.\nLogging you in...";

  /// Home Screen
  static const inbox = "INBOX";
  static const outbox = "OUTBOX";

  static const logoutMsg = "Are you sure want to logout?";
  static const logout = "LOGOUT";
  static const cancel = "CANCEL";
  static const endSession = "END SESSION";

  ///Inbox Screen
  static const inboxEmptyHint = "No active question at this time.";
  static const lastUpdatedToday = "Last updated today at %s";
  static const qusNextSchedule = "The next scheduled question is at %s on %s.";
  static const reply = "Reply";
  static const answerHint = "Enter your answer";
  static const noResponseSent = "No response sent";

  ///Outbox Screen
  static const outboxEmptyHint = "No messages in your outbox.";

  ///Answer Confirmation Screen
  static const yennoMsg = "You selected %s is this correct?";
  static const answerEmpty = "Enter a valid answer";
  static const numberMsg1 = "You have entered";
  static const numberMsg2 = "Can you confirm is this correct?";
  static const answerSubmit = "yes. I confirm.";

  /// Help Screen
  static const reportProblem = "Report a problem";
  static const emergencyMsg = "In case of emergency call";
  static const orWriteToUs = "or write to us";
  static const natureOfProblem = "Nature of problem";
  static const additionalInformation = "Additional information";
  static const additionalInformationHint = "Text here...";
  static const submit = "SUBMIT";
  static const help = "Help";
  static const errProplemReportingNoTitle =
      "Please choose the $natureOfProblem";
  static const errProplemReportingNoMsg =
      "Please add additional information of the problem";

  /// Common Error messages
  static const yes = "YES";
  static const no = "NO";
  static const done = "DONE";
  static const error = "ERROR";
  static const okay = "OKAY";
  static const goToLogin = "Go to login";

  static const errorSession =
      "Your sessin has been expired. please login again to proceed further.";
  static const errUnknown =
      "We couldn't process further in this app. Please try again later.";

  static const errorApiUnknown =
      "We couldn't able to process right now. Please try again later.";
}
