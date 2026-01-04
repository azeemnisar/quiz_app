import 'package:cognitive_quiz/providers/login_provider.dart';
import 'package:cognitive_quiz/utills/colors.dart';
import 'package:cognitive_quiz/utills/custom_image.dart';
import 'package:cognitive_quiz/utills/custom_textfields.dart';
import 'package:cognitive_quiz/utills/images.dart';
import 'package:cognitive_quiz/views/Guardian_screen.dart';
import 'package:cognitive_quiz/views/home_screen.dart';
import 'package:cognitive_quiz/views/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
// import 'package:quiz/provider/login_provider.dart';
// import 'package:quiz/utils/colors.dart';
// import 'package:quiz/utils/customimage.dart';
// import 'package:quiz/utils/customtextfields.dart';
// import 'package:quiz/utils/images.dart';
// import 'package:quiz/views/forgetemail_screen.dart';
// import 'package:quiz/views/guardian_screen.dart';
// import 'package:quiz/views/home_screen.dart';
// import 'package:quiz/views/signup_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // ✅ Access Provider
    final loginProvider = Provider.of<LoginProvider>(context);

    // 🔹 Responsive helpers
    double h(double value) => screenHeight * value; // % of height
    double w(double value) => screenWidth * value; // % of width
    double sp(double value) => screenWidth * (value / 390); // scale font

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // 🔹 Top Illustration
          SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: CustomImageContainer(
              height: h(0.7),
              width: w(2),
              imageUrl: AppImages.loginbg,
            ),
          ),

          // 🔹 Bottom Card
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: h(0.52),
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
                  horizontal: w(0.06),
                  vertical: h(0.02),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: h(0.01)),
                    Text(
                      "WELCOME TO COGNITIVE \nCOMPASS",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: sp(18),
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                        letterSpacing: 0.8,
                      ),
                    ),
                    SizedBox(height: h(0.005)),
                    Text(
                      "Login to your account",
                      style: TextStyle(
                        fontSize: sp(13),
                        color: AppColors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: h(0.02)),

                    // Email field
                    buildCustomTextField("Enter Email", emailController),
                    SizedBox(height: h(0.019)),

                    // Password field
                    buildCustomTextField(
                      "Enter Password",
                      passwordController,
                      obscure: true,
                    ),

                    SizedBox(height: h(0.01)),

                    // 🔹 Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SIGN UP button
                        SizedBox(
                          width: w(0.27),
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
                              Get.to(() => const SignUpScreen());
                            },
                            child: Text(
                              "SIGN UP",
                              style: TextStyle(
                                fontSize: sp(14),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: w(0.06)),

                        // SIGN IN button
                        SizedBox(
                          width: w(0.55),
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
                                loginProvider.isLoading
                                    ? null
                                    : () async {
                                      final email = emailController.text.trim();
                                      final password =
                                          passwordController.text.trim();

                                      if (email.isEmpty || password.isEmpty) {
                                        Get.snackbar(
                                          "Error",
                                          "Please enter email and password.",
                                          backgroundColor:
                                              AppColors.transparent,
                                          colorText: AppColors.black,
                                          snackPosition: SnackPosition.BOTTOM,
                                        );
                                        return;
                                      }

                                      await loginProvider.login(
                                        email,
                                        password,
                                      );

                                      final response =
                                          loginProvider.loginResponse;

                                      if (response != null &&
                                          response.success == true) {
                                        if (response.user.isProfile == 1) {
                                          // ✅ Go to Home if profile completed
                                          Get.offAll(() => const HomeScreen());
                                        } else {
                                          // ✅ Go to Guardian setup if not completed
                                          Get.offAll(
                                            () => const GuardianInfoScreen(),
                                          );
                                        }
                                      } else {
                                        Get.snackbar(
                                          "Login Failed",
                                          "Invalid email or password.",
                                          backgroundColor:
                                              AppColors.transparent,
                                          colorText: AppColors.black,
                                          snackPosition: SnackPosition.BOTTOM,
                                        );
                                      }
                                    },
                            child:
                                loginProvider.isLoading
                                    ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                    : Text(
                                      "SIGN IN",
                                      style: TextStyle(
                                        fontSize: sp(14),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: h(0.015)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.read<LoginProvider>().loginAsGuest();
                          },
                          child: Text(
                            "Guest user?",
                            style: TextStyle(
                              fontSize: sp(13),
                              color: AppColors.black,
                            ),
                          ),
                        ),

                        // TextButton(
                        //   onPressed: () {
                        //     Get.to(() => ForgetEmail());
                        //   },
                        //   child: Text(
                        //     "Forget password ?",
                        //     style: TextStyle(
                        //       fontSize: sp(13),
                        //       color: AppColors.black,
                        //     ),
                        //   ),
                        // ),
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
}
