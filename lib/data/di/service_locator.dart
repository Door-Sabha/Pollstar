import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pollstar/data/network/api/pollstar_api.dart';
import 'package:pollstar/data/repository/pollstar_repository.dart';
import 'package:pollstar/utils/analytics_manager.dart';
import 'package:pollstar/utils/app_constants.dart';
import 'package:pollstar/utils/crashlytics_manager.dart';
import 'package:pollstar/utils/fcm_manager.dart';
import 'package:pollstar/utils/secure_storage_manager.dart';

import '../network/dio_client.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  getIt.registerSingleton(Dio());
  getIt.registerSingleton(DioClient(getIt<Dio>()));

  getIt.registerSingleton(PollStarApi(
    getIt<DioClient>(),
  ));
  getIt.registerSingleton(PollStarRepository());
  getIt.registerSingleton(AppConstants());
  getIt.registerSingleton(SecureStorageManager());
  getIt.registerSingleton(AnalyticsManager());
  getIt.registerSingleton(CrashlyticsManager());
  getIt.registerSingleton(FCMManager());
}
