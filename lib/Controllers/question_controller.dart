import 'package:cognitive_quiz/API_Services/repo.dart';
import 'package:cognitive_quiz/models/question_model.dart';
import 'package:get/get.dart';

class QuestionController extends GetxController {
  /// Observable states
  var isLoading = false.obs;
  var questions = <Question>[].obs;
  var errorMessage = ''.obs;

  /// Fetch all questions for the given quiz/category hashid
  Future<void> fetchQuestions(String hashid) async {
    try {
      isLoading(true);
      errorMessage('');

      final response = await ApiService().getquestions(hashid);
      final data = response.data;

      // ✅ Handle 200/201 (success)
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (data != null && data['success'] == true) {
          final quizResponse = QuizQuestionResponse.fromJson(data);
          questions.assignAll(quizResponse.questions);
        } else {
          errorMessage.value = data?['message'] ?? 'No questions found.';
          questions.clear();
        }
      }
      // ✅ Handle 404 (like "Please Create Profile First")
      else if (response.statusCode == 404) {
        errorMessage.value =
            data?['message'] ?? 'Please create your profile first.';
        questions.clear();
      }
      // else if(AppUrl.guest_user == true){
      //   errorMessage.value = data['message']
      // }
      // ✅ Handle other errors
      else {
        errorMessage.value =
            data?['message'] ?? 'Unexpected error occurred. Try again later.';
        questions.clear();
      }
    } catch (e) {
      errorMessage.value = 'You need to create your profile before continuing.';
      questions.clear();
    } finally {
      isLoading(false);
    }
  }

  /// Helper: Get the correct answer for a question
  String getCorrectAnswer(Question question) {
    if (question.correctAnswer != null && question.correctAnswer!.isNotEmpty) {
      return question.correctAnswer!;
    }

    // fallback from options if correct answer not in main field
    for (final option in question.options) {
      if (option.options == option.correctAnswer) {
        return option.correctAnswer;
      }
    }
    return '';
  }

  /// Helper: Reset all data
  void clearQuestions() {
    questions.clear();
    errorMessage('');
  }
}
