// import 'package:cognitive_quiz/controller/register_controller.dart';
// import 'package:cognitive_quiz/utills/colors.dart';
// import 'package:cognitive_quiz/utills/custom_image.dart';
// import 'package:cognitive_quiz/utills/custom_textfields.dart';
// import 'package:cognitive_quiz/utills/images.dart';
// import 'package:cognitive_quiz/views/otp_screen.dart';
// import 'package:cognitive_quiz/views/signin_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   /// 🔹 Handle Register
//   Future<void> _register(BuildContext context) async {
//     final provider = Provider.of<RegisterProvider>(context, listen: false);

//     final success = await provider.registerUser(
//       email: emailController.text.trim(),
//       password: passwordController.text.trim(),
//     );

//     if (success) {
//       if (success) {
//         Get.to(
//           () => OtpScreen(email: emailController.text.trim()),
//         ); // ✅ pass email
//         // ScaffoldMessenger.of(context).showSnackBar(
//         //   SnackBar(
//         //     content: Text(
//         //       "✅ ${provider.registerModel?.message}\nWelcome, ${provider.registerModel?.user?.email}",
//         //     ),
//         //     backgroundColor: Colors.green,
//         //   )
//         // ,
//       }

//       Get.snackbar(
//         "Sucess",
//         "Sign up sucessfully now verify your email",
//         colorText: AppColors.black,
//         backgroundColor: AppColors.transparent,
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } else {
//       Get.snackbar(
//         "Failed",
//         "Plz check the authenticate email",
//         colorText: AppColors.black,
//         backgroundColor: AppColors.transparent,
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<RegisterProvider>(context);
//     final double screenWidth = MediaQuery.of(context).size.width;
//     final double screenHeight = MediaQuery.of(context).size.height;

//     // 🔹 Responsive helpers
//     double h(double value) => screenHeight * value;
//     double w(double value) => screenWidth * value;
//     double sp(double value) => screenWidth * (value / 390);

//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: AppColors.white,
//       body: Stack(
//         children: [
//           // 🔹 Top Illustration
//           SizedBox(
//             height: screenHeight,
//             width: screenWidth,
//             child: CustomImageContainer(
//               height: h(0.7),
//               width: w(2),
//               imageUrl: AppImages.loginbg,
//             ),
//           ),

//           // 🔹 Bottom Card
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               width: double.infinity,
//               height: h(0.43),
//               decoration: const BoxDecoration(
//                 color: AppColors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(25),
//                   topRight: Radius.circular(25),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppColors.black,
//                     blurRadius: 8,
//                     offset: Offset(0, -2),
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: w(0.06),
//                   vertical: h(0.02),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(height: h(0.01)),
//                     Text(
//                       "WELCOME TO COGNITIVE COMPASS",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: sp(18),
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.black,
//                         letterSpacing: 0.8,
//                       ),
//                     ),
//                     SizedBox(height: h(0.005)),
//                     Text(
//                       "Create Your Account",
//                       style: TextStyle(
//                         fontSize: sp(13),
//                         color: AppColors.black,
//                         fontWeight: FontWeight.normal,
//                       ),
//                     ),
//                     SizedBox(height: h(0.02)),

//                     // Email field
//                     buildCustomTextField("Enter Email", emailController),
//                     SizedBox(height: screenHeight * 0.019),

//                     // Password field
//                     buildCustomTextField(
//                       "Enter Password",
//                       passwordController,
//                       obscure: true,
//                     ),

//                     SizedBox(height: h(0.025)),

//                     // 🔹 Buttons
//                     Row(
//                       children: [
//                         // SIGN UP BUTTON
//                         SizedBox(
//                           width: screenWidth * 0.55,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: AppColors.white,
//                               foregroundColor: AppColors.black,
//                               side: const BorderSide(
//                                 color: AppColors.greytextfields,
//                               ),
//                               padding: EdgeInsets.symmetric(vertical: h(0.018)),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(6),
//                               ),
//                             ),
//                             onPressed:
//                                 provider.isLoading
//                                     ? null
//                                     : () => _register(context),
//                             child:
//                                 provider.isLoading
//                                     ? const SizedBox(
//                                       height: 20,
//                                       width: 20,
//                                       child: CircularProgressIndicator(
//                                         strokeWidth: 2,
//                                         color: AppColors.black,
//                                       ),
//                                     )
//                                     : Text(
//                                       "SIGN UP",
//                                       style: TextStyle(
//                                         fontSize: sp(14),
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                           ),
//                         ),

//                         SizedBox(width: w(0.06)),

//                         // SIGN IN BUTTON
//                         SizedBox(
//                           width: screenWidth * 0.27,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: AppColors.white,
//                               foregroundColor: AppColors.black,
//                               side: const BorderSide(
//                                 color: AppColors.greytextfields,
//                               ),
//                               padding: EdgeInsets.symmetric(vertical: h(0.018)),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(6),
//                               ),
//                             ),
//                             onPressed: () {
//                               Get.to(() => const Login());
//                             },
//                             child: Text(
//                               "SIGN IN",
//                               style: TextStyle(
//                                 fontSize: sp(14),
//                                 fontWeight: FontWeight.normal,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
