import 'dart:io';

import 'package:flutter/services.dart';
import 'package:pollstar/data/di/service_locator.dart';
import 'package:pollstar/data/models/api_response.dart';
import 'package:pollstar/data/models/question.dart';
import 'package:pollstar/data/models/user.dart';
import 'package:pollstar/data/network/api/pollstar_api.dart';

class PollStarRepository {
  late final PollStarApi _api;

  PollStarRepository() {
    _api = getIt.get<PollStarApi>();
  }

  Future<ApiResponse?> requestOtp({required String phone}) async {
    try {
      final response = await _api.requestOTP(phone);
      if (response.statusCode == HttpStatus.ok) {
        ApiResponse data = ApiResponse.fromJson(response.data);
        return data;
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

  Future<User?> getUserInfo({required String session}) async {
    try {
      final response = await _api.getUserInfo(session);
      if (response.statusCode == HttpStatus.ok) {
        User data = User.fromJson(response.data);
        return data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<ApiResponse?> logoutUser({required String id}) async {
    try {
      final response = await _api.logoutUser(id);
      if (response.statusCode == HttpStatus.ok) {
        ApiResponse data = ApiResponse.fromJson(response.data);
        return data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<ApiResponse?> updateFcmToken(
      {required String id, required String token}) async {
    try {
      final response = await _api.updateFcmToken(id, token);
      if (response.statusCode == HttpStatus.ok) {
        ApiResponse data = ApiResponse.fromJson(response.data);
        return data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<Question>?> getInboxQuestions(
      {required String session,
      required String state,
      required String last}) async {
    try {
      final response = await _api.getInboxQuestions(session, state, last);
      if (response.statusCode == HttpStatus.ok) {
        if (response.data["state"] == 1) {
          var data = response.data["updates"] as List;
          //var data = await rootBundle.loadString('assets/after.json') as List;

          return data.map((e) => Question.fromJson(e)).toList();
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<Question>?> getOutQuestions(
      {required String session,
      required String state,
      required String last}) async {
    try {
      final response = await _api.getOutboxQuestions(session, state, last);
      if (response.statusCode == HttpStatus.ok) {
        if (response.data["state"] == 1) {
          var data = response.data["updates"] as List;
          return data.map((e) => Question.fromJson(e)).toList();
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<ApiResponse?> reportProblem(
      {required String userId,
      required String stateId,
      required String type,
      required String message}) async {
    try {
      final response = await _api.reportProblem(userId, stateId, type, message);
      if (response.statusCode == HttpStatus.ok) {
        ApiResponse data = ApiResponse.fromJson(response.data);
        return data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
