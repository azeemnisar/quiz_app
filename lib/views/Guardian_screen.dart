// import 'package:cognitive_quiz/providers/guardian_profile_provider.dart';
// import 'package:cognitive_quiz/utills/colors.dart';
// import 'package:cognitive_quiz/utills/custom_image.dart';
// import 'package:cognitive_quiz/utills/images.dart';
// import 'package:cognitive_quiz/views/basic_info.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// // import 'package:provider/provider.dart';
// // import 'package:quiz/provider/guardian_profile_provider.dart';
// // import 'package:quiz/utils/colors.dart';
// // import 'package:quiz/utils/customimage.dart';
// // import 'package:quiz/utils/images.dart';
// // import 'package:quiz/views/basic_info.dart';
// // import 'package:quiz/views/home_screen.dart';

// class GuardianInfoScreen extends StatefulWidget {
//   const GuardianInfoScreen({super.key});

//   @override
//   State<GuardianInfoScreen> createState() => _GuardianInfoScreenState();
// }

// class _GuardianInfoScreenState extends State<GuardianInfoScreen> {
//   final TextEditingController guardianNameController = TextEditingController();
//   final TextEditingController contactNumberController = TextEditingController();
//   final TextEditingController emergencyContactController =
//       TextEditingController();
//   final TextEditingController remarksController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;
//     final double screenHeight = MediaQuery.of(context).size.height;

//     double h(double value) => screenHeight * value;
//     double w(double value) => screenWidth * value;
//     double sp(double value) => screenWidth * (value / 390);

//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: AppColors.white,
//       body: Consumer<GuardianProvider>(
//         builder: (context, guardianProvider, child) {
//           return Stack(
//             children: [
//               SizedBox(
//                 height: screenHeight,
//                 width: screenWidth,
//                 child: CustomImageContainer(
//                   height: h(0.7),
//                   width: w(2),
//                   imageUrl: AppImages.profilebg,
//                 ),
//               ),

//               /// Skip Button (Top Right)
//               Positioned(
//                 top: 40,
//                 right: 10,
//                 child: GestureDetector(
//                   onTap: () => Get.to(() => const HomeScreen()),
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 14,
//                       vertical: 6,
//                     ),
//                     decoration: BoxDecoration(
//                       color: AppColors.white,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: const Text(
//                       "Skip",
//                       style: TextStyle(color: AppColors.black, fontSize: 14),
//                     ),
//                   ),
//                 ),
//               ),

//               /// Bottom Form
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Container(
//                   width: double.infinity,
//                   height: screenHeight * 0.52,
//                   decoration: const BoxDecoration(
//                     color: AppColors.white,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(25),
//                       topRight: Radius.circular(25),
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black26,
//                         blurRadius: 8,
//                         offset: Offset(0, -2),
//                       ),
//                     ],
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: screenWidth * 0.06,
//                       vertical: screenHeight * 0.02,
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Guardian Info",
//                           style: TextStyle(
//                             fontSize: sp(18),
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.black,
//                           ),
//                         ),
//                         SizedBox(height: h(0.02)),

//                         /// TextFields
//                         buildTextField("Guardian Name", guardianNameController),
//                         SizedBox(height: h(0.015)),
//                         buildTextField(
//                           "Contact Number",
//                           contactNumberController,
//                           keyboardType: TextInputType.phone,
//                         ),
//                         SizedBox(height: h(0.015)),
//                         buildTextField(
//                           "Emergency Contact",
//                           emergencyContactController,
//                           keyboardType: TextInputType.phone,
//                         ),
//                         SizedBox(height: h(0.015)),
//                         buildTextField(
//                           "Remarks",
//                           remarksController,
//                           maxLines: 3,
//                         ),

//                         const Spacer(),

//                         /// Buttons
//                         Row(
//                           children: [
//                             SizedBox(
//                               width: screenWidth * 0.45,
//                               child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: AppColors.white,
//                                   foregroundColor: AppColors.black,
//                                   side: const BorderSide(
//                                     color: AppColors.greytextfields,
//                                   ),
//                                   padding: EdgeInsets.symmetric(
//                                     vertical: h(0.018),
//                                   ),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(6),
//                                   ),
//                                 ),
//                                 onPressed: () => Get.to(() => HomeScreen()),
//                                 child: Text(
//                                   "Skip",
//                                   style: TextStyle(
//                                     fontSize: sp(14),
//                                     fontWeight: FontWeight.normal,
//                                     color: AppColors.black,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 16),
//                             SizedBox(
//                               width: screenWidth * 0.35,
//                               child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: AppColors.black,
//                                   foregroundColor: AppColors.white,
//                                   padding: EdgeInsets.symmetric(
//                                     vertical: h(0.018),
//                                   ),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(6),
//                                   ),
//                                 ),
//                                 onPressed:
//                                     guardianProvider.isLoading
//                                         ? null
//                                         : () async {
//                                           if (guardianNameController
//                                               .text
//                                               .isEmpty) {
//                                             Get.snackbar(
//                                               "Error",
//                                               "Please enter All data",
//                                               snackPosition:
//                                                   SnackPosition.BOTTOM,
//                                             );
//                                             return;
//                                           }

//                                           // ✅ Call provider method
//                                           await guardianProvider
//                                               .saveGuardianDetails(
//                                                 fatherName:
//                                                     guardianNameController.text,
//                                                 contactNumber:
//                                                     contactNumberController
//                                                         .text,
//                                                 emergencyContact:
//                                                     emergencyContactController
//                                                         .text,
//                                                 remarks: remarksController.text,
//                                               );

//                                           if (guardianProvider
//                                                   .guardianProfile !=
//                                               null) {
//                                             Get.snackbar(
//                                               "Success",
//                                               "Profile Created Successfully",
//                                             );
//                                             Get.to(() => BasicInfoScreen());
//                                           } else {
//                                             Get.snackbar(
//                                               "Error",
//                                               "Failed to save profile. Please try again",
//                                               snackPosition:
//                                                   SnackPosition.BOTTOM,
//                                             );
//                                           }
//                                         },

//                                 child:
//                                     guardianProvider.isLoading
//                                         ? const SizedBox(
//                                           height: 18,
//                                           width: 18,
//                                           child: CircularProgressIndicator(
//                                             strokeWidth: 2,
//                                             color: AppColors.white,
//                                           ),
//                                         )
//                                         : Text(
//                                           "Save",
//                                           style: TextStyle(
//                                             fontSize: sp(14),
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   Widget buildTextField(
//     String hint,
//     TextEditingController controller, {
//     TextInputType keyboardType = TextInputType.text,
//     int maxLines = 1,
//   }) {
//     return TextField(
//       controller: controller,
//       keyboardType: keyboardType,
//       maxLines: maxLines,
//       decoration: InputDecoration(
//         hintText: hint,
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 12,
//           vertical: 12,
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide: const BorderSide(color: AppColors.grey),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide: const BorderSide(color: AppColors.grey),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6),
//           borderSide: const BorderSide(color: AppColors.black),
//         ),
//       ),
//     );
//   }
// }
