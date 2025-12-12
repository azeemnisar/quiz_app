import 'dart:async';
import 'package:cognitive_quiz/utills/colors.dart';
import 'package:cognitive_quiz/utills/custom_image.dart';
import 'package:cognitive_quiz/utills/images.dart';
import 'package:cognitive_quiz/views/welcome3_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';

class Welcome2Screen extends StatefulWidget {
  const Welcome2Screen({super.key});

  @override
  State<Welcome2Screen> createState() => _Welcome2ScreenState();
}

class _Welcome2ScreenState extends State<Welcome2Screen> {
  @override
  void initState() {
    super.initState();

    // Example: Auto navigation after 3 seconds (optional)
    // Timer(const Duration(seconds: 3), () {
    //   Get.to(const Welcome3Screen());
    // });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    double h(double value) => screenHeight * value; // % of height
    double w(double value) => screenWidth * value; // % of width
    double sp(double value) =>
        screenWidth * (value / 390); // scale font (390 = base width iPhone 12)
    return Scaffold(
      backgroundColor: const Color(0xFFE0E0E0), // light gray
      body: Stack(
        children: [
          // 🔹 Skip button on top-right
          Positioned(
            top: 40,
            right: 20,
            child: GestureDetector(
              onTap: () {
                // 👇 Your onPressed action here
                // Example: Navigate to Login/Home screen
                // Get.to(const LoginScreen());
                // Get.to(Login());
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Skip",
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
            ),
          ),
          
          
          // es (background + foreground)
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.12),
            child: Align(
              alignment: Alignment.topLeft,
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  // Background Image slightly upward & shifted LEFT
                  Transform.translate(
                    offset: const Offset(-12, -20), // left + upward
                    child: SizedBox(
                      height: screenHeight,
                      width: screenWidth,
                      child: CustomImageContainer(
                        height: h(0.34),
                        width: w(2.5),
                        imageUrl: AppImages.backwelcome2,
                      ),
                    ),
                  ),

                  // 🔹 Foreground Image
                  SizedBox(
                    height: screenHeight,
                    width: screenWidth,
                    child: CustomImageContainer(
                      height: h(0.6),
                      width: w(2),
                      imageUrl: AppImages.Welcome2,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 🔹 Bottom popup container
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: screenHeight * 0.42,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15),
                    const Text(
                      "The Ultimate Trivia \nChallenge",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Put the knowledge to the test and \n"
                      "prove your expertise across a wide\n"
                      "range of topics in this engaging game.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    const Spacer(),

                    // 🔹 Page indicator + Next button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Page indicator
                        Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: AppColors.darkblue,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              width: 20,
                              height: 6,
                              decoration: BoxDecoration(
                                color: AppColors.darkblue,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),

                        // 🔹 Next button with arc
                        GestureDetector(
                          onTap: () {
                            Get.to(const Welcome3Screen());
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                              color: Color(0xFF00008B), // Dark Blue
                              shape: BoxShape.circle,
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 26,
                                ),
                                Positioned.fill(
                                  child: CustomPaint(painter: ArcPainter()),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 🎨 Arc painter for circular border
class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = AppColors.darkblue
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3;

    // 🔹 Add spacing by reducing radius a bit
    final double spacing = 5; // adjust gap here
    final Rect rect = Rect.fromCircle(
      center: size.center(Offset.zero),
      radius: (size.width / 2) + spacing, // arc slightly outside the button
    );

    // Draw arc with start & sweep angle
    canvas.drawArc(rect, 4.5, 4.5, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}