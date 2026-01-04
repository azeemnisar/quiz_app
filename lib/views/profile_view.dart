import 'package:cognitive_quiz/API_Services/app_url.dart';
import 'package:cognitive_quiz/providers/age_provider.dart';
import 'package:cognitive_quiz/providers/gender_provider.dart';
import 'package:cognitive_quiz/providers/login_provider.dart';
import 'package:cognitive_quiz/providers/profile_provider.dart';
import 'package:cognitive_quiz/providers/profile_update_provider.dart';
import 'package:cognitive_quiz/utills/colors.dart';
import 'package:cognitive_quiz/views/home_screen.dart';
import 'package:cognitive_quiz/views/profile3_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({super.key});

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  bool isEditing = false;

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  OverlayEntry? _dropdownOverlay;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final profileProv = Provider.of<ProfileProvider>(context, listen: false);
      final ageProv = Provider.of<AgeProvider>(context, listen: false);
      await profileProv.fetchProfile();
      await ageProv.fetchAgeRanges();
    });
  }

  /// ✅ Fixed dropdown with outside tap detection and proper layering
  void _showDropdownBelowField({
    required BuildContext context,
    required List<String> items,
    required TextEditingController controller,
    required RenderBox renderBox,
    required double width,
  }) {
    _hideDropdown();

    final offset = renderBox.localToGlobal(Offset.zero);

    _dropdownOverlay = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // 🔹 Transparent area to close dropdown when tapped outside
            Positioned.fill(
              child: GestureDetector(
                onTap: _hideDropdown,
                behavior: HitTestBehavior.translucent,
                child: Container(color: Colors.transparent),
              ),
            ),

            // 🔹 Dropdown container
            Positioned(
              left: offset.dx,
              top: offset.dy + renderBox.size.height + 4,
              width: width,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  constraints: const BoxConstraints(
                    maxHeight: 200, // Limit dropdown height
                  ),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children:
                        items.map((item) {
                          return ListTile(
                            title: Text(item),
                            onTap: () {
                              controller.text = item;
                              _hideDropdown();
                              setState(() {});
                            },
                          );
                        }).toList(),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(_dropdownOverlay!);
  }

  void _hideDropdown() {
    _dropdownOverlay?.remove();
    _dropdownOverlay = null;
  }

  @override
  void dispose() {
    _hideDropdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final updateProvider = Provider.of<ProfileUpdateProvider>(context);
    final ageProvider = Provider.of<AgeProvider>(context);
    final genderProvider = Provider.of<GenderProvider>(context);

    final profile = profileProvider.profile;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double h(double v) => screenHeight * v;
    double w(double v) => screenWidth * v;
    double sp(double v) => screenWidth * (v / 390);

    if (profile != null && !isEditing) {
      phoneController.text = profile.emergencyContact;
      genderController.text = profile.gender;
      ageController.text = profile.age;
    }

    final isProfileNotFound =
        profileProvider.errorMessage != null &&
        profileProvider.errorMessage!.contains("Profile not found");

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          /// 🔙 Back Button
          Positioned(
            top: 40,
            left: 10,
            child: GestureDetector(
              onTap: () => Get.to(const HomeScreen()),
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.black,
                size: 26,
              ),
            ),
          ),

          /// 🧑‍🦱 Profile Image
          Positioned(
            top: h(0.10),
            child: Container(
              width: w(0.45),
              height: w(0.45),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.grey, width: 1),
                image: DecorationImage(
                  image:
                      profile != null && profile.image.isNotEmpty
                          ? NetworkImage(
                            profile.image.startsWith("http")
                                ? profile.image
                                : "${AppUrl.imageBaseUrl}${profile.image.startsWith('/') ? '' : '/'}${profile.image}",
                          )
                          : const NetworkImage(
                            "https://i.pravatar.cc/150?img=3",
                          ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          /// ✏️ Update Image Button
          Positioned(
            top: 40,
            right: 20,
            child: GestureDetector(
              onTap: () => Get.to(ProfileScreen3()),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Update Image",
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
            ),
          ),

          /// 📄 Profile Details Section
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: screenHeight * 0.60,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
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
                child:
                    profileProvider.isLoading || updateProvider.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : isProfileNotFound
                        ? _buildProfileNotFoundUI(context, sp, h, w)
                        : profile == null
                        ? Center(
                          child: Text(
                            profileProvider.errorMessage ??
                                "No profile data available",
                            style: const TextStyle(color: AppColors.black),
                          ),
                        )
                        : _buildProfileUI(
                          context,
                          updateProvider,
                          profile,
                          ageProvider,
                          genderProvider,
                          sp,
                          h,
                          w,
                          screenWidth,
                        ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Build Profile UI
  Widget _buildProfileUI(
    BuildContext context,
    ProfileUpdateProvider updateProvider,
    dynamic profile,
    AgeProvider ageProvider,
    GenderProvider genderProvider,
    double Function(double) sp,
    double Function(double) h,
    double Function(double) w,
    double screenWidth,
  ) {
    final genderOptions = ["Male", "Female", "Other"];
    final ageOptions =
        ageProvider.ageRanges.map((r) => r.range ?? "Unknown").toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: h(0.07)),

        /// 📞 Phone
        _buildTextFieldRow(
          context,
          icon: Icons.phone,
          label: "Phone",
          controller: phoneController,
          enabled: isEditing,
          dropdownItems: [],
          sp: sp,
          h: h,
          w: w,
        ),
        SizedBox(height: h(0.015)),

        /// 🚻 Gender
        _buildTextFieldRow(
          context,
          icon: Icons.wc,
          label: "Gender",
          controller: genderController,
          enabled: isEditing,
          dropdownItems: genderOptions,
          sp: sp,
          h: h,
          w: w,
        ),
        SizedBox(height: h(0.015)),

        /// ⏳ Age
        _buildTextFieldRow(
          context,
          icon: Icons.hourglass_bottom,
          label: "Age Group",
          controller: ageController,
          enabled: isEditing,
          dropdownItems: ageOptions,
          sp: sp,
          h: h,
          w: w,
        ),
        SizedBox(height: h(0.09)),

        /// Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: screenWidth * 0.35,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  foregroundColor: AppColors.black,
                  side: const BorderSide(color: AppColors.greytextfields),
                  padding: EdgeInsets.symmetric(vertical: h(0.018)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () async {
                  if (isEditing) {
                    await updateProvider.updateProfile(
                      fEmergencyContact: phoneController.text.trim(),
                      sGender: genderController.text.trim(),
                      sAge: ageController.text.trim(),
                      sLevel: profile.level,
                    );

                    await Provider.of<ProfileProvider>(
                      context,
                      listen: false,
                    ).fetchProfile();

                    if (updateProvider.profileResponse != null &&
                        updateProvider.profileResponse!.success) {
                      Get.snackbar(
                        "Success",
                        "Profile updated successfully",
                        backgroundColor: AppColors.transparent,
                        colorText: AppColors.black,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  }
                  setState(() => isEditing = !isEditing);
                },
                child: Text(
                  isEditing ? "Save" : "Edit Details",
                  style: TextStyle(fontSize: sp(14)),
                ),
              ),
            ),
            _logoutButton(screenWidth, h, sp),
          ],
        ),
      ],
    );
  }

  /// 🔹 TextField Row with Optional Dropdown
  Widget _buildTextFieldRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required TextEditingController controller,
    required bool enabled,
    required List<String> dropdownItems,
    required double Function(double) sp,
    required double Function(double) h,
    required double Function(double) w,
  }) {
    final hasDropdown = dropdownItems.isNotEmpty;
    final fieldKey = GlobalKey();

    return Container(
      key: fieldKey,
      height: h(0.07),
      padding: EdgeInsets.symmetric(horizontal: w(0.04)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.grey, width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.lightblue, size: sp(22)),
          SizedBox(width: w(0.04)),
          Expanded(
            child: GestureDetector(
              onTap:
                  enabled && hasDropdown
                      ? () {
                        final renderBox =
                            fieldKey.currentContext!.findRenderObject()
                                as RenderBox;
                        _showDropdownBelowField(
                          context: context,
                          items: dropdownItems,
                          controller: controller,
                          renderBox: renderBox,
                          width: renderBox.size.width,
                        );
                      }
                      : null,
              child: AbsorbPointer(
                absorbing: hasDropdown,
                child: TextField(
                  controller: controller,
                  enabled: enabled,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter $label",
                  ),
                  style: TextStyle(fontSize: sp(14), color: AppColors.black),
                ),
              ),
            ),
          ),
          if (enabled && hasDropdown)
            Icon(Icons.arrow_drop_down, color: Colors.grey, size: sp(22)),
        ],
      ),
    );
  }

  /// 🔹 Profile Not Found
  Widget _buildProfileNotFoundUI(
    BuildContext context,
    double Function(double) sp,
    double Function(double) h,
    double Function(double) w,
  ) {
    return const Center(child: Text("Profile not found. Please create one."));
  }

  /// 🔹 Logout Button
  Widget _logoutButton(
    double screenWidth,
    double Function(double) h,
    double Function(double) sp,
  ) {
    return SizedBox(
      width: screenWidth * 0.35,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.black,
          side: const BorderSide(color: AppColors.greytextfields),
          padding: EdgeInsets.symmetric(vertical: h(0.018)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        onPressed:
            () => Provider.of<LoginProvider>(context, listen: false).logout(),
        child: Text(
          "Logout",
          style: TextStyle(fontSize: sp(14), fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
