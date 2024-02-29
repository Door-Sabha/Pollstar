import 'package:dio/dio.dart';
import 'package:pollstar/data/network/dio_client.dart';
import 'package:pollstar/utils/strings.dart';

import '../api_constants.dart';

class PollStarApi {
  final DioClient dioClient;
  PollStarApi(this.dioClient);

  Future<Response> requestOTP(String phone) async {
    var data = {
      "phone": phone,
    };

    try {
      final Response response = await dioClient.post(
        APIConstants.requestOtp,
        data: data,
      );
      return response;
    } catch (e) {
      return Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 401,
          statusMessage: AppStrings.errorApiUnknown);
    }
  }

  Future<Response> validateOTP(String phone, String otp) async {
    var data = {
      "phone": phone,
      "otp": otp,
    };

    try {
      final Response response = await dioClient.post(
        APIConstants.validateOtp,
        data: data,
      );
      return response;
    } catch (e) {
      return Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 401,
          statusMessage: AppStrings.errorApiUnknown);
    }
  }

  Future<Response> getQuestions(String phone, String datetime) async {
    var data = {
      "phone": phone,
      "last": datetime,
    };

    try {
      final Response response = await dioClient.post(
        APIConstants.questionList,
        data: data,
      );
      return response;
    } catch (e) {
      return Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 401,
          statusMessage: AppStrings.errorApiUnknown);
    }
  }

  Future<Response> updateAnswer(String phone, String sNo, String answer) async {
    var data = {
      "phone": phone,
      "s_no": sNo,
      "answer": answer,
    };

    try {
      final Response response = await dioClient.post(
        APIConstants.updateAnswer,
        data: data,
      );
      return response;
    } catch (e) {
      return Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 401,
          statusMessage: AppStrings.errorApiUnknown);
    }
  }

  Future<Response> updateFcmToken(String id, String token) async {
    var data = {
      "id": id,
      "fcm": token,
    };

    try {
      final Response response = await dioClient.post(
        APIConstants.updateUser,
        data: data,
      );
      return response;
    } catch (e) {
      return Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 401,
          statusMessage: AppStrings.errorApiUnknown);
    }
  }
}
