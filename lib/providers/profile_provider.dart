import 'package:cognitive_quiz/API_Services/repo.dart';
import 'package:cognitive_quiz/models/profile_model.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

class ProfileProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool _isLoading = false;
  String? _errorMessage;
  Profile? _profile;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Profile? get profile => _profile;

  /// Fetch Profile API
  // Future<void> fetchProfile({Map<String, dynamic>? params}) async {
  //   _isLoading = true;
  //   _errorMessage = null;
  //   notifyListeners();

  //   try {
  //     Response response = await _apiService.getprofile(params);

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final data = response.data;

  //       // If API directly returns profile JSON
  //       _profile = Profile.fromJson(data);

  //       // If API wraps response like {"success":true,"profile":{...}}
  //       // _profile = Profile.fromJson(data["profile"]);

  //       debugPrint("✅ Profile fetched successfully");
  //     } else {
  //       _errorMessage = "Failed to load profile: ${response.statusCode}";
  //       debugPrint("⚠️ $_errorMessage");
  //     }
  //   } catch (e) {
  //     _errorMessage = "Error fetching profile: $e";
  //     debugPrint("❌ $_errorMessage");
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  // Future<void> fetchProfile({Map<String, dynamic>? params}) async {
  //   _isLoading = true;
  //   _errorMessage = null;
  //   notifyListeners();

  //   try {
  //     Response response = await _apiService.getprofile(params);

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final data = response.data;

  //       // ✅ FIXED: your API wraps the profile inside "profile"
  //       if (data != null && data["profile"] != null) {
  //         _profile = Profile.fromJson(data["profile"]);
  //         debugPrint("✅ Profile fetched: ${_profile?.studentName}");
  //       } else {
  //         _errorMessage = "Profile data missing in response";
  //         debugPrint("⚠️ No 'profile' key found in response");
  //       }
  //     } else {
  //       _errorMessage = "Failed to load profile: ${response.statusCode}";
  //       debugPrint("⚠️ $_errorMessage");
  //     }
  //   } catch (e) {
  //     _errorMessage = "Error fetching profile: $e";
  //     debugPrint("❌ $_errorMessage");
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  Future<void> fetchProfile({Map<String, dynamic>? params}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.getprofile(params);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        if (data != null && data["profile"] != null) {
          _profile = Profile.fromJson(data["profile"]);
          debugPrint("✅ Profile fetched: ${_profile?.studentName}");
        } else {
          _errorMessage = "Profile data missing in response";
        }
      } else if (response.statusCode == 404) {
        // ✅ Handle 404 specifically
        final data = response.data;
        if (data != null && data["error"] != null) {
          _errorMessage = data["error"]; // e.g. "Record Nout Found"
        } else {
          _errorMessage = "Profile not found. Please create one.";
        }
        debugPrint("⚠️ Profile not found (404)");
      } else {
        _errorMessage = "Failed to load profile: ${response.statusCode}";
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        _errorMessage = "Profile not found. Please create one.";
        debugPrint("⚠️ 404 - No profile exists for this user");
      } else {
        _errorMessage = "Network error: ${e.message}";
        debugPrint("❌ Dio error: ${e.message}");
      }
    } catch (e) {
      _errorMessage = "Unexpected error: $e";
      debugPrint("❌ Unexpected error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Refresh profile manually
  Future<void> refreshProfile() async {
    await fetchProfile();
  }

  /// Clear profile data (e.g., on logout)
  void clearProfile() {
    _profile = null;
    notifyListeners();
  }
}
