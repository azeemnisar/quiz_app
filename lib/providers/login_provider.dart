import 'package:cognitive_quiz/models/login_model.dart';
import 'package:cognitive_quiz/utills/app_consultant.dart';
import 'package:cognitive_quiz/utills/colors.dart';
import 'package:cognitive_quiz/views/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../api_Services/repo.dart';

class LoginProvider with ChangeNotifier {
  bool _isLoading = false;
  LoginResponse? _loginResponse;

  bool get isLoading => _isLoading;
  LoginResponse? get loginResponse => _loginResponse;

  final ApiService _apiService = ApiService();

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.login(
        params: {"email": email, "password": password},
      );

      // ✅ Only handle 200 or 201 as success
      if (response.statusCode == 200 || response.statusCode == 201) {
        _loginResponse = LoginResponse.fromJson(response.data);

        // Optionally save token
        // await AppConstant.setUserToken(_loginResponse!.token);

        Get.snackbar(
          "Success",
          "Login Successful!",
          colorText: AppColors.black,
          backgroundColor: AppColors.transparent,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        // ❌ Handle API error responses (non-200)
        _handleError(response.data);
      }
    } on DioException catch (e) {
      // ✅ Handle network/server/validation errors
      final data = e.response?.data;

      if (data != null && data is Map<String, dynamic>) {
        _handleError(data);
      } else {
        Get.snackbar(
          "Error",
          "Unable to connect. Please try again later.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.transparent,
          colorText: AppColors.black,
        );
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ✅ Single unified error handler
  void _handleError(Map<String, dynamic> data) {
    String errorMessage = "Unknown error occurred";

    if (data.containsKey('message')) {
      errorMessage = data['message'].toString();
    } else if (data.containsKey('error')) {
      final error = data['error'];
      if (error is Map<String, dynamic>) {
        final firstKey = error.keys.first;
        final firstMessage = error[firstKey];
        if (firstMessage is List && firstMessage.isNotEmpty) {
          errorMessage = firstMessage.first;
        } else if (firstMessage is String) {
          errorMessage = firstMessage;
        }
      }
    }

    // ✅ Show only once
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        "Login Failed",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.transparent,
        colorText: AppColors.black,
      );
    }
  }

  // Future<void> logout() async {
  //   await AppConstant.clearUserToken();
  //   _loginResponse = null;
  //   notifyListeners();

  //   Get.offAll(() => Login());
  // }

  Future<void> logout() async {
    // 1️⃣ Clear saved token (so user is logged out)
    await AppConstant.clearUserToken();

    // 2️⃣ Clear stored login response
    _loginResponse = null;
    notifyListeners();

    // 3️⃣ Clear old profile data
    try {
      Provider.of<ProfileProvider>(Get.context!, listen: false).clearProfile();
    } catch (e) {
      debugPrint("⚠️ ProfileProvider not found: $e");
    }

    // 4️⃣ Navigate to login page
    Get.offAll(() => Login());
  }
}
