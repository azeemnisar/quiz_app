class QuizResponse {
  final bool success;
  final String message;
  final List<Quiz> quizes;

  QuizResponse({
    required this.success,
    required this.message,
    required this.quizes,
  });

  factory QuizResponse.fromJson(Map<String, dynamic> json) {
    return QuizResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      quizes:
          (json['quizes'] as List<dynamic>?)
              ?.map((item) => Quiz.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message": message,
      "quizes": quizes.map((q) => q.toJson()).toList(),
    };
  }
}

class Quiz {
  final int id;
  final int categoryId;
  final int ageLevelId;
  final int levelId;
  final String title;
  final String description;
  final String createdAt;
  final String updatedAt;
  final String hashid;
  final Category category;

  Quiz({
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
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: int.tryParse(json['id'].toString()) ?? 0,
      categoryId: int.tryParse(json['category_id'].toString()) ?? 0,
      ageLevelId: int.tryParse(json['age_level_id'].toString()) ?? 0,
      levelId: int.tryParse(json['level_id'].toString()) ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      hashid: json['hashid'] ?? '',
      category: Category.fromJson(json['category'] ?? {}),
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
    };
  }
}

class Category {
  final int id;
  final String name;
  final String description;
  final int status;
  final String createdAt;
  final String updatedAt;
  final String hashid;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.hashid,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      status: int.tryParse(json['status'].toString()) ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      hashid: json['hashid'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "status": status,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "hashid": hashid,
    };
  }
}
