import 'dart:io';
import 'package:cognitive_quiz/API_Services/repo.dart';
import 'package:cognitive_quiz/models/age_model.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class ProfileImageProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool _isLoading = false;
  String? _errorMessage;
  ProfileResponse? _profile;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  ProfileResponse? get profile => _profile;

  /// Upload profile image
  Future<void> addImage(String imagePath) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Convert file path to MultipartFile
      File file = File(imagePath);
      String fileName = file.path.split('/').last;

      FormData formData = FormData.fromMap({
        's_image': await MultipartFile.fromFile(
          file.path,
          filename: fileName,
          contentType: MediaType(
            "image",
            fileName.split('.').last,
          ), // jpg/png/jpeg
        ),
      });

      // Call your API method
      Response response = await _apiService.addimage(image: formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        _profile = ProfileResponse.fromJson(response.data);
      } else {
        _errorMessage = "Failed to upload image: ${response.data}";
      }
    } catch (e) {
      _errorMessage = "Error: $e";
      print("Add Image Provider Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
