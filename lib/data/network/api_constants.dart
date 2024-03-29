class APIConstants {
  APIConstants._();

  static const AppType appType = AppType.dev;

  static String baseUrl =
      (appType == AppType.prod) ? _baseUrlProd : _baseUrlDev;

  static const String _baseUrlProd = "https://pollstarapp.dsnl.in:8443/";
  static const String _baseUrlDev = "https://pollstarapp.dsnl.in:8443/";
  static const Duration receiveTimeout = Duration(seconds: 15);
  static const Duration connectionTimeout = Duration(seconds: 15);

  static const String requestOtp = 'users/login';
  static const String validateOtp = 'users/validate_otp';
  static const String userInfo = 'users/info';
  static const String userLogout = 'users/logout';
  static const String updateUser = 'users/update';
  static const String updateFcm = 'users/update_fcm';

  static const String inboxQuestionList = 'questions/list';
  static const String outboxQuestionList = 'questions/list';
  static const String updateAnswer = 'questions/update_answer';
  static const String questionsQueued = 'questions/queued';
  static const String questionsTriggered = 'questions/triggered';

  static const String reportProblem = 'users/report_problem';
}

enum AppType {
  dev,
  prod,
}
