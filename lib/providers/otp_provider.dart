import 'package:cognitive_quiz/API_Services/repo.dart';
import 'package:cognitive_quiz/models/otp_model.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class OtpProvider with ChangeNotifier {
  final ApiService apiClient = ApiService();

  OtpResponse? otpResponse;
  bool isLoading = false;
  String? errorMessage;

  //   Future<void> verifyOtp(String otp) async {
  //     isLoading = true;
  //     errorMessage = null;
  //     notifyListeners();

  //     try {
  //       Response response = await apiClient.VerifyOtp(
  //         params: {"otp": otp}, // ✅ Only params needed
  //       );

  //       if (response.statusCode == 200) {
  //         otpResponse = OtpResponse.fromJson(response.data);
  //       } else {
  //         errorMessage = "Something went wrong";
  //       }
  //     } catch (e) {
  //       errorMessage = e.toString();
  //     }

  //     isLoading = false;
  //     notifyListeners();
  //   }
  // }

  Future<void> verifyOtp(String otp, String email) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      Response response = await apiClient.VerifyOtp(
        params: {
          "otp": otp,
          "email": email, // ✅ added email field
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        otpResponse = OtpResponse.fromJson(response.data);
      } else {
        errorMessage =
            "Error ${response.statusCode}: ${response.data.toString()}";
      }
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
