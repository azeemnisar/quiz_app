import 'package:cognitive_quiz/API_Services/repo.dart';
import 'package:cognitive_quiz/models/basicinfo_model.dart';
import 'package:flutter/foundation.dart';
import 'package:quiz/api_Services/repo.dart';
import 'package:quiz/model/basicinfo_model.dart';

class BasicInfoProvider with ChangeNotifier {
  final ApiService apiService = ApiService();

  bool isLoading = false;
  BasicInfoModel? basicInfoModel;

  /// Save Basic Info
  Future<void> saveBasicInfo({
    required String name,
    required String address,
    required String zipcode,
    required String about,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await apiService.addbasicinfo(
        name: name,
        address: address,
        zipcode: zipcode,
        about: about,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        basicInfoModel = BasicInfoModel.fromJson(data);

        debugPrint("✅ Basic Info Saved: ${basicInfoModel?.message}");
      } else if (response.statusCode == 422) {
        debugPrint("❌ Validation Error: ${response.data}");
      } else {
        debugPrint("❌ Failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("❌ Error saving basic info: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
