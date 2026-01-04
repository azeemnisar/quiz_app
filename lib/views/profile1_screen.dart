import 'package:cognitive_quiz/providers/gender_provider.dart';
import 'package:cognitive_quiz/utills/colors.dart';
import 'package:cognitive_quiz/utills/custom_image.dart';
import 'package:cognitive_quiz/utills/images.dart';
import 'package:cognitive_quiz/views/profile2_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
// ✅ Import provider

class ProfileScreen1 extends StatefulWidget {
  const ProfileScreen1({super.key});

  @override
  State<ProfileScreen1> createState() => _ProfileScreen1State();
}

class _ProfileScreen1State extends State<ProfileScreen1> {
  String? selectedGender; // 🔹 Track selected gender

  @override
  Widget build(BuildContext context) {
    final genderProvider = Provider.of<GenderProvider>(context);

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    double h(double value) => screenHeight * value;
    double w(double value) => screenWidth * value;
    double sp(double value) => screenWidth * (value / 390);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // 🔹 Background Image
          SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: CustomImageContainer(
              height: h(0.7),
              width: w(2),
              imageUrl: AppImages.profilebg,
            ),
          ),

          // 🔹 Skip Button
          Positioned(
            top: 40,
            right: 10,
            child: GestureDetector(
              onTap: () {
                Get.to(HomeScreen());
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Skip",
                  style: TextStyle(color: AppColors.black, fontSize: 14),
                ),
              ),
            ),
          ),

          // 🔹 Bottom Container
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: screenHeight * 0.43,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      "Complete Your Profile",
                      style: TextStyle(
                        fontSize: sp(18),
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                        letterSpacing: 0.8,
                      ),
                    ),
                    SizedBox(height: h(0.005)),
                    Text(
                      "Verify Your Gender",
                      style: TextStyle(fontSize: sp(13), color: AppColors.grey),
                    ),
                    SizedBox(height: h(0.03)),

                    // 🔹 Gender Options
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        genderCard(AppImages.male, "Male", sp, h, w),
                        genderCard(AppImages.female, "Female", sp, h, w),
                        genderCard(AppImages.others, "Others", sp, h, w),
                      ],
                    ),

                    SizedBox(height: h(0.04)),

                    // 🔹 Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: screenWidth * 0.25,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              foregroundColor: AppColors.black,
                              side: const BorderSide(
                                color: AppColors.greytextfields,
                              ),
                              padding: EdgeInsets.symmetric(vertical: h(0.018)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              "Back",
                              style: TextStyle(
                                fontSize: sp(14),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.35,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              foregroundColor: AppColors.black,
                              side: const BorderSide(
                                color: AppColors.greytextfields,
                              ),
                              padding: EdgeInsets.symmetric(vertical: h(0.018)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            onPressed:
                                genderProvider.isLoading
                                    ? null
                                    : () async {
                                      if (selectedGender == null) {
                                        Get.snackbar(
                                          "Error",
                                          "Please select a gender",
                                          snackPosition: SnackPosition.BOTTOM,
                                        );
                                        return;
                                      }

                                      await genderProvider.addGender(
                                        selectedGender!,
                                      );

                                      if (genderProvider.errorMessage != null) {
                                        Get.snackbar(
                                          "Success",
                                          "Gender saved successfully",
                                          snackPosition: SnackPosition.BOTTOM,
                                        );

                                        Get.to(const ProfileScreen2());
                                      }
                                    },
                            child:
                                genderProvider.isLoading
                                    ? const CircularProgressIndicator(
                                      color: AppColors.black,
                                    )
                                    : Text(
                                      "Next",
                                      style: TextStyle(
                                        fontSize: sp(14),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Gender Card Widget
  Widget genderCard(
    String imagePath,
    String label,
    double Function(double) sp,
    double Function(double) h,
    double Function(double) w,
  ) {
    final bool isSelected = selectedGender == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = label;
        });
      },
      child: Container(
        width: w(0.22),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.grey : AppColors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.black : AppColors.greytextfields,
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top: h(0.015), bottom: h(0.01)),
              child: Image.asset(
                imagePath,
                height: h(0.09),
                fit: BoxFit.contain,
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: h(0.01)),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.transparent : AppColors.grey,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: sp(13),
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen {}
