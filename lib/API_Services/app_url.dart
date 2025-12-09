class AppUrl {
  // static const String baseUrl = 'https://cf6a732c447c.ngrok-free.app/api';
  static const String baseUrl = 'https://cognitiveaudit.logicvalleyllc.us/api';
  static const String imageBaseUrl =
      'https://cognitiveaudit.logicvalleyllc.us/public';
  // login in section
  static const String login = '/login';
  static const String register = '/signup';
  static const String verifyOtp = '/otp';
  static const String resendotp = '';
  static const String forgetotp = '/forget-otp';
  static const String verify_forget_otp = '/verify-forget-otp';
  static const String forget_password_update = '/forgot-password';

  // video sections
  static const String getVideos = '/vedio';
  static const String getCategories = '/category';
  static const String sub_category = '/view-play-list';

  // profile sections
  static const String add_guardiandetails = '/guardian-profile';
  static const String add_basicinfo = '/basic-profile';
  static const String add_gender = '/gender-profile';
  static const String add_age = '/age-profile';
  static const String add_image = '/image-profile';
  static const String get_user_age = '/user-age-level';
  static const String get_profile = '/get-profile';
  static const String update_profile = '/update-profile';

  //quizzes section
  static const String show_all_quiz = '/all-quizes';
  static const String get_category_quiz = '/category-quiz';
  static const String get_questions = '/quizes-question';
  static const String post_question = '/quiz/submit';
  static const String get_perform_quiz = '/user-quiz';

  static const String getlevel = '/quiz-level';
  static const String add_level = '/level-profile';

  // messgaing
  static const String mesasging = '/send-message';
}
