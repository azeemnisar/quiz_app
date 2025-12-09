import 'package:cognitive_quiz/utills/app_consultant.dart';
import 'package:dio/dio.dart';
import 'app_url.dart';
import 'api_services.dart';

class ApiService {
  final APIClient apiClient = APIClient();

  static const String _baseUrl = AppUrl.baseUrl;

  static const String _apiKey =
      '4Iuw5gfYUrRwOPY8ZYh1aC2zxiBOOntaxkhlMgpNyE78Ebj7YBFjU13YJhBRBWBu';

  Map<String, String> get _defaultHeaders => {
    'X-API-KEY': _apiKey,
    'token': AppConstant.getUserToken ?? 'NIKVAXVKR-07242', // Fallback token
    'Content-Type': 'application/json',
  };

  Future<Response> login({var params}) async {
    try {
      final response = await apiClient.post(
        url: AppUrl.login,
        params: params,
        baseUrl: _baseUrl,
        headers: {'X-API-KEY': _apiKey},
      );

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data != null) {
        final token = response.data['token'] ?? '';
        final email = params['email'];
        final password = params['password'];

        if (token.isNotEmpty) {
          await AppConstant.saveUserCredentials(
            Authorization: token,
            apiKey:
                '4Iuw5gfYUrRwOPY8ZYh1aC2zxiBOOntaxkhlMgpNyE78Ebj7YBFjU13YJhBRBWBu', // ✅ added
            email: email,
            password: password,
          );
        }
      }

      return response;
    } catch (e) {
      print('Login error: $e');
      rethrow;
    }
  }

  Future<Response> register({var params}) async {
    try {
      return await apiClient.post(
        url: AppUrl.register,
        params: params,
        baseUrl: _baseUrl,
        headers: {
          'Content-Type': 'application/json', // 👈 only this for signup
        },
      );
    } catch (e) {
      print('Register error: $e');
      rethrow;
    }
  }

  Future<Response> VerifyOtp({var params}) async {
    try {
      return await apiClient.post(
        url: AppUrl.verifyOtp,
        params: params,
        baseUrl: _baseUrl,
        headers: {'key': _apiKey},
      );
    } catch (e) {
      print('Verify OTP error: $e');
      rethrow;
    }
  }

  Future<Response> forgetotp({var params}) async {
    try {
      return await apiClient.post(
        url: AppUrl.forgetotp,
        params: params,
        baseUrl: _baseUrl,
        headers: {
          'Content-Type': 'application/json', // 👈 only this for signup
        },
      );
    } catch (e) {
      print('forget Email error: $e');
      rethrow;
    }
  }

  Future<Response> forgetverifyotp({var params}) async {
    try {
      return await apiClient.post(
        url: AppUrl.verify_forget_otp,
        params: params,
        baseUrl: _baseUrl,
        headers: {
          'Content-Type': 'application/json', // 👈 only this for signup
        },
      );
    } catch (e) {
      print('forget otp error: $e');
      rethrow;
    }
  }

  Future<Response> forgetpasswordupdate({var params}) async {
    try {
      return await apiClient.post(
        url: AppUrl.forget_password_update,
        params: params,
        baseUrl: _baseUrl,
        headers: {
          'Content-Type': 'application/json', // 👈 only this for signup
        },
      );
    } catch (e) {
      print('forget password update error: $e');
      rethrow;
    }
  }

  Future<Response> getVideos(var params) async {
    try {
      return await apiClient.get(
        url: AppUrl.getVideos, // ✅ correct endpoint
        headers: {
          'X-API-KEY': _apiKey,
          'Accept': "application/json",
          'Authorization': 'Bearer ${AppConstant.getUserToken}',
        },
      );
    } catch (e) {
      print('Get Videos error: $e');
      rethrow;
    }
  }

  Future<Response> ResendOtp({var params}) async {
    try {
      return await apiClient.post(
        url: AppUrl.resendotp,
        params: params,
        baseUrl: _baseUrl,
        headers: {'key': _apiKey},
      );
    } catch (e) {
      print('Resend OTP error: $e');
      rethrow;
    }
  }

  Future<Response> getCategories() async {
    try {
      return await apiClient.get(
        url: AppUrl.getCategories, // ✅ make sure endpoint is correct
        headers: {
          'X-API-KEY': _apiKey,
          'Accept': "application/json",
          'Authorization': 'Bearer ${AppConstant.getUserToken}',
        },
      );
    } catch (e) {
      print('Get Categories error: $e');
      rethrow;
    }
  }

  Future<Response> getCategoriesByHashid(String hashid) async {
    try {
      return await apiClient.get(
        url: "${AppUrl.sub_category}/$hashid", // ✅ Correct interpolation
        headers: {
          'X-API-KEY': _apiKey,
          'Accept': "application/json",
          'Authorization': 'Bearer ${AppConstant.getUserToken}',
        },
      );
    } catch (e) {
      print('Get Sub Categories error: $e');
      rethrow;
    }
  }

  Future<Response> addGuardianDetails({
    required String fatherName,
    required String contactNumber,
    required String emergencyContact,
    required String remarks,
  }) async {
    final formData = FormData.fromMap({
      'f_father_name': fatherName,
      'f_contact_number': contactNumber,
      'f_emergency_contact': emergencyContact,
      'f_remarks': remarks,
    });
    try {
      return await apiClient.post(
        url: AppUrl.add_guardiandetails,
        params: formData,
        headers: {
          'X-API-KEY': _apiKey,
          'Accept': "application/json",
          'Authorization': 'Bearer ${AppConstant.getUserToken}',
        },
      );
    } catch (e) {
      print('Add Guardian Details error: $e');
      rethrow;
    }
  }

  Future<Response> addbasicinfo({
    required String name,
    required String address,
    required String zipcode,
    required String about,
  }) async {
    final formData = FormData.fromMap({
      's_name': name,
      's_address': address,
      's_zipcode': zipcode,
      's_about_youself': about,
    });
    try {
      return await apiClient.post(
        url: AppUrl.add_basicinfo,
        params: formData,
        headers: {
          'X-API-KEY': _apiKey,
          'Accept': "application/json",
          'Authorization': 'Bearer ${AppConstant.getUserToken}',
        },
      );
    } catch (e) {
      print('Add basic information error: $e');
      rethrow;
    }
  }

  Future<Response> addgender({required String gender}) async {
    final formData = FormData.fromMap({'s_gender': gender});
    try {
      return await apiClient.post(
        url: AppUrl.add_gender,
        params: formData,
        headers: {
          'X-API-KEY': _apiKey,
          'Accept': "application/json",
          'Authorization': 'Bearer ${AppConstant.getUserToken}',
        },
      );
    } catch (e) {
      print('Gender Details error: $e');
      rethrow;
    }
  }

  Future<Response> getage(var params) async {
    try {
      return await apiClient.get(
        url: AppUrl.get_user_age, // ✅ correct endpoint
        headers: {
          'X-API-KEY': _apiKey,
          'Accept': "application/json",
          'Authorization': 'Bearer ${AppConstant.getUserToken}',
        },
      );
    } catch (e) {
      print('Get age error: $e');
      rethrow;
    }
  }

  Future<Response> addage({required String age}) async {
    final formData = FormData.fromMap({'s_age': age});
    try {
      return await apiClient.post(
        url: AppUrl.add_age,
        params: formData,
        headers: {
          'X-API-KEY': _apiKey,
          'Accept': "application/json",
          'Authorization': 'Bearer ${AppConstant.getUserToken}',
        },
      );
    } catch (e) {
      print('Age Details error: $e');
      rethrow;
    }
  }

  Future<Response> addimage({required FormData image}) async {
    try {
      return await apiClient.post(
        url: AppUrl.add_image,
        params: image, // now passing FormData
        headers: {
          'X-API-KEY': _apiKey,
          'Accept': "application/json",
          'Authorization': 'Bearer ${AppConstant.getUserToken}',
        },
      );
    } catch (e) {
      print('Image Details error: $e');
      rethrow;
    }
  }

  Future<Response> getprofile(var params) async {
    try {
      return await apiClient.get(
        url: AppUrl.get_profile, // ✅ correct endpoint
        headers: {
          'X-API-KEY': _apiKey,
          'Accept': "application/json",
          'Authorization': 'Bearer ${AppConstant.getUserToken}',
        },
      );
    } catch (e) {
      print('Get profile error: $e');
      rethrow;
    }
  }

  Future<Response> updateprofile({
    required String emergency_contact,
    required String gender,
    required String age,
    required String level,
  }) async {
    final formData = FormData.fromMap({
      'f_emergency_contact': emergency_contact,
      's_gender': gender,
      's_age': age,
      's_level': level,
    });
    try {
      return await apiClient.post(
        url: AppUrl.update_profile,
        params: formData,
        headers: {
          'X-API-KEY': _apiKey,
          'Accept': "application/json",
          'Authorization': 'Bearer ${AppConstant.getUserToken}',
        },
      );
    } catch (e) {
      print('Update Profile error: $e');
      rethrow;
    }
  }

  Future<Response> showallquizzes(var params) async {
    try {
      return await apiClient.get(
        url: AppUrl.show_all_quiz, // ✅ correct endpoint
        headers: {
          'X-API-KEY': _apiKey,
          'Accept': "application/json",
          'Authorization': 'Bearer ${AppConstant.getUserToken}',
        },
      );
    } catch (e) {
      print('Get Quizzes show error: $e');
      rethrow;
    }
  }

  Future<Response> showperformquiz(var params) async {
    try {
      return await apiClient.get(
        url: AppUrl.get_perform_quiz, // ✅ correct endpoint
        headers: {
          'X-API-KEY': _apiKey,
          'Accept': "application/json",
          'Authorization': 'Bearer ${AppConstant.getUserToken}',
        },
      );
    } catch (e) {
      print('Get Perform quiz error: $e');
      rethrow;
    }
  }

  Future<Response> getcategoryquiz(String hashid) async {
    try {
      return await apiClient.get(
        url: "${AppUrl.get_category_quiz}/$hashid", // ✅ Correct interpolation
        headers: {
          'X-API-KEY': _apiKey,
          'Accept': "application/json",
          'Authorization': 'Bearer ${AppConstant.getUserToken}',
        },
      );
    } catch (e) {
      print('Get Categories of Quiz error: $e');
      rethrow;
    }
  }

  Future<Response> showlevel(var params) async {
    try {
      return await apiClient.get(
        url: AppUrl.getlevel, // ✅ correct endpoint
        headers: {
          'X-API-KEY': _apiKey,
          'Accept': "application/json",
          'Authorization': 'Bearer ${AppConstant.getUserToken}',
        },
      );
    } catch (e) {
      print('Get level show error: $e');
      rethrow;
    }
  }

  Future<Response> addlevel({required String level}) async {
    final formData = FormData.fromMap({'s_level': level});
    try {
      return await apiClient.post(
        url: AppUrl.add_level,
        params: formData,
        headers: {
          'X-API-KEY': _apiKey,
          'Accept': "application/json",
          'Authorization': 'Bearer ${AppConstant.getUserToken}',
        },
      );
    } catch (e) {
      print('Add Level error: $e');
      rethrow;
    }
  }

  Future<Response> getquestions(String hashid) async {
    try {
      return await apiClient.get(
        url: "${AppUrl.get_questions}/$hashid", // ✅ Correct interpolation
        headers: {
          'X-API-KEY': _apiKey,
          'Accept': "application/json",
          'Authorization': 'Bearer ${AppConstant.getUserToken}',
        },
      );
    } on DioException catch (e) {
      print('Get Questions error: $e');
      rethrow;
    }
  }

  Future<Response> postQuestions({required Map<String, dynamic> params}) async {
    try {
      return await apiClient.post(
        url: AppUrl.post_question,
        params: params, // 👈 Don't encode
        baseUrl: _baseUrl,
        headers: {
          'X-API-KEY': _apiKey,
          'Accept': "application/json",
          'Authorization':
              'Bearer ${AppConstant.getUserToken}', // ensure token exists
        },
      );
    } catch (e) {
      print('❌ Post Questions error: $e');
      rethrow;
    }
  }

  Future<Response> messaging({required String content}) async {
    final formData = FormData.fromMap({'content': content});
    try {
      return await apiClient.post(
        url: AppUrl.mesasging,
        params: formData,
        headers: {
          'X-API-KEY': _apiKey,
          'Accept': "application/json",
          'Authorization': 'Bearer ${AppConstant.getUserToken}',
        },
      );
    } catch (e) {
      print('Messages error: $e');
      rethrow;
    }
  }
}
