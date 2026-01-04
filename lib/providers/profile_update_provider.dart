import 'package:cognitive_quiz/API_Services/repo.dart';
import 'package:cognitive_quiz/models/profile_update_model.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

class ProfileUpdateProvider with ChangeNotifier {
  final ApiService apiService = ApiService();

  bool isLoading = false;
  ProfileUpdateResponse? profileResponse;
  String? errorMessage;

  /// 🔹 Update user profile API call
  Future<void> updateProfile({
    required String fEmergencyContact,
    required String sGender,
    required String sAge,
    required String sLevel,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      // 🔹 API call
      Response response = await apiService.updateprofile(
        emergency_contact: fEmergencyContact,
        gender: sGender,
        age: sAge,
        level: sLevel,
      );

      if (kDebugMode) {
        print("✅ Update Profile Response: ${response.data}");
      }

      // 🔹 Handle success
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        if (data is Map<String, dynamic>) {
          profileResponse = ProfileUpdateResponse.fromJson(data);
          errorMessage = null;
        } else if (data is Map) {
          profileResponse = ProfileUpdateResponse.fromJson(
            Map<String, dynamic>.from(data),
          );
          errorMessage = null;
        } else {
          errorMessage = "Invalid response format from server.";
          profileResponse = null;
        }
      } else {
        errorMessage = "Failed to update profile. ${response.statusMessage}";
        profileResponse = null;
      }
    } catch (e, stackTrace) {
      errorMessage = "Error updating profile: $e";
      profileResponse = null;
      if (kDebugMode) {
        print("❌ Exception during update profile: $e");
        print(stackTrace);
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
