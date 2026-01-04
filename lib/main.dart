import 'package:cognitive_quiz/controller/register_controller.dart';
import 'package:cognitive_quiz/providers/age_provider.dart';
import 'package:cognitive_quiz/providers/basicinfo_provider.dart';
import 'package:cognitive_quiz/providers/gender_provider.dart';
import 'package:cognitive_quiz/providers/guardian_profile_provider.dart';
import 'package:cognitive_quiz/providers/image_provider.dart';
import 'package:cognitive_quiz/providers/login_provider.dart';
import 'package:cognitive_quiz/providers/otp_provider.dart';
import 'package:cognitive_quiz/providers/profile_provider.dart';
import 'package:cognitive_quiz/providers/profile_update_provider.dart';
import 'package:cognitive_quiz/splash_screen.dart';
import 'package:cognitive_quiz/views/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        //ChangeNotifierProvider(create: (_) => LoginProvider()),
        // ChangeNotifierProvider(create: (_) => RegisterProvider()),
        // ChangeNotifierProvider(create: (_) => OtpProvider()),
        // ChangeNotifierProvider(create: (_) => LoginProvider()),
        // ChangeNotifierProvider(create: (_) => GuardianProvider()),
        // ChangeNotifierProvider(create: (_) => BasicInfoProvider()),
        // ChangeNotifierProvider(create: (_) => GenderProvider()),
        // ChangeNotifierProvider(create: (_) => AgeProvider()),
        // ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => OtpProvider()),
        // ChangeNotifierProvider(create: (_) => VideoProvider()),
        // ChangeNotifierProvider(create: (_) => SubVideoProvider()),
        ChangeNotifierProvider(create: (_) => GuardianProvider()),
        ChangeNotifierProvider(create: (_) => BasicInfoProvider()),
        ChangeNotifierProvider(create: (_) => GenderProvider()),
        ChangeNotifierProvider(create: (_) => ProfileImageProvider()),
        ChangeNotifierProvider(create: (_) => AgeProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => ProfileUpdateProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    ); // <--- THIS was missing
  }
}
