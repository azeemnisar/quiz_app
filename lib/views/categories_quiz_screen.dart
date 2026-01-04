import 'package:cognitive_quiz/Controllers/get_category_quiz_conroller.dart';
import 'package:cognitive_quiz/utills/colors.dart';
import 'package:cognitive_quiz/utills/custom_image.dart';
import 'package:cognitive_quiz/utills/images.dart';
import 'package:cognitive_quiz/views/home_screen.dart';
import 'package:cognitive_quiz/views/quiz_question_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryQuizScreen extends StatefulWidget {
  final String hashid;
  final String CategoryName;

  const CategoryQuizScreen({
    super.key,
    required this.hashid,
    required this.CategoryName,
  });

  @override
  State<CategoryQuizScreen> createState() => _CategoryQuizScreenState();
}

class _CategoryQuizScreenState extends State<CategoryQuizScreen> {
  int _selectedIndex = 1; // Default: Quizzes tab
  final CategoryQuizController quizController = Get.put(
    CategoryQuizController(),
  );

  @override
  void initState() {
    super.initState();
    quizController.fetchCategoryQuizzes(widget.hashid);
  }

  /// 🔹 Handle bottom navigation
  void _onItemTapped(int index) {
    setState(() => _selectedIndex = 1);

    switch (index) {
      case 0:
        Get.offAll(() => const HomeScreen(), transition: Transition.fadeIn);
        break;
      case 1:
        // Already on this screen
        break;
      case 2:
        //Get.to(() => VideoTrainingsScreen(), transition: Transition.fadeIn);
        break;
      case 3:
        //Get.to(GoogleMapPage(doctorRecommendations: []));

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double w(double value) => screenWidth * value;

    return Scaffold(
      backgroundColor: AppColors.grey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                "${widget.CategoryName} Quizzes",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 20),

              /// 🔹 Quiz List
              Expanded(
                child: Obx(() {
                  if (quizController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (quizController.quizes.isEmpty) {
                    return const Center(
                      child: Text(
                        "No quizzes found",
                        style: TextStyle(fontSize: 16, color: AppColors.black),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: quizController.quizes.length,
                    itemBuilder: (context, index) {
                      final quiz = quizController.quizes[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: _quizCard(
                          id: quiz.id.toString(),
                          duration: "5 min",
                          title: quiz.title,
                          questions: 10,
                          createdBy: "Admin",
                          hashid: quiz.hashid,
                          context: context,
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),

      /// 🔹 Floating Chat Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Get.to(() => ChatScreen());
        },
        backgroundColor: AppColors.darkblue,
        child: const Icon(Icons.chat, color: AppColors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      /// 🔹 Bottom Navigation Bar (same as HomeScreen)
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _bottomNavItem(Icons.home, "Home", 0),
              _bottomNavItem(Icons.grid_view, "Quizzes", 1),
              const SizedBox(width: 40), // space for FAB
              _bottomNavItem(Icons.video_library, "Videos", 2),
              _bottomNavItem(Icons.lightbulb, "Location", 3),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 Quiz Card Widget
  Widget _quizCard({
    required String duration,
    required String title,
    required int questions,
    required String createdBy,
    required String hashid,
    required BuildContext context,
    required String id,
  }) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Get.to(QuizQuestionScreen(hashid: hashid, title: title, id: id));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Text Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "$questions Questions • $duration",
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 14,
                        backgroundColor: AppColors.white,
                        child: Icon(
                          Icons.person,
                          size: 18,
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Created by $createdBy",
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// Image Section
            CustomImageContainer(
              height: screenHeight * 0.08,
              width: screenWidth * 0.25,
              imageUrl: AppImages.error_image,
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Reusable Bottom Nav Item
  Widget _bottomNavItem(IconData icon, String label, int index) {
    final bool isActive = _selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => _onItemTapped(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isActive ? AppColors.darkblue : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isActive ? Colors.white : Colors.grey,
                size: 22,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isActive ? AppColors.darkblue : Colors.grey,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
