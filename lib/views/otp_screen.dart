import 'package:cognitive_quiz/providers/otp_provider.dart';
import 'package:cognitive_quiz/utills/colors.dart';
import 'package:cognitive_quiz/utills/custom_image.dart';
import 'package:cognitive_quiz/utills/images.dart';
import 'package:cognitive_quiz/views/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  final String email; // ✅ Accept email

  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> otpControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(
    4,
    (index) => FocusNode(),
  ); // ✅ Focus for each box

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    double h(double value) => screenHeight * value;
    double w(double value) => screenWidth * value;
    double sp(double value) => screenWidth * (value / 390);

    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // 🔹 Background Illustration
          SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: CustomImageContainer(
              height: h(0.7),
              width: w(2),
              imageUrl: AppImages.emailbg,
            ),
          ),

          // 🔹 Bottom Card
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: h(0.40),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black,
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
                      "Verify Your Email",
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
                      "Enter verification code that sent on your email",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: sp(13),
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: h(0.03)),

                    // 🔹 OTP Boxes
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(4, (index) {
                        return SizedBox(
                          width: screenWidth * 0.17,
                          child: TextField(
                            controller: otpControllers[index],
                            focusNode: focusNodes[index],
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 3) {
                                FocusScope.of(context).requestFocus(
                                  focusNodes[index + 1],
                                ); // move forward
                              } else if (value.isEmpty && index > 0) {
                                FocusScope.of(context).requestFocus(
                                  focusNodes[index - 1],
                                ); // move back
                              }
                            },
                            decoration: InputDecoration(
                              counterText: "",
                              filled: true,
                              fillColor: AppColors.white,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: h(0.018),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: AppColors.greytextfields,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: AppColors.black,
                                  width: 1.2,
                                ),
                              ),
                            ),
                            style: TextStyle(
                              fontSize: sp(18),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }),
                    ),

                    SizedBox(height: h(0.04)),

                    // 🔹 Buttons (VERIFY & RESEND)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // VERIFY
                        SizedBox(
                          width: screenWidth * 0.55,
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
                            onPressed: () async {
                              final otp =
                                  otpControllers.map((c) => c.text).join();

                              if (otp.length == 4) {
                                final otpProvider = Provider.of<OtpProvider>(
                                  context,
                                  listen: false,
                                );
                                await otpProvider.verifyOtp(
                                  otp,
                                  widget
                                      .email, // email passed from login/signup screen
                                );

                                if (otpProvider.otpResponse != null &&
                                    otpProvider.otpResponse!.success) {
                                  Get.snackbar(
                                    "Success",
                                    otpProvider.otpResponse!.message,
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                  Get.to(Login()); // ✅ Navigate to login
                                } else {
                                  Get.snackbar(
                                    "Error",
                                    otpProvider.errorMessage ?? "Invalid OTP",
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                }
                              } else {
                                Get.snackbar(
                                  "Error",
                                  "Please enter all 4 digits",
                                  snackPosition: SnackPosition.BOTTOM,
                                  colorText: AppColors.black,
                                  backgroundColor: AppColors.transparent,
                                );
                              }
                            },

                            child: Text(
                              "VERIFY",
                              style: TextStyle(
                                fontSize: sp(14),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: w(0.05)),
                        // RESEND
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              foregroundColor: AppColors.black,
                              side: const BorderSide(
                                color: AppColors.greytextfields,
                              ),
                              padding: EdgeInsets.symmetric(vertical: h(0.018)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "RESEND",
                              style: TextStyle(
                                fontSize: sp(14),
                                fontWeight: FontWeight.normal,
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
}
