class GuardianResponse {
  final bool success;
  final String message;
  final GuardianProfile? guardianProfile;

  GuardianResponse({
    required this.success,
    required this.message,
    this.guardianProfile,
  });

  factory GuardianResponse.fromJson(Map<String, dynamic> json) {
    return GuardianResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      guardianProfile:
          json['GuardianProfile'] != null
              ? GuardianProfile.fromJson(json['GuardianProfile'])
              : null,
    );
  }
}

class GuardianProfile {
  final int id;
  final String fatherName;
  final String contactNumber;
  final String emergencyContact;
  final String remarks;
  final int createdBy;
  final String createdAt;
  final String updatedAt;

  GuardianProfile({
    required this.id,
    required this.fatherName,
    required this.contactNumber,
    required this.emergencyContact,
    required this.remarks,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GuardianProfile.fromJson(Map<String, dynamic> json) {
    return GuardianProfile(
      id: json['id'] ?? 0,
      fatherName: json['f_father_name'] ?? '',
      contactNumber: json['f_contact_number'] ?? '',
      emergencyContact: json['f_emergency_contact'] ?? '',
      remarks: json['f_remarks'] ?? '',
      createdBy: json['created_by'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
