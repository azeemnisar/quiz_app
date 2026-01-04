class RangeModel {
  final int id;
  final String range;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;

  RangeModel({
    required this.id,
    required this.range,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create a RangeModel from JSON
  // factory RangeModel.fromJson(Map<String, dynamic> json) {
  //   return RangeModel(
  //     id: json['id'] as int,
  //     range: json['range'] as String,
  //     status: json['status'] as int,
  //     createdAt: DateTime.parse(json['created_at'] as String),
  //     updatedAt: DateTime.parse(json['updated_at'] as String),
  //   );
  // }
  factory RangeModel.fromJson(Map<String, dynamic> json) {
    return RangeModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      range: json['range'].toString(),
      status: int.tryParse(json['status'].toString()) ?? 0,
      createdAt: DateTime.parse(json['created_at'].toString()),
      updatedAt: DateTime.parse(json['updated_at'].toString()),
    );
  }

  // Method to convert RangeModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'range': range,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'RangeModel(id: $id, range: $range, status: $status)';
  }
}

// Optional: Convert a list of JSON to List<RangeModel>
List<RangeModel> rangeModelListFromJson(List<dynamic> jsonList) {
  return jsonList.map((json) => RangeModel.fromJson(json)).toList();
}
