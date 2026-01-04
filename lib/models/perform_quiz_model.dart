class QuizResult {
  final int id;
  final int userId;
  final int quizId;
  final String score;
  final String aiFeedback;
  final String detailedAnalysis;
  final String quizStatus;
  final String quizMarks;
  final String quizPercentage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final QuizUser user;
  final QuizInfo quiz;

  QuizResult({
    required this.id,
    required this.userId,
    required this.quizId,
    required this.score,
    required this.aiFeedback,
    required this.detailedAnalysis,
    required this.quizStatus,
    required this.quizMarks,
    required this.quizPercentage,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.quiz,
  });

  // factory QuizResult.fromJson(Map<String, dynamic> json) {
  //   return QuizResult(
  //     id: json['id'] ?? 0,
  //     userId: json['user_id'] ?? 0,
  //     quizId: json['quiz_id'] ?? 0,
  //     score: json['score']?.toString() ?? '',
  //     aiFeedback: json['ai_feedback'] ?? '',
  //     detailedAnalysis: json['detailed_analysis'] ?? '',
  //     quizStatus: json['quiz_status'] ?? '',
  //     quizMarks: json['quiz_marks'] ?? '',
  //     quizPercentage: json['quiz_percentage']?.toString() ?? '',
  //     createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
  //     updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
  //     user: QuizUser.fromJson(json['user'] ?? {}),
  //     quiz: QuizInfo.fromJson(json['quiz'] ?? {}),
  //   );
  // }

  factory QuizResult.fromJson(Map<String, dynamic> json) {
    return QuizResult(
      id: int.tryParse(json['id'].toString()) ?? 0,
      userId: int.tryParse(json['user_id'].toString()) ?? 0,
      quizId: int.tryParse(json['quiz_id'].toString()) ?? 0,
      score: json['score']?.toString() ?? '',
      aiFeedback: json['ai_feedback'] ?? '',
      detailedAnalysis: json['detailed_analysis'] ?? '',
      quizStatus: json['quiz_status'] ?? '',
      quizMarks: json['quiz_marks']?.toString() ?? '',
      quizPercentage: json['quiz_percentage']?.toString() ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      user: QuizUser.fromJson(json['user'] ?? {}),
      quiz: QuizInfo.fromJson(json['quiz'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "quiz_id": quizId,
      "score": score,
      "ai_feedback": aiFeedback,
      "detailed_analysis": detailedAnalysis,
      "quiz_status": quizStatus,
      "quiz_marks": quizMarks,
      "quiz_percentage": quizPercentage,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
      "user": user.toJson(),
      "quiz": quiz.toJson(),
    };
  }

  static List<QuizResult> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => QuizResult.fromJson(json)).toList();
  }
}

class QuizUser {
  final int id;
  final String email;
  final String? password;
  final String? otp;
  final String? token;
  final int? isVerified;
  final int? otpIsVerified;
  final String? latitude;
  final String? longitude;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  QuizUser({
    required this.id,
    required this.email,
    this.password,
    this.otp,
    this.token,
    this.isVerified,
    this.otpIsVerified,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
  });

  factory QuizUser.fromJson(Map<String, dynamic> json) {
    return QuizUser(
      id: int.tryParse(json['id'].toString()) ?? 0,
      email: json['email'] ?? '',
      password: json['password'],
      otp: json['otp'],
      token: json['token'],
      isVerified:
          json['is_verified'] == null
              ? null
              : int.tryParse(json['is_verified'].toString()),
      otpIsVerified:
          json['otp_is_verified'] == null
              ? null
              : int.tryParse(json['otp_is_verified'].toString()),
      latitude: json['latitude']?.toString(),
      longitude: json['longitude']?.toString(),
      createdAt: DateTime.tryParse(json['created_at'] ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "password": password,
      "otp": otp,
      "token": token,
      "is_verified": isVerified,
      "otp_is_verified": otpIsVerified,
      "latitude": latitude,
      "longitude": longitude,
      "created_at": createdAt?.toIso8601String(),
      "updated_at": updatedAt?.toIso8601String(),
    };
  }
}

class QuizInfo {
  final int id;
  final String title;
  final String hashid;

  QuizInfo({required this.id, required this.title, required this.hashid});

  // factory QuizInfo.fromJson(Map<String, dynamic> json) {
  //   return QuizInfo(
  //     id: json['id'] ?? 0,
  //     title: json['title'] ?? '',
  //     hashid: json['hashid'] ?? '',
  //   );
  // }

  factory QuizInfo.fromJson(Map<String, dynamic> json) {
    return QuizInfo(
      id: int.tryParse(json['id'].toString()) ?? 0,
      title: json['title'] ?? '',
      hashid: json['hashid'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "title": title, "hashid": hashid};
  }
}
