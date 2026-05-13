class AppConstants {
  // App Info
  static const String appName = 'Live BD TV';
  static const String appVersion = '1.0.0';

  // Firebase
  static const String firebaseConfigPath = 'app_config/v1_0_0';
  
  // API
  static const String apiVersion = 'v1_0_0';
  static const Duration apiTimeoutDuration = Duration(seconds: 30);

  // Cache
  static const Duration imagesCacheDuration = Duration(days: 30);
  static const Duration configCacheDuration = Duration(hours: 1);

  // Player
  static const double mobilePlayerHeightRatio = 0.40;
  static const Duration playerControlsVisibilityDuration = Duration(seconds: 5);

  // Layout
  static const double horizontalPadding = 16.0;
  static const double verticalPadding = 12.0;
  static const double borderRadius = 8.0;

  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 400);
  static const Duration longAnimationDuration = Duration(milliseconds: 600);

  // Error Messages
  static const String networkErrorMessage = 'নেটওয়ার্ক সংযোগ ব্যর্থ হয়েছে';
  static const String appDownMessage = 'অ্যাপ্লিকেশন বর্তমানে রক্ষণাবেক্ষণাধীন';
  static const String versionMismatchMessage = 'নতুন সংস্করণ উপলব্ধ রয়েছে';
}
