import 'package:cognitive_quiz/API_Services/repo.dart';
import 'package:cognitive_quiz/models/submit_question_model.dart';
import 'package:get/get.dart';

class QuestionSubmitController extends GetxController {
  final ApiService apiService = ApiService();

  /// 🔹 Observables for UI state management
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var quizSubmitResponse = Rxn<QuizSubmitResponse>();

  /// 🔹 Submit quiz answers to API
  Future<void> submitQuiz(Map<String, dynamic> params) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      quizSubmitResponse.value = null;

      final response = await apiService.postQuestions(params: params);

      // Check if API returned valid data
      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = response.data;

        // Ensure "success" is true and "data" exists
        if (body != null && body['success'] == true) {
          final parsedData = QuizSubmitResponse.fromJson(body);
          quizSubmitResponse.value = parsedData;
          print('✅ Quiz submitted successfully');
        } else {
          errorMessage.value = body?['message'] ?? 'Something went wrong';
          print('⚠️ API responded with error: ${errorMessage.value}');
        }
      } else {
        errorMessage.value =
            'Failed with status code: ${response.statusCode ?? "unknown"}';
      }
    } catch (e, stack) {
      errorMessage.value = 'Error submitting quiz: $e';
      print('❌ Exception while submitting quiz: $e\n$stack');
    } finally {
      isLoading.value = false;
    }
  }
}
