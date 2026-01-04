// import 'package:cognitive_quiz/providers/age_provider.dart';
// import 'package:cognitive_quiz/utills/colors.dart';
// import 'package:cognitive_quiz/utills/custom_image.dart';
// import 'package:cognitive_quiz/utills/images.dart';
// import 'package:cognitive_quiz/views/profile1_screen.dart';
// import 'package:cognitive_quiz/views/profile3_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';


// class ProfileScreen2 extends StatefulWidget {
//   const ProfileScreen2({super.key});

//   @override
//   State<ProfileScreen2> createState() => _ProfileScreen2State();
// }

// class _ProfileScreen2State extends State<ProfileScreen2> {
//   RangeModel? selectedAgeRange;

//   @override
//   void initState() {
//     super.initState();
//     // Fetch age ranges when screen loads
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<AgeProvider>(context, listen: false).fetchAgeRanges();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;
//     final double screenHeight = MediaQuery.of(context).size.height;

//     double h(double value) => screenHeight * value;
//     double w(double value) => screenWidth * value;
//     double sp(double value) => screenWidth * (value / 390);

//     final ageProvider = Provider.of<AgeProvider>(context);

//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: AppColors.white,
//       body: Stack(
//         children: [
//           // Background Image
//           SizedBox(
//             height: screenHeight,
//             width: screenWidth,
//             child: CustomImageContainer(
//               height: h(0.7),
//               width: w(2),
//               imageUrl: AppImages.profilebg,
//             ),
//           ),

//           // Skip Button
//           Positioned(
//             top: 40,
//             right: 10,
//             child: GestureDetector(
//               onTap: () {
//                 Get.to(HomeScreen());
//               },
//               child: Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 14,
//                   vertical: 6,
//                 ),
//                 decoration: BoxDecoration(
//                   color: AppColors.white,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: const Text(
//                   "Skip",
//                   style: TextStyle(color: AppColors.black, fontSize: 14),
//                 ),
//               ),
//             ),
//           ),

//           // Bottom Container
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               width: double.infinity,
//               height: screenHeight * 0.43,
//               decoration: const BoxDecoration(
//                 color: AppColors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(25),
//                   topRight: Radius.circular(25),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 8,
//                     offset: Offset(0, -2),
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: screenWidth * 0.06,
//                   vertical: screenHeight * 0.02,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(height: h(0.01)),
//                     Text(
//                       "Complete Your Profile",
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
//                       "Select Your Age Group",
//                       style: TextStyle(fontSize: sp(13), color: AppColors.grey),
//                     ),
//                     SizedBox(height: h(0.03)),

//                     // Age Group Options
//                     Expanded(
//                       child:
//                           ageProvider.isLoading
//                               ? const Center(child: CircularProgressIndicator())
//                               : ageProvider.ageRanges.isEmpty
//                               ? const Center(child: Text("No age ranges found"))
//                               : SingleChildScrollView(
//                                 child: Wrap(
//                                   spacing: w(0.03),
//                                   runSpacing: h(0.02),
//                                   children:
//                                       ageProvider.ageRanges
//                                           .map(
//                                             (range) =>
//                                                 ageGroupCard(range, sp, h, w),
//                                           )
//                                           .toList(),
//                                 ),
//                               ),
//                     ),

//                     SizedBox(height: h(0.02)),

//                     // Buttons
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         SizedBox(
//                           width: screenWidth * 0.25,
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
//                             onPressed: () => Get.back(),
//                             child: Text(
//                               "Back",
//                               style: TextStyle(fontSize: sp(14)),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: screenWidth * 0.35,
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
//                                 ageProvider.isLoading
//                                     ? null
//                                     : () async {
//                                       if (selectedAgeRange == null) {
//                                         Get.snackbar(
//                                           "Error",
//                                           "Please select an age group",
//                                           snackPosition: SnackPosition.BOTTOM,
//                                         );
//                                         return;
//                                       }

//                                       await ageProvider.addAge(
//                                         age: selectedAgeRange!.range,
//                                       );

//                                       if (ageProvider.profile != null) {
//                                         Get.to(ProfileScreen3());
//                                       } else {
//                                         Get.snackbar(
//                                           "Error",
//                                           "Failed to update age",
//                                           snackPosition: SnackPosition.BOTTOM,
//                                         );
//                                       }
//                                     },
//                             child:
//                                 ageProvider.isLoading
//                                     ? const CircularProgressIndicator(
//                                       color: AppColors.black,
//                                     )
//                                     : Text(
//                                       "Next",
//                                       style: TextStyle(
//                                         fontSize: sp(14),
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
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

//   // Helper Widget for Age Group Card
//   Widget ageGroupCard(
//     RangeModel range,
//     double Function(double) sp,
//     double Function(double) h,
//     double Function(double) w,
//   ) {
//     final bool isSelected = selectedAgeRange?.id == range.id;

//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedAgeRange = range;
//         });
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: w(0.04), vertical: h(0.015)),
//         decoration: BoxDecoration(
//           color: isSelected ? AppColors.grey : AppColors.transparent,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: isSelected ? AppColors.black : AppColors.greytextfields,
//             width: 1.2,
//           ),
//         ),
//         child: Text(
//           range.range,
//           style: TextStyle(
//             fontSize: sp(14),
//             fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//             color: AppColors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }