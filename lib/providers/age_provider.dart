import 'package:cognitive_quiz/API_Services/repo.dart';
import 'package:cognitive_quiz/models/age_model.dart';
import 'package:cognitive_quiz/models/get_age_model.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
// import 'package:quiz/api_Services/repo.dart'; // your ApiService import
// import 'package:quiz/model/age_model.dart';
// import 'package:quiz/model/get_age_model.dart'; // Profile & RangeModel

class AgeProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  // State variables
  bool isLoading = false;
  String? errorMessage;

  Profile? profile; // For addAge
  List<RangeModel> ageRanges = []; // For fetchAgeRanges

  /// Add or update age
  Future<void> addAge({required String age}) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.addage(age: age);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        profile = Profile.fromJson(data['profile']);
        debugPrint("✅ Age updated successfully");
      } else {
        errorMessage = "Failed to update age: ${response.data}";
        debugPrint("⚠️ $errorMessage");
      }
    } on DioException catch (e) {
      errorMessage = "DioException: ${e.message}";
      debugPrint("❌ $errorMessage");
    } catch (e) {
      errorMessage = "Error: $e";
      debugPrint("❌ $errorMessage");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Fetch age ranges from API
  Future<void> fetchAgeRanges({Map<String, dynamic>? params}) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      Response response = await _apiService.getage(params);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data as List<dynamic>;
        ageRanges = data.map((json) => RangeModel.fromJson(json)).toList();
        debugPrint("✅ Age ranges fetched: ${ageRanges.length}");
      } else {
        errorMessage = "Failed to load age ranges: ${response.statusCode}";
      }
    } on DioException catch (e) {
      errorMessage = "DioException: ${e.message}";
      debugPrint("❌ $errorMessage");
    } catch (e) {
      errorMessage = "Error: $e";
      debugPrint("❌ $errorMessage");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
