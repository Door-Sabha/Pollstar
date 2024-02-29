import 'dart:io';

import 'package:pollstar/data/di/service_locator.dart';
import 'package:pollstar/data/models/api_response.dart';
import 'package:pollstar/data/models/user.dart';
import 'package:pollstar/data/network/api/pollstar_api.dart';
import 'package:pollstar/ui/auth/bloc/otp_verification_bloc.dart';

class PollStarRepository {
  late final PollStarApi _api;

  PollStarRepository() {
    _api = getIt.get<PollStarApi>();
  }

  Future<User?> requestOtp({required String phone}) async {
    try {
      final response = await _api.requestOTP(phone);
      if (response.statusCode == HttpStatus.ok) {
        User user = User.fromJson(response.data);
        return user;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<ApiResponse?> verifyOtp(
      {required String phone, required String otp}) async {
    try {
      final response = await _api.validateOTP(phone, otp);
      if (response.statusCode == HttpStatus.ok) {
        ApiResponse res = ApiResponse.fromJson(response.data);
        return res;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
