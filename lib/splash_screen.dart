import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:quiz/utils/app_consultant.dart';
// import 'package:quiz/utils/colors.dart';
// import 'package:quiz/utils/images.dart';
// import 'package:quiz/views/home_screen.dart';
// import 'package:quiz/views/welcome1_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // _checkLoginStatus();
  }

  /// ✅ Check login status and navigate accordingly
  // Future<void> _checkLoginStatus() async {
  //   await Future.delayed(const Duration(seconds: 3)); // splash delay
  //   bool loggedIn = await AppConstant.isLoggedIn();

  //   if (mounted) {
  //     if (loggedIn) {
  //       // ✅ Navigate to HomeScreen if user token exists
  //       Get.offAll(() => const HomeScreen());
  //     } else {
  //       // 🚀 Navigate to Welcome1Screen if not logged in
  //       Get.offAll(() => const Welcome1Screen());
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // body: Center(
      //   child: Image.asset(
      //     AppImages.logo,
      //     height: 200.h,
      //     width: 0.93.sw,
      //     fit: BoxFit.contain,
      //   ),
      // ),
    );
  }
}
