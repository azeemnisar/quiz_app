class CategoryModel {
  final int id;
  final String name;
  final String hashid;

  CategoryModel({required this.id, required this.name, required this.hashid});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'] ?? '',
      hashid: json['hashid'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "hashid": hashid};
  }
}

class QuizModel {
  final int id;
  final int categoryId;
  final int ageLevelId;
  final int levelId;
  final String title;
  final String description;
  final String createdAt;
  final String updatedAt;
  final String hashid;
  final CategoryModel category;
  final String ageRange;
  final String levelName;

  QuizModel({
    required this.id,
    required this.categoryId,
    required this.ageLevelId,
    required this.levelId,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.hashid,
    required this.category,
    required this.ageRange,
    required this.levelName,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      categoryId: int.tryParse(json['category_id'].toString()) ?? 0,
      ageLevelId: int.tryParse(json['age_level_id'].toString()) ?? 0,
      levelId: int.tryParse(json['level_id'].toString()) ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      hashid: json['hashid'] ?? '',
      category: CategoryModel.fromJson(json['category'] ?? {}),
      ageRange: json['age']?['range']?.toString() ?? '',
      levelName: json['level']?['name']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "category_id": categoryId,
      "age_level_id": ageLevelId,
      "level_id": levelId,
      "title": title,
      "description": description,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "hashid": hashid,
      "category": category.toJson(),
      "age": {"range": ageRange},
      "level": {"name": levelName},
    };
  }
}

class QuizResponse {
  final bool success;
  final String message;
  final QuizModel quiz;
  final int count;

  QuizResponse({
    required this.success,
    required this.message,
    required this.quiz,
    required this.count,
  });

  factory QuizResponse.fromJson(Map<String, dynamic> json) {
    return QuizResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      quiz: QuizModel.fromJson(json['quiz'] ?? {}),
      count: int.tryParse(json['count'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message": message,
      "quiz": quiz.toJson(),
      "count": count,
    };
  }
}
