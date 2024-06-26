import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pollstar/data/network/api/pollstar_api.dart';
import 'package:pollstar/data/repository/pollstar_repository.dart';
import 'package:pollstar/utils/analytics_manager.dart';
import 'package:pollstar/utils/app_constants.dart';
import 'package:pollstar/utils/connectivity_manager.dart';
import 'package:pollstar/utils/crashlytics_manager.dart';
import 'package:pollstar/utils/fcm_manager.dart';
import 'package:pollstar/utils/local_notification_manager.dart';
import 'package:pollstar/utils/secure_storage_manager.dart';

import '../network/dio_client.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  getIt.registerSingleton(AppConstants());
  getIt.registerSingleton(FCMManager());
  getIt.registerSingleton(LocalNotificationManager());
  getIt.registerSingleton(SecureStorageManager());
  getIt.registerSingleton(AnalyticsManager());
  getIt.registerSingleton(CrashlyticsManager());
  getIt.registerSingleton(ConnectivityManager());
  getIt.registerSingleton(Dio());
  getIt.registerSingleton(DioClient(getIt<Dio>()));
  getIt.registerSingleton(PollStarApi(
    getIt<DioClient>(),
  ));
  getIt.registerSingleton(PollStarRepository());
}
