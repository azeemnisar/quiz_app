import 'package:cognitive_quiz/API_Services/repo.dart';
import 'package:cognitive_quiz/models/gender_model.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';


class GenderProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool _isLoading = false;
  String? _errorMessage;
  ProfileModel? _profile;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  ProfileModel? get profile => _profile;

  Future<void> addGender(String gender) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      Response response = await _apiService.addgender(gender: gender);

      if (response.statusCode == 200 || response.data == 201) {
        final data = response.data;

        if (data['success'] == true) {
          _profile = ProfileModel.fromJson(data['profile']);
        } else {
          _errorMessage = data['message'] ?? "Something went wrong";
        }
      } else {
        _errorMessage = "Server error: ${response.statusCode}";
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}