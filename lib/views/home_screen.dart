import 'package:cognitive_quiz/API_Services/app_url.dart';
import 'package:cognitive_quiz/Controllers/category_controller.dart';
import 'package:cognitive_quiz/Controllers/perform_quiz_controller.dart';
import 'package:cognitive_quiz/providers/profile_provider.dart';
import 'package:cognitive_quiz/splash_screen.dart';
import 'package:cognitive_quiz/utills/colors.dart';
import 'package:cognitive_quiz/views/categories_quiz_screen.dart';
import 'package:cognitive_quiz/views/profile_view.dart';
import 'package:cognitive_quiz/views/quizzes_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
// import 'package:quiz/Controller/perform_quiz_controller.dart';
// import 'package:quiz/api_Services/app_url.dart';
// import 'package:quiz/provider/profile_provider.dart';
// import 'package:quiz/utils/colors.dart';
// import 'package:quiz/views/category_quiz_screen.dart';
// import 'package:quiz/views/map_screen.dart';
// import 'package:quiz/views/message_screen.dart';
// import 'package:quiz/views/profile_view.dart';
// import 'package:quiz/views/quizzes_screen.dart';
// import 'package:quiz/views/videotraining_screeen.dart';
// import 'package:quiz/views/your_quezzesscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final CategoryController categoryController = Get.put(CategoryController());
  final QuizResultController quizResultController = Get.put(
    QuizResultController(),
  );

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProfileProvider>(context, listen: false).fetchProfile();
      quizResultController.fetchQuizResults();
    });
  }

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) return "GOOD MORNING";
    if (hour >= 12 && hour < 17) return "GOOD AFTERNOON";
    if (hour >= 17 && hour < 21) return "GOOD EVENING";
    return "GOOD NIGHT";
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final List<Widget> pages = [
      _homePage(screenWidth, screenHeight),
      Quizzes(),
      // VideoTrainingsScreen(),
      // GoogleMapPage(doctorRecommendations: []),
    ];

    return Scaffold(
      backgroundColor: AppColors.grey,
      resizeToAvoidBottomInset: false,
      body: SafeArea(child: pages[_selectedIndex]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(()),
        backgroundColor: AppColors.darkblue,
        child: const Icon(Icons.chat, color: AppColors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
              const SizedBox(width: 40),
              _bottomNavItem(Icons.video_library, "Videos", 2),
              _bottomNavItem(Icons.location_on, "Location", 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _homePage(double screenWidth, double screenHeight) {
    double h(double value) => screenHeight * value;
    double w(double value) => screenWidth * value;
    double sp(double value) => screenWidth * (value / 390);

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: w(0.05), vertical: h(0.02)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getGreeting(),
                        style: TextStyle(
                          fontSize: sp(12),
                          fontWeight: FontWeight.w500,
                          color: AppColors.lightblue,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Consumer<ProfileProvider>(
                        builder: (context, profileProvider, child) {
                          final name =
                              profileProvider.profile?.studentName ??
                              "GUEST USER";
                          return Text(
                            name.toUpperCase(),
                            style: TextStyle(
                              fontSize: sp(18),
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Consumer<ProfileProvider>(
                    builder: (context, provider, child) {
                      final image = provider.profile?.image;
                      final imageUrl =
                          (image != null && image.isNotEmpty)
                              ? (image.startsWith('http')
                                  ? image
                                  : "${AppUrl.imageBaseUrl}${image.startsWith('/') ? '' : '/'}$image")
                              : null;

                      return GestureDetector(
                        onTap:
                            () => Get.to(
                              const ViewProfile(),
                            ), //view profile screen
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor: AppColors.greytextfields,
                          backgroundImage:
                              imageUrl != null ? NetworkImage(imageUrl) : null,
                          child:
                              imageUrl == null
                                  ? const Icon(
                                    Icons.person,
                                    color: AppColors.black,
                                  )
                                  : null,
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ✅ QUIZ CATEGORIES
              Expanded(
                child: Obx(() {
                  if (categoryController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (categoryController.quizzes.isEmpty) {
                    return const Center(
                      child: Text("⚠️ No Categories are available"),
                    );
                  }

                  return ListView(
                    children:
                        categoryController.quizzes.map((quiz) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(
                                () => CategoryQuizScreen(
                                  hashid: quiz.category.hashid,
                                  CategoryName: quiz.category.name,
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              padding: EdgeInsets.all(w(0.04)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: const LinearGradient(
                                  colors: [AppColors.red, AppColors.lightblue],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    quiz.title,
                                    style: TextStyle(
                                      fontSize: sp(17),
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  SizedBox(height: h(0.007)),
                                  Text(
                                    quiz.description,
                                    style: TextStyle(
                                      fontSize: sp(14),
                                      color: AppColors.white,
                                    ),
                                  ),
                                  SizedBox(height: h(0.007)),
                                  Text(
                                    "Category: ${quiz.category.name}",
                                    style: const TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: h(0.007)),
                                  Text(
                                    "${categoryController.count.value} Quizzes Available",
                                    style: const TextStyle(
                                      color: AppColors.white,
                                    ),
                                  ),
                                  SizedBox(height: h(0.015)),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                  );
                }),
              ),
            ],
          ),
        ),

        // ✅ FIXED “Your Quizzes” SECTION
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: screenHeight * 0.45,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.06,
                vertical: screenHeight * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ✅ Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Your Quizzes",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.to(()), //your quizzes
                        child: const Text(
                          "See all",
                          style: TextStyle(
                            color: AppColors.darkblue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // ✅ AUTO-FIT LIST BASED ON SCREEN HEIGHT
                  Expanded(
                    child: Obx(() {
                      if (quizResultController.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (quizResultController.quizResults.isEmpty) {
                        return const Center(
                          child: Text("No quiz results found yet."),
                        );
                      }

                      final results = quizResultController.quizResults;

                      // dynamically calculate how many cards fit
                      int visibleCount = (screenHeight / 250).floor();
                      visibleCount = visibleCount.clamp(1, results.length);

                      final visibleResults =
                          results.take(visibleCount).toList();

                      return Column(
                        children:
                            visibleResults.map((quiz) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          quiz.quiz.title.isNotEmpty
                                              ? quiz.quiz.title
                                              : "Untitled Quiz",
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "Score: ${quiz.score} | ${quiz.quizPercentage}%",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "Date: ${quiz.createdAt.toLocal().toString().split(' ')[0]}",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _bottomNavItem(IconData icon, String label, int index) {
    final bool isActive = _selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedIndex = index),
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
