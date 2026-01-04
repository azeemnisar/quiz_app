class QuizSubmitResponse {
  final bool success;
  final QuizData? data;
  final String? message;

  QuizSubmitResponse({required this.success, this.data, this.message});

  factory QuizSubmitResponse.fromJson(Map<String, dynamic> json) {
    return QuizSubmitResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data:
          json['data'] != null
              ? QuizData.fromJson(Map<String, dynamic>.from(json['data']))
              : null,
    );
  }
}

class QuizData {
  final int? score;
  final int? totalQuestions;
  final double? percentage;
  final String? quizMarks;
  final String? quizStatus;
  final String? aiFeedback;
  final String? detailedAnalysis;
  final String? categoryRecommendations;
  final int? attemptId;
  final String? category;
  final List<AnswerDetail>? answerDetails;
  final Summary? summary;

  QuizData({
    this.score,
    this.totalQuestions,
    this.percentage,
    this.quizMarks,
    this.quizStatus,
    this.aiFeedback,
    this.detailedAnalysis,
    this.categoryRecommendations,
    this.attemptId,
    this.category,
    this.answerDetails,
    this.summary,
  });

  factory QuizData.fromJson(Map<String, dynamic> json) {
    return QuizData(
      score: json['score'],
      totalQuestions: json['total_questions'],
      percentage:
          (json['percentage'] is int)
              ? (json['percentage'] as int).toDouble()
              : (json['percentage'] ?? 0.0).toDouble(),
      quizMarks: json['quiz_marks'],
      quizStatus: json['quiz_status'],
      aiFeedback: json['ai_feedback'],
      detailedAnalysis: json['detailed_analysis'],
      categoryRecommendations: json['category_recommendations'],
      attemptId: json['attempt_id'],
      category: json['category'],
      answerDetails:
          (json['answer_details'] is List)
              ? (json['answer_details'] as List)
                  .whereType<Map>()
                  .map(
                    (e) => AnswerDetail.fromJson(Map<String, dynamic>.from(e)),
                  )
                  .toList()
              : [],
      summary:
          (json['summary'] is Map)
              ? Summary.fromJson(Map<String, dynamic>.from(json['summary']))
              : null,
    );
  }
}

class AnswerDetail {
  final String? question;
  final String? userAnswer;
  final String? correctAnswer;
  final bool? isCorrect;

  AnswerDetail({
    this.question,
    this.userAnswer,
    this.correctAnswer,
    this.isCorrect,
  });

  factory AnswerDetail.fromJson(Map<String, dynamic> json) {
    return AnswerDetail(
      question: json['question'],
      userAnswer: json['user_answer'],
      correctAnswer: json['correct_answer'],
      isCorrect: json['is_correct'] ?? false,
    );
  }
}

class Summary {
  final int? correctAnswers;
  final int? wrongAnswers;
  final List<QuestionResult>? correctQuestions;
  final List<QuestionResult>? wrongQuestions;

  Summary({
    this.correctAnswers,
    this.wrongAnswers,
    this.correctQuestions,
    this.wrongQuestions,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      correctAnswers: json['correct_answers'] ?? 0,
      wrongAnswers: json['wrong_answers'] ?? 0,
      correctQuestions: _parseQuestionMap(json['correct_questions']),
      wrongQuestions: _parseQuestionMap(json['wrong_questions']),
    );
  }

  /// ✅ Convert map { "0": {...}, "1": {...} } to list
  static List<QuestionResult> _parseQuestionMap(dynamic data) {
    if (data is Map) {
      return data.values
          .whereType<Map>()
          .map((e) => QuestionResult.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } else if (data is List) {
      return data
          .whereType<Map>()
          .map((e) => QuestionResult.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }
    return [];
  }
}

class QuestionResult {
  final String? question;
  final String? userAnswer;
  final String? correctAnswer;
  final bool? isCorrect;

  QuestionResult({
    this.question,
    this.userAnswer,
    this.correctAnswer,
    this.isCorrect,
  });

  factory QuestionResult.fromJson(Map<String, dynamic> json) {
    return QuestionResult(
      question: json['question'],
      userAnswer: json['user_answer'],
      correctAnswer: json['correct_answer'],
      isCorrect: json['is_correct'] ?? false,
    );
  }
}
