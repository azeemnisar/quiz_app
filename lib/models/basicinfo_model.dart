class BasicInfoModel {
  final bool success;
  final String message;
  final BasicProfile profile;

  BasicInfoModel({
    required this.success,
    required this.message,
    required this.profile,
  });

  factory BasicInfoModel.fromJson(Map<String, dynamic> json) {
    return BasicInfoModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      profile: BasicProfile.fromJson(json['profile']),
    );
  }
}

class BasicProfile {
  final String sName;
  final String sAddress;
  final String sZipcode;
  final String sAboutYourself;
  final int createdBy;
  final int id;

  BasicProfile({
    required this.sName,
    required this.sAddress,
    required this.sZipcode,
    required this.sAboutYourself,
    required this.createdBy,
    required this.id,
  });

  factory BasicProfile.fromJson(Map<String, dynamic> json) {
    return BasicProfile(
      sName: json['s_name'] ?? '',
      sAddress: json['s_address'] ?? '',
      sZipcode: json['s_zipcode'] ?? '',
      sAboutYourself: json['s_about_youself'] ?? '',
      createdBy: json['created_by'] ?? 0,
      id: json['id'] ?? 0,
    );
  }
}
