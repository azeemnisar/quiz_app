import 'package:cognitive_quiz/models/age_model.dart';
//import 'package:quiz/model/profile_mode.dart';

class ProfileUpdateResponse {
  final bool success;
  final String message;
  final Profile? profile;

  ProfileUpdateResponse({
    required this.success,
    required this.message,
    this.profile,
  });

  factory ProfileUpdateResponse.fromJson(Map<String, dynamic> json) {
    return ProfileUpdateResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      profile:
          json['profile'] != null ? Profile.fromJson(json['profile']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message": message,
      "profile": profile?.toJson(),
    };
  }
}
