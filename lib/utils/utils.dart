import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pollstar/data/di/service_locator.dart';
import 'package:pollstar/data/models/question.dart';
import 'package:pollstar/ui/home/bloc/user_info_bloc.dart';
import 'package:pollstar/ui/widgets/answer_dialogs.dart';
import 'package:pollstar/ui/widgets/dialogs.dart';
import 'package:pollstar/utils/app_constants.dart';
import 'package:pollstar/utils/extensions.dart';
import 'package:pollstar/utils/strings.dart';
import 'package:pollstar/utils/theme/colors.dart';
import 'package:pollstar/utils/theme/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUtils {
  static final AppUtils _instance = AppUtils._internal();

  factory AppUtils() => _instance;

  final bool _isDubugMode = kDebugMode;

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

  void showLogoutDialog(BuildContext context) {
    AppUtils().showAlertDialog(
      context,
      content: AppStrings.logoutMsg,
      okayBtn: AppStrings.logout,
      cancelBtn: AppStrings.cancel,
      onOkayPressed: () {
        _logout(context);
      },
    );
  }

  void _logout(BuildContext context) {
    context.read<UserInfoBloc>().add(
          const LogoutUser(),
        );
  }

  void clearData() {
    getIt<AppConstants>().clear();
  }

  void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future<void> openUrl(String url) async {
    var browserUrl = Uri.parse(url);
    if (await canLaunchUrl(browserUrl)) {
      await launchUrl(browserUrl);
    } else {
      _handleError("Sorry, Could not launch $url at the moment.");
    }
  }

  Future<void> openPhoneCall(String number) async {
    var telephoneUrl = Uri.parse("tel:$number");
    if (await canLaunchUrl(telephoneUrl)) {
      await launchUrl(telephoneUrl);
    } else {
      _handleError("Sorry, Could not call $number at the moment.");
    }
  }

  void _handleError(String msg) {}

  String getTimeFromDate(String? date) {
    if (date.isNullOrEmpty()) return "";
    final DateFormat dateFormat = DateFormat('h:mm a');
    var dateTime = DateFormat('yyyy-MM-ddThh:mm:ss').parse(date!);
    return dateFormat.format(dateTime).toLowerCase();
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

  void log(String? data) {
    if (_isDubugMode) {
      log("$data");
    }
  }

  void showSnackBar(BuildContext context, String msg) {
    var snackdemo = SnackBar(
      content: Text(
        msg,
        style: AppStyle.textStyleMedium.copyWith(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      backgroundColor: AppColors.greenColor,
      behavior: SnackBarBehavior.fixed,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackdemo);
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

  void showAnswerDialog(
    BuildContext context, {
    required Question question,
    required QuestionType questionType,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AnswerDialog(
            question: question,
            questionType: questionType,
          );
        });
  }
}
