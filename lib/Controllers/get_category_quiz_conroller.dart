import 'package:cognitive_quiz/API_Services/repo.dart';
import 'package:cognitive_quiz/models/get_category_quiz_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class CategoryQuizController extends GetxController {
  final ApiService _apiService = ApiService();

  var isLoading = false.obs;
  var quizes = <Quiz>[].obs;

  /// 🔹 Fetch quizzes by category (using hashid)
  Future<void> fetchCategoryQuizzes(String hashid) async {
    try {
      isLoading.value = true;

      final response = await _apiService.getcategoryquiz(hashid);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        /// Parse JSON into model
        final quizResponse = QuizResponse.fromJson(data);

        if (quizResponse.success) {
          quizes.assignAll(quizResponse.quizes);
        } else {
          quizes.clear();
          Get.snackbar("Error", quizResponse.message);
        }
      } else {
        quizes.clear();
        Get.snackbar(
          "Error",
          "Failed to fetch quizzes (${response.statusCode})",
        );
      }
    } catch (e) {
      quizes.clear();
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
