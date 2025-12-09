import 'dart:convert';
import 'package:cognitive_quiz/API_Services/app_url.dart';
import 'package:cognitive_quiz/utills/app_consultant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:quiz/utils/app_consultant.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'app_url.dart';

class APIClient {
  Dio _dio = Dio();

  APIClient() {
    BaseOptions baseOptions = BaseOptions(
      receiveTimeout: const Duration(seconds: 50),
      connectTimeout: const Duration(seconds: 50),
      baseUrl: AppUrl.baseUrl,
      maxRedirects: 2,
    );
    _dio = Dio(baseOptions);

    if (kDebugMode) {
      print("**** Base URL: ${baseOptions.baseUrl}");
    }

    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        error: true,
        request: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
      ),
    );
  }

  /// ✅ Fetch token from SharedPreferences dynamically
  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstant.saveUserToken) ?? '';
  }

  /// ✅ GET request with updated token
  Future<Response> get({
    required String url,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final token = await _getToken();
      final response = await _dio.get(
        url,
        options: Options(
          responseType: ResponseType.json,
          headers: {'token': token, ...?headers},
        ),
      );
      return response;
    } on DioException catch (error) {
      if (kDebugMode) {
        print("Error in GET request: ${error.message}");
        print("Request URL: ${error.requestOptions.uri}");
      }
      rethrow;
    }
  }

  /// ✅ POST request with updated token
  Future<Response> post({
    required String url,
    dynamic params,
    Map<String, dynamic>? headers,
    String? baseUrl,
  }) async {
    try {
      final token = await _getToken();

      // Construct full URL safely
      String classBaseUrl = baseUrl ?? AppUrl.baseUrl;
      String fullUrl;
      if (classBaseUrl.isNotEmpty) {
        fullUrl =
            classBaseUrl.endsWith('/')
                ? '$classBaseUrl${url.startsWith('/') ? url.substring(1) : url}'
                : '$classBaseUrl/${url.startsWith('/') ? url.substring(1) : url}';
      } else if (url.startsWith('http://') || url.startsWith('https://')) {
        fullUrl = url;
      } else {
        fullUrl = url;
      }

      final mergedHeaders = {
        'X-API-KEY':
            '4Iuw5gfYUrRwOPY8ZYh1aC2zxiBOOntaxkhlMgpNyE78Ebj7YBFjU13YJhBRBWBu',
        'token': token,
        'Content-Type': 'application/json',
        ...?headers,
      };

      final response = await _dio.post(
        fullUrl,
        data: params,
        options: Options(
          responseType: ResponseType.json,
          headers: mergedHeaders,
        ),
      );

      if (kDebugMode) {
        print("Full request URL: ${response.requestOptions.uri}");
      }

      return response;
    } on DioException catch (error) {
      if (kDebugMode) {
        print("Error in POST request: ${error.message}");
        print("Request URL: ${error.requestOptions.uri}");
        if (error.response != null) {
          print("Response data: ${error.response?.data}");
        }
      }

      int statusCode = error.response?.statusCode ?? 0;
      dynamic data = error.response?.data;

      return Response(
        requestOptions: error.requestOptions,
        statusCode: statusCode,
        data: {
          'message':
              data is Map
                  ? data['message'] ?? 'Something went wrong'
                  : 'Something went wrong',
        },
      );
    } catch (e) {
      debugPrint('Unexpected error: $e');
      rethrow;
    }
  }
}
