class QuizResponse {
  final bool success;
  final String message;
  final List<Quiz> quizzes;

  QuizResponse({
    required this.success,
    required this.message,
    required this.quizzes,
  });

  factory QuizResponse.fromJson(Map<String, dynamic> json) {
    return QuizResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      quizzes:
          (json['quiz'] as List<dynamic>? ?? [])
              .map((e) => Quiz.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message": message,
      "quiz": quizzes.map((e) => e.toJson()).toList(),
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
  final Level level;

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
    required this.level,
  });

  // factory Quiz.fromJson(Map<String, dynamic> json) {
  //   return Quiz(
  //     id: json['id'] ?? 0,
  //     categoryId: json['category_id'] ?? 0,
  //     ageLevelId: json['age_level_id'] ?? 0,
  //     levelId: json['level_id'] ?? 0,
  //     title: json['title'] ?? '',
  //     description: json['description'] ?? '',
  //     createdAt: json['created_at'] ?? '',
  //     updatedAt: json['updated_at'] ?? '',
  //     hashid: json['hashid'] ?? '',
  //     category: Category.fromJson(json['category'] ?? {}),
  //     level: Level.fromJson(json['level'] ?? {}),
  //   );
  // }

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
      level: Level.fromJson(json['level'] ?? {}),
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
      "level": level.toJson(),
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

  // factory Category.fromJson(Map<String, dynamic> json) {
  //   return Category(
  //     id: json['id'] ?? 0,
  //     name: json['name'] ?? '',
  //     description: json['description'] ?? '',
  //     status: json['status'] ?? 0,
  //     createdAt: json['created_at'] ?? '',
  //     updatedAt: json['updated_at'] ?? '',
  //     hashid: json['hashid'] ?? '',
  //   );
  // }

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

class Level {
  final int id;
  final String name;

  Level({required this.id, required this.name});

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name};
  }
}
