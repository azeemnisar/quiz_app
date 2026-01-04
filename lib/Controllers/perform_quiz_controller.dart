import 'dart:convert';
import 'package:cognitive_quiz/API_Services/repo.dart';
import 'package:cognitive_quiz/models/perform_quiz_model.dart';
import 'package:get/get.dart';

class QuizResultController extends GetxController {
  final ApiService apiService = ApiService();

  // Observables
  var isLoading = false.obs;
  var quizResults = <QuizResult>[].obs;
  var errorMessage = ''.obs;

  // ✅ Expansion states for each quiz card
  RxList<bool> expandedStates = <bool>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuizResults(); // ✅ Safe to call here (won’t cause rebuild errors)
  }

  /// 🔹 Fetch quiz performance results from API
  Future<void> fetchQuizResults() async {
    try {
      isLoading(true);
      errorMessage('');

      final response = await apiService.showperformquiz({});

      print("=== 📡 Raw Response ===");
      print("URL: ${response.requestOptions.uri}");
      print("Status: ${response.statusCode}");
      print("Data Type: ${response.data.runtimeType}");
      print("Response Data: ${response.data}");

      dynamic rawData = response.data;

      if (response.statusCode == 200) {
        // ✅ CASE 1: Already decoded list
        if (rawData is List) {
          quizResults.value = QuizResult.fromJsonList(
            rawData.map((e) => Map<String, dynamic>.from(e)).toList(),
          );
        }
        // ✅ CASE 2: JSON string
        else if (rawData is String) {
          try {
            final decoded = json.decode(rawData);
            if (decoded is List) {
              quizResults.value = QuizResult.fromJsonList(
                decoded.map((e) => Map<String, dynamic>.from(e)).toList(),
              );
            } else {
              throw const FormatException("Not a list");
            }
          } catch (_) {
            final fixed = rawData
                .replaceAll(RegExp(r'([{,])(\s*)([a-zA-Z0-9_]+):'), r'\1"\3":')
                .replaceAll("'", '"');
            final decoded = json.decode(fixed);
            quizResults.value = QuizResult.fromJsonList(
              decoded.map((e) => Map<String, dynamic>.from(e)).toList(),
            );
          }
        }
        // ✅ CASE 3: Map with 'data' key
        else if (rawData is Map &&
            (rawData['data'] is List || rawData['results'] is List)) {
          final listData =
              (rawData['data'] ?? rawData['results']) as List<dynamic>;
          quizResults.value = QuizResult.fromJsonList(
            listData.map((e) => Map<String, dynamic>.from(e)).toList(),
          );
        } else {
          errorMessage.value = "Unexpected response format";
        }
      } else {
        errorMessage.value = "Failed to load results: ${response.statusCode}";
      }

      // ✅ Sync expansion states
      expandedStates.value = List.generate(quizResults.length, (_) => false);

      print("✅ Parsed ${quizResults.length} quiz results successfully");
    } catch (e) {
      errorMessage.value = "Error fetching results: $e";
      print("❌ Fetch quiz results error: $e");
    } finally {
      isLoading(false);
    }
  }

  /// 🔹 Toggle a quiz card’s expanded state
  void toggleExpanded(int index) {
    if (index >= 0 && index < expandedStates.length) {
      expandedStates[index] = !expandedStates[index];
    }
  }
}
