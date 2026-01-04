import 'package:cognitive_quiz/API_Services/app_url.dart';
import 'package:cognitive_quiz/Controllers/question_controller.dart';
import 'package:cognitive_quiz/Controllers/submit_question_controller.dart';
import 'package:cognitive_quiz/utills/colors.dart';
import 'package:cognitive_quiz/views/Guardian_screen.dart';
import 'package:cognitive_quiz/views/home_screen.dart';
import 'package:cognitive_quiz/views/quiz_result_popup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizQuestionScreen extends StatefulWidget {
  final String title;
  final String hashid;
  final String id;

  const QuizQuestionScreen({
    super.key,
    required this.hashid,
    required this.title,
    required this.id,
  });

  @override
  State<QuizQuestionScreen> createState() => _QuizQuestionScreenState();
}

class _QuizQuestionScreenState extends State<QuizQuestionScreen> {
  final QuestionController _questionController = Get.put(QuestionController());
  final QuestionSubmitController _quizController = Get.put(
    QuestionSubmitController(),
  );

  int _selectedIndex = -1;
  int _currentIndex = 0;
  bool _isImageLoading = false;

  final List<Map<String, dynamic>> _userAnswers = [];

  @override
  void initState() {
    super.initState();
    _questionController.fetchQuestions(widget.hashid);
  }

  void _goToNextQuestion() {
    if (_selectedIndex == -1) {
      Get.snackbar(
        "No Option Selected",
        "Please select an option first!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.transparent,
        colorText: AppColors.white,
      );
      return;
    }

    final currentQuestion = _questionController.questions[_currentIndex];
    final selectedOption = currentQuestion.options[_selectedIndex].options;

    _userAnswers.add({
      "question_id": currentQuestion.id,
      "selected_option": selectedOption,
    });

    if (_currentIndex < _questionController.questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedIndex = -1;
        _isImageLoading = false;
      });
    } else {
      _submitQuiz();
    }
  }

  Future<void> _submitQuiz() async {
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      final params = {
        "quiz_id": widget.id,
        "category": widget.title,
        "answers": _userAnswers,
      };

      await _quizController.submitQuiz(params);
      Get.back();

      if (_quizController.errorMessage.isNotEmpty) {
        Get.snackbar(
          "Error",
          _quizController.errorMessage.value,
          backgroundColor: AppColors.red,
          colorText: AppColors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        final result = _quizController.quizSubmitResponse.value;
        if (result != null && result.success) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return QuizResultPopupScreen(
                category: widget.title,
                totalQuestions: result.data?.totalQuestions ?? 0,
                attempted:
                    ((result.data?.summary?.correctAnswers ?? 0) +
                        (result.data?.summary?.wrongAnswers ?? 0)),
                correct: result.data?.summary?.correctAnswers ?? 0,
                percentage: result.data?.percentage ?? 0.0,
                aiResponse: result.data?.aiFeedback,
                detailedAnalysis: result.data?.detailedAnalysis,
                recomendations: result.data?.categoryRecommendations,
                onClose: () {
                  Get.to(HomeScreen());
                },
              );
            },
          );
        }
      }
    } catch (e) {
      Get.back();
      Get.snackbar(
        "Error",
        "Something went wrong: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Obx(() {
          if (_questionController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_questionController.errorMessage.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _questionController.errorMessage.value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Get.offAll(() => GuardianInfoScreen()),
                    child: const Text("Create Profile"),
                  ),
                ],
              ),
            );
          }

          final currentQuestion = _questionController.questions[_currentIndex];
          final image = currentQuestion.image;
          final options =
              currentQuestion.options.map((e) => e.options).toList();
          final optionLabels = ["a)", "b)", "c)", "d)"];

          return Padding(
            padding: EdgeInsets.all(screenW * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: screenW * 0.05,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1A1A40),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: AppColors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),

                SizedBox(height: screenH * 0.01),

                /// Progress bar
                Row(
                  children: List.generate(
                    _questionController.questions.length,
                    (index) => Expanded(
                      child: Container(
                        height: 3,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color:
                              index <= _currentIndex
                                  ? AppColors.lightblue
                                  : AppColors.grey,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: screenH * 0.02),

                /// Question Card
                Expanded(
                  child: SingleChildScrollView(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: EdgeInsets.all(screenW * 0.04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (image != null && image.isNotEmpty)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  image.startsWith('http')
                                      ? image
                                      : "${AppUrl.imageBaseUrl}${image.startsWith('/') ? '' : '/'}$image",
                                  height: screenH * 0.25,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (
                                    context,
                                    child,
                                    loadingProgress,
                                  ) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return Container(
                                      height: screenH * 0.25,
                                      color: Colors.grey.shade200,
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  },
                                ),
                              ),

                            SizedBox(height: screenH * 0.02),

                            /// Question text (speaker removed, layout same)
                            Text(
                              currentQuestion.question,
                              style: TextStyle(
                                fontSize: screenW * 0.045,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                            ),

                            SizedBox(height: screenH * 0.02),

                            Column(
                              children: List.generate(options.length, (i) {
                                return _optionTile(
                                  "${optionLabels[i]} ${options[i]}",
                                  i,
                                  screenW,
                                  screenH,
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: screenH * 0.02),

                /// Next Button (Mic removed, spacing intact)
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lightblue,
                      elevation: 0, // 👈 flat button like image
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          6,
                        ), // 👈 image-like radius
                      ),
                    ),
                    onPressed: _isImageLoading ? null : _goToNextQuestion,
                    child: Text(
                      _currentIndex < _questionController.questions.length - 1
                          ? "Next"
                          : "Finish",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _optionTile(String text, int index, double w, double h) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: h * 0.015),
        padding: EdgeInsets.symmetric(vertical: h * 0.02, horizontal: w * 0.03),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade100 : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade400,
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: w * 0.04,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.blue : Colors.black87,
          ),
        ),
      ),
    );
  }
}
