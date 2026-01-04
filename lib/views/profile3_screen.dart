// import 'dart:io';
// import 'package:cognitive_quiz/providers/image_provider.dart';
// import 'package:cognitive_quiz/utills/colors.dart';
// import 'package:cognitive_quiz/utills/custom_image.dart';
// import 'package:cognitive_quiz/utills/images.dart';
// import 'package:cognitive_quiz/views/profile1_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// // import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';

// class ProfileScreen3 extends StatefulWidget {
//   const ProfileScreen3({super.key});

//   @override
//   State<ProfileScreen3> createState() => _ProfileScreen3State();
// }

// class _ProfileScreen3State extends State<ProfileScreen3> {
//   File? _pickedImage; // Store selected image
//   final ImagePicker _picker = ImagePicker();

//   // Pick image from gallery
//   Future<void> _pickImage() async {
//     final XFile? pickedFile = await _picker.pickImage(
//       source: ImageSource.gallery,
//     );

//     if (pickedFile != null) {
//       setState(() {
//         // _pickedImage = File(pickedFile.path);
//       });
//     }
//   }

//   // Upload image when Next button is clicked
//   Future<void> _uploadImage() async {
//     if (_pickedImage == null) return;

//     final profileProvider = Provider.of<ProfileImageProvider>(
//       context,
//       listen: false,
//     );
//     await profileProvider.addImage(_pickedImage!.path);

//     if (profileProvider.errorMessage != null) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text(profileProvider.errorMessage!)));
//     } else {
//       // ScaffoldMessenger.of(context).showSnackBar(
//       //   const SnackBar(content: Text("Image uploaded successfully!")),
//       // );
//       Get.snackbar(
//         "Success",
//         "Image uploaded Sucessfully",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: AppColors.transparent,
//         colorText: AppColors.black,
//       );
//       Get.to(HomeScreen());
//     }
//   }

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
//       body: Stack(
//         children: [
//           // Background image
//           SizedBox(
//             height: screenHeight,
//             width: screenWidth,
//             child: CustomImageContainer(
//               height: h(0.7),
//               width: w(2),
//               imageUrl: AppImages.profilebg,
//             ),
//           ),

//           // Skip button
//           Positioned(
//             top: 40,
//             right: 10,
//             child: GestureDetector(
//               onTap: () => Get.to(HomeScreen()),
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

//           // Bottom card
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Consumer<ProfileImageProvider>(
//               builder: (context, profileProvider, child) {
//                 return Container(
//                   width: double.infinity,
//                   height: screenHeight * 0.43,
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
//                         SizedBox(height: h(0.01)),
//                         Text(
//                           "Complete Your Profile",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: sp(18),
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.black,
//                             letterSpacing: 0.8,
//                           ),
//                         ),
//                         SizedBox(height: h(0.01)),
//                         Text(
//                           "Upload Picture",
//                           style: TextStyle(
//                             fontSize: sp(13),
//                             color: AppColors.grey,
//                           ),
//                         ),
//                         SizedBox(height: h(0.01)),

//                         // Image picker
//                         Expanded(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               GestureDetector(
//                                 onTap: _pickImage,
//                                 child: Container(
//                                   width: w(0.35),
//                                   height: w(0.35),
//                                   decoration: BoxDecoration(
//                                     border: Border.all(
//                                       color: AppColors.greytextfields,
//                                       width: 1.5,
//                                     ),
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(12),
//                                     child:
//                                         profileProvider.isLoading
//                                             ? const Center(
//                                               child:
//                                                   CircularProgressIndicator(),
//                                             )
//                                             : _pickedImage == null
//                                             ? Icon(
//                                               Icons.person,
//                                               size: sp(60),
//                                               color: AppColors.grey,
//                                             )
//                                             : Image.file(
//                                               _pickedImage!,
//                                               fit: BoxFit.cover,
//                                             ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(height: h(0.015)),
//                               GestureDetector(
//                                 onTap: _pickImage,
//                                 child: Text(
//                                   "Upload Your Picture",
//                                   style: TextStyle(
//                                     fontSize: sp(14),
//                                     color: AppColors.lightblue,
//                                     fontWeight: FontWeight.w600,
//                                     decoration: TextDecoration.underline,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),

//                         SizedBox(height: h(0.015)),

//                         // Buttons
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             SizedBox(
//                               width: screenWidth * 0.25,
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
//                                 onPressed: () => Get.back(),
//                                 child: Text(
//                                   "Back",
//                                   style: TextStyle(fontSize: sp(14)),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               width: screenWidth * 0.35,
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
//                                 onPressed: _uploadImage, // Upload image on Next
//                                 child: Text(
//                                   "Next",
//                                   style: TextStyle(
//                                     fontSize: sp(14),
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ImageSource {
//   static get gallery => null;
// }

// class XFile {
//   String? get path => null;
// }

// class ImagePicker {
//   Future<XFile?> pickImage({required source}) async {
//     return null;
//   }
// }