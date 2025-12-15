// lib/providers/register_provider.dart
import 'package:cognitive_quiz/API_Services/repo.dart';
import 'package:cognitive_quiz/models/register_model.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class RegisterProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  RegisterModel? _registerModel;
  RegisterModel? get registerModel => _registerModel;

  Future<bool> registerUser({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final Response response = await _apiService.register(
        params: {"email": email, "password": password},
      );

      // ✅ Check statusCode
      if (response.statusCode == 200 || response.statusCode == 201) {
        _registerModel = RegisterModel.fromJson(response.data);

        _isLoading = false;
        notifyListeners();

        return true; // success
      } else {
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      debugPrint("Register Error: $e");
      return false;
    }
  }
}
