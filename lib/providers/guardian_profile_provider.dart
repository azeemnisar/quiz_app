import 'package:cognitive_quiz/API_Services/repo.dart';
import 'package:cognitive_quiz/models/guardian_profile_model.dart';
import 'package:flutter/foundation.dart';
// import 'package:quiz/api_Services/repo.dart';
// import 'package:quiz/model/guardian_profile_model.dart';

class GuardianProvider with ChangeNotifier {
  final ApiService apiService = ApiService();

  bool isLoading = false;
  GuardianProfile? guardianProfile;

  Future<void> saveGuardianDetails({
    required String fatherName,
    required String contactNumber,
    required String emergencyContact,
    required String remarks,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await apiService.addGuardianDetails(
        fatherName: fatherName,
        contactNumber: contactNumber,
        emergencyContact: emergencyContact,
        remarks: remarks,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        guardianProfile = GuardianProfile.fromJson(data['GuardianProfile']);
      } else if (response.statusCode == 422) {
        final data = response.data;
        debugPrint("Error message is: $data");
      }
    } catch (e) {
      debugPrint("❌ Guardian save error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
