// lib/models/register_model.dart
class RegisterModel {
  final bool success;
  final String message;
  final User? user;

  RegisterModel({required this.success, required this.message, this.user});

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      success: json['success'] ?? false,
      message: json['message'] ?? "",
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}

class User {
  final int id;
  final String email;
  final String password;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'] ?? "",
      password: json['password'] ?? "",
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
    );
  }
}
