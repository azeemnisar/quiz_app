class QuizQuestionResponse {
  final bool success;
  final String message;
  final List<Question> questions;

  QuizQuestionResponse({
    required this.success,
    required this.message,
    required this.questions,
  });

  factory QuizQuestionResponse.fromJson(Map<String, dynamic> json) {
    return QuizQuestionResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      questions:
          (json['question'] as List<dynamic>?)
              ?.map((e) => Question.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'question': questions.map((e) => e.toJson()).toList(),
    };
  }
}

class Question {
  final int id;
  final String question;
  final String? image;
  final String? correctAnswer;
  final List<Option> options;

  Question({
    required this.id,
    required this.question,
    this.image,
    this.correctAnswer,
    required this.options,
  });

  // factory Question.fromJson(Map<String, dynamic> json) {
  //   return Question(
  //     id: json['id'] ?? 0,
  //     question: json['question'] ?? '',
  //     image: json['image'], // ✅ Added image field
  //     correctAnswer: json['correct_answer'], // can be null
  //     options:
  //         (json['options'] as List<dynamic>?)
  //             ?.map((e) => Option.fromJson(e))
  //             .toList() ??
  //         [],
  //   );
  // }
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: int.tryParse(json['id'].toString()) ?? 0,
      question: json['question'] ?? '',
      image: json['image'],
      correctAnswer: json['correct_answer'],
      options:
          (json['options'] as List<dynamic>?)
              ?.map((e) => Option.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'image': image,
      'correct_answer': correctAnswer,
      'options': options.map((e) => e.toJson()).toList(),
    };
  }
}

class Option {
  final int id;
  final int questionId;
  final String options;
  final String correctAnswer;

  Option({
    required this.id,
    required this.questionId,
    required this.options,
    required this.correctAnswer,
  });

  // factory Option.fromJson(Map<String, dynamic> json) {
  //   return Option(
  //     id: json['id'] ?? 0,
  //     questionId: json['question_id'] ?? 0,
  //     options: json['options'] ?? '',
  //     correctAnswer: json['correct_answer'] ?? '',
  //   );
  // }

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: int.tryParse(json['id'].toString()) ?? 0,
      questionId: int.tryParse(json['question_id'].toString()) ?? 0,
      options: json['options'] ?? '',
      correctAnswer: json['correct_answer'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question_id': questionId,
      'options': options,
      'correct_answer': correctAnswer,
    };
  }
}
