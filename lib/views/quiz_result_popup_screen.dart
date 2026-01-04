import 'package:cognitive_quiz/utills/colors.dart';
import 'package:cognitive_quiz/utills/custom_image.dart';
import 'package:cognitive_quiz/utills/images.dart';
import 'package:cognitive_quiz/views/quizzes_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';

class QuizResultPopupScreen extends StatefulWidget {
  final String category;
  final int totalQuestions;
  final int attempted;
  final int correct;
  final double percentage;
  final String? aiResponse;
  final String? detailedAnalysis;
  final String? recomendations;
  final VoidCallback onClose;

  const QuizResultPopupScreen({
    super.key,
    required this.category,
    required this.totalQuestions,
    required this.attempted,
    required this.correct,
    required this.percentage,
    required this.onClose,
    this.aiResponse,
    this.detailedAnalysis,
    this.recomendations,
  });

  @override
  State<QuizResultPopupScreen> createState() => _QuizResultPopupScreenState();
}

class _QuizResultPopupScreenState extends State<QuizResultPopupScreen> {
  bool _showAiResponse = false;
  bool _expanded = false;

  /// 🔹 Parse category recommendations text into a map
  Map<String, String> _parseRecommendations(String text) {
    final Map<String, String> result = {};
    final cleaned =
        text
            .replaceAll("category_recommendations[", "")
            .replaceAll("]", "")
            .trim();

    final lines = cleaned.split(RegExp(r'[\n\r]+'));
    for (var line in lines) {
      if (line.contains(":")) {
        final parts = line.split(":");
        final key = parts[0].trim();
        final value = parts.sublist(1).join(":").trim();
        result[key] = value;
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final String? detailed = widget.detailedAnalysis;
    final bool hasLongText = detailed != null && detailed.length > 500;
    final String previewText =
        hasLongText ? "${detailed!.substring(0, 500)}..." : (detailed ?? "");

    Map<String, String>? parsedRecs;
    if (widget.recomendations != null &&
        widget.recomendations!.contains("category_recommendations")) {
      parsedRecs = _parseRecommendations(widget.recomendations!);
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: AppColors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        width: 323,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xfffefefe), Color(0xfffef7f7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// 🔹 Image + Close Icon Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 10),
                  CustomImageContainer(
                    height: screenHeight * 0.1,
                    width: screenWidth * 0.2,
                    imageUrl: AppImages.result_image,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.black,
                      size: 24,
                    ),
                    onPressed: () {
                      widget.onClose();
                      Get.off(() => Quizzes());
                    },
                  ),
                ],
              ),

              const SizedBox(height: 10),

              /// 🔹 Category Tag
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xfff5d8d8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  widget.category,
                  style: const TextStyle(
                    color: AppColors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "🎉 Congratulations 🎉",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),

              const SizedBox(height: 20),

              /// 🔹 Result Details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildResultRow(
                    "Total Questions",
                    "${widget.totalQuestions}",
                  ),
                  _buildResultRow("Attempted", "${widget.attempted}"),
                  _buildResultRow("Correct", "${widget.correct}"),
                  _buildResultRow(
                    "Percentage",
                    "${widget.percentage.toStringAsFixed(1)}%",
                  ),
                ],
              ),

              const SizedBox(height: 25),

              /// 🔹 Buttons Row (View AI, See Doctor, Close)
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _showAiResponse = !_showAiResponse;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff4c6ef5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        _showAiResponse ? "AI Response" : "AI Response",
                        style: const TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  /// 👇 New "See Doctor" Button
                  // ElevatedButton(
                  //   onPressed: () {
                  //     final doctorRec =
                  //         parsedRecs?['doctor_recommendations'] ?? '';
                  //     if (doctorRec.isNotEmpty) {
                  //       final doctorList =
                  //           doctorRec
                  //               .split(',')
                  //               .map((d) => d.trim())
                  //               .where((d) => d.isNotEmpty)
                  //               .toList();

                  //       // 👇 Navigate to GoogleMapPage and pass doctor list
                  //       // Get.to(
                  //       //   () =>
                  //       //       GoogleMapPage(doctorRecommendations: doctorList),
                  //       // );
                  //     } else {
                  //       ScaffoldMessenger.of(context).showSnackBar(
                  //         const SnackBar(
                  //           content: Text(
                  //             "No doctor recommendations available.",
                  //           ),
                  //         ),
                  //       );
                  //     }
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.green,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     padding: const EdgeInsets.symmetric(
                  //       horizontal: 16,
                  //       vertical: 12,
                  //     ),
                  //   ),
                  //   child: const Text(
                  //     "See Doctor",
                  //     style: TextStyle(
                  //       color: AppColors.white,
                  //       fontWeight: FontWeight.w600,
                  //       fontSize: 14,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: widget.onClose,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      "Close",
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),

              /// 🔹 Expandable AI Response Section
              if (_showAiResponse &&
                  (widget.aiResponse != null ||
                      widget.detailedAnalysis != null ||
                      widget.recomendations != null)) ...[
                const SizedBox(height: 25),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xfff1f4ff),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xffdce0f0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.aiResponse != null) ...[
                        const Text(
                          "AI Feedback:",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.aiResponse!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.black,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 15),
                      ],
                      if (widget.detailedAnalysis != null) ...[
                        const Text(
                          "Detailed Analysis:",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        MarkdownBody(
                          data: _expanded ? detailed! : previewText,
                          styleSheet: MarkdownStyleSheet(
                            p: const TextStyle(
                              fontSize: 14,
                              color: AppColors.black,
                              height: 1.5,
                            ),
                            strong: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        if (hasLongText)
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  _expanded = !_expanded;
                                });
                              },
                              child: Text(
                                _expanded ? "Read less" : "Read more",
                                style: const TextStyle(
                                  color: Color(0xff4c6ef5),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 15),
                      ],

                      /// 🔹 Parsed Recommendations Display
                      if (parsedRecs != null && parsedRecs.isNotEmpty) ...[
                        const Text(
                          "Category Recommendations:",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        for (var entry in parsedRecs.entries)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "${entry.key}: ",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  TextSpan(
                                    text: entry.value,
                                    style: const TextStyle(
                                      color: AppColors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 Helper for result rows
  Widget _buildResultRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.lightblue,
            ),
          ),
        ],
      ),
    );
  }
}
