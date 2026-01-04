class Profile {
  final int id;
  final String fatherName;
  final String contactNumber;
  final String emergencyContact;
  final String remarks;
  final String studentName;
  final String studentAddress;
  final String zipcode;
  final String aboutYourself;
  final String gender;
  final String age;
  final String level;
  final String image;
  final int createdBy;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final QuizLevel? quizLevel;
  final UserAge? userAge;

  Profile({
    required this.id,
    required this.fatherName,
    required this.contactNumber,
    required this.emergencyContact,
    required this.remarks,
    required this.studentName,
    required this.studentAddress,
    required this.zipcode,
    required this.aboutYourself,
    required this.gender,
    required this.age,
    required this.level,
    required this.image,
    required this.createdBy,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.quizLevel,
    this.userAge,
  });

  // factory Profile.fromJson(Map<String, dynamic> json) {
  //   return Profile(
  //     id: json['id'] ?? 0,
  //     fatherName: json['f_father_name'] ?? '',
  //     contactNumber: json['f_contact_number'] ?? '',
  //     emergencyContact: json['f_emergency_contact'] ?? '',
  //     remarks: json['f_remarks'] ?? '',
  //     studentName: json['s_name'] ?? '',
  //     studentAddress: json['s_address'] ?? '',
  //     zipcode: json['s_zipcode'] ?? '',
  //     aboutYourself: json['s_about_youself'] ?? '',
  //     gender: json['s_gender'] ?? '',
  //     age: json['s_age']?.toString() ?? '',
  //     level: json['s_level']?.toString() ?? '',
  //     image: json['s_image'] ?? '',
  //     createdBy: json['created_by'] ?? 0,
  //     status: json['status'] ?? 0,
  //     createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
  //     updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
  //     quizLevel:
  //         json['quiz_level'] != null
  //             ? QuizLevel.fromJson(json['quiz_level'])
  //             : null,
  //     userAge:
  //         json['user_age'] != null ? UserAge.fromJson(json['user_age']) : null,
  //   );
  // }

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: int.tryParse(json['id'].toString()) ?? 0,
      fatherName: json['f_father_name'] ?? '',
      contactNumber: json['f_contact_number'] ?? '',
      emergencyContact: json['f_emergency_contact'] ?? '',
      remarks: json['f_remarks'] ?? '',
      studentName: json['s_name'] ?? '',
      studentAddress: json['s_address'] ?? '',
      zipcode: json['s_zipcode'] ?? '',
      aboutYourself: json['s_about_youself'] ?? '',
      gender: json['s_gender'] ?? '',
      age: json['s_age']?.toString() ?? '',
      level: json['s_level']?.toString() ?? '',
      image: json['s_image'] ?? '',
      createdBy: int.tryParse(json['created_by'].toString()) ?? 0,
      status: int.tryParse(json['status'].toString()) ?? 0,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      quizLevel:
          json['quiz_level'] != null
              ? QuizLevel.fromJson(json['quiz_level'])
              : null,
      userAge:
          json['user_age'] != null ? UserAge.fromJson(json['user_age']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "f_father_name": fatherName,
      "f_contact_number": contactNumber,
      "f_emergency_contact": emergencyContact,
      "f_remarks": remarks,
      "s_name": studentName,
      "s_address": studentAddress,
      "s_zipcode": zipcode,
      "s_about_youself": aboutYourself,
      "s_gender": gender,
      "s_age": age,
      "s_level": level,
      "s_image": image,
      "created_by": createdBy,
      "status": status,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
      "quiz_level": quizLevel?.toJson(),
      "user_age": userAge?.toJson(),
    };
  }
}

class QuizLevel {
  final int id;
  final String name;

  QuizLevel({required this.id, required this.name});

  factory QuizLevel.fromJson(Map<String, dynamic> json) {
    return QuizLevel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name};
  }
}

class UserAge {
  final int id;
  final String range;

  UserAge({required this.id, required this.range});

  factory UserAge.fromJson(Map<String, dynamic> json) {
    return UserAge(
      id: int.tryParse(json['id'].toString()) ?? 0,
      range: json['range'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "range": range};
  }
}
