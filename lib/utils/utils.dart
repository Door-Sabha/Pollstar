import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pollstar/ui/widgets/dialogs.dart';
import 'package:pollstar/utils/app_constants.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'strings.dart';

class AppUtils {
  static final AppUtils _instance = AppUtils._internal();

  factory AppUtils() => _instance;

  final bool _isDubugMode = true;

  AppUtils._internal();

  void pageRoute(BuildContext context, dynamic page) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => page),
    );
  }

  void pageRouteReplacement(BuildContext context, dynamic page) {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (context) => page),
    );
  }

  void pageRouteUntilClearStack(
    BuildContext context,
    dynamic page, {
    bool canClearStack = true,
  }) {
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(builder: (context) => page),
      (route) => !canClearStack,
    );
  }

  void pageRoute1(BuildContext context, dynamic page) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => page),
    );
  }

  void showLogoutDialog(BuildContext context) {
    AppUtils().showAlertDialog(
      context,
      content: "Are you sure want to logout?",
      okayBtn: "Logout".toUpperCase(),
      cancelBtn: "Cancel".toUpperCase(),
      onOkayPressed: () {
        logout(context);
      },
    );
  }

  void logout(BuildContext context) {
    clearData();
    //pageRouteUntilClearStack(context, const LandingScreen());
  }

  void clearData() {
    //getIt<AppConstants>().clear();
    //getIt<SecureStorageManager>().deleteAll();
  }

  String getTransactionDate(String date) {
    final DateFormat dateFormat = DateFormat('dd MMM, yyyy');
    var dateTime = DateFormat('dd-MM-yyyy hh:mm:ss').parse(date);
    return dateFormat.format(dateTime);
  }

  String toReadableDateFormat(String date) {
    final DateFormat dateFormat = DateFormat('dd MMM, yyyy');
    var dateTime = DateFormat('yyyy-MM-dd').parse(date);
    return dateFormat.format(dateTime);
  }

  String toReadableDateFromDateTime(DateTime date) {
    final DateFormat dateFormat = DateFormat('dd MMM, yyyy');
    return dateFormat.format(date);
  }

  String getMonthOfDate(DateTime date) {
    final DateFormat dateFormat = DateFormat('MMMM, yyyy');
    return dateFormat.format(date);
  }

  String getDateFormated_ddMMyyy(DateTime date) {
    final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    return dateFormat.format(date);
  }

  String getTimeAgo(String? date) {
    if (date == null) return "";
    var dateTime = DateFormat('dd-MM-yyyy hh:mm:ss').parse(date);
    return timeago.format(dateTime);
  }

  bool isValidNumber(String amount) => double.tryParse(amount) != null;
  bool isValidInt(String amount) => int.tryParse(amount) != null;

  // void sendFeedback() {
  //   ShareManager().openMail(AppStrings().feedbackEmail,
  //       AppStrings().feedbackSubject, getSupportBody());
  // }

  // void support() {
  //   getSupportBody();
  //   ShareManager().openMail(AppStrings().supportEmail,
  //       AppStrings().supportSubject, getSupportBody());
  // }

  void log(String? data) {
    if (_isDubugMode) {
      log("$data");
    }
  }

  void showAlertDialog(
    BuildContext context, {
    String? title,
    String? content,
    String? okayBtn,
    String? cancelBtn,
    Function? onOkayPressed,
    Function? onCancelPressed,
    bool isCancellable = true,
  }) {
    showDialog(
        context: context,
        barrierDismissible: isCancellable,
        builder: (BuildContext context) {
          return MyAlertDialog(
            title: title,
            content: content,
            okayBtn: okayBtn,
            cancelBtn: cancelBtn,
            isCancellable: isCancellable,
            onOkayPressed: onOkayPressed,
            onCancelPressed: onCancelPressed,
          );
        });
  }

  String getVersionNumber() {
    //return "Version ${getIt<AppConstants>().version} (${getIt<AppConstants>().buildNumber})";
    return "";
  }

  String getSupportBody() {
    String body = "";
    // body += "\n\n\n\n\n";
    // body += "--------------------\n";
    // body +=
    //     "App Version : ${getIt<AppConstants>().version} (${getIt<AppConstants>().buildNumber})";
    // body += "\nDevice info : ${getIt<AppConstants>().deviceData} ";
    // body += "\n--------------------";
    return body;
  }
}
