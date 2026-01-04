class ProfileResponse {
  final bool success;
  final String message;
  final Profile profile;

  ProfileResponse({
    required this.success,
    required this.message,
    required this.profile,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      profile: Profile.fromJson(json['profile'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'profile': profile.toJson(),
    };
  }
}

class Profile {
  final int id;
  final String fFatherName;
  final String fContactNumber;
  final String fEmergencyContact;
  final String fRemarks;
  final String sName;
  final String sAddress;
  final String sZipcode;
  final String sAboutYourself;
  final String sGender;
  final String? sAge;
  final String? sLevel;
  final String? sImage;
  final int createdBy;
  final int status;
  final String createdAt;
  final String updatedAt;

  Profile({
    required this.id,
    required this.fFatherName,
    required this.fContactNumber,
    required this.fEmergencyContact,
    required this.fRemarks,
    required this.sName,
    required this.sAddress,
    required this.sZipcode,
    required this.sAboutYourself,
    required this.sGender,
    this.sAge,
    this.sLevel,
    this.sImage,
    required this.createdBy,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  // factory Profile.fromJson(Map<String, dynamic> json) {
  //   return Profile(
  //     id: json['id'] ?? 0,
  //     fFatherName: json['f_father_name'] ?? '',
  //     fContactNumber: json['f_contact_number'] ?? '',
  //     fEmergencyContact: json['f_emergency_contact'] ?? '',
  //     fRemarks: json['f_remarks'] ?? '',
  //     sName: json['s_name'] ?? '',
  //     sAddress: json['s_address'] ?? '',
  //     sZipcode: json['s_zipcode'] ?? '',
  //     sAboutYourself: json['s_about_youself'] ?? '',
  //     sGender: json['s_gender'] ?? '',
  //     sAge: json['s_age']?.toString(),
  //     sLevel: json['s_level']?.toString(),
  //     sImage: json['s_image'], // nullable
  //     createdBy: json['created_by'] ?? 0,
  //     status: json['status'] ?? 0,
  //     createdAt: json['created_at'] ?? '',
  //     updatedAt: json['updated_at'] ?? '',
  //   );
  // }
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: int.tryParse(json['id'].toString()) ?? 0,
      fFatherName: json['f_father_name'] ?? '',
      fContactNumber: json['f_contact_number'] ?? '',
      fEmergencyContact: json['f_emergency_contact'] ?? '',
      fRemarks: json['f_remarks'] ?? '',
      sName: json['s_name'] ?? '',
      sAddress: json['s_address'] ?? '',
      sZipcode: json['s_zipcode'] ?? '',
      sAboutYourself: json['s_about_youself'] ?? '',
      sGender: json['s_gender'] ?? '',
      sAge: json['s_age']?.toString(),
      sLevel: json['s_level']?.toString(),
      sImage: json['s_image'],
      createdBy: int.tryParse(json['created_by'].toString()) ?? 0,
      status: int.tryParse(json['status'].toString()) ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'f_father_name': fFatherName,
      'f_contact_number': fContactNumber,
      'f_emergency_contact': fEmergencyContact,
      'f_remarks': fRemarks,
      's_name': sName,
      's_address': sAddress,
      's_zipcode': sZipcode,
      's_about_youself': sAboutYourself,
      's_gender': sGender,
      's_age': sAge,
      's_level': sLevel,
      's_image': sImage,
      'created_by': createdBy,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}