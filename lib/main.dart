import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/constants.dart';
import 'core/utils/logger.dart';
import 'features/auth/splash_screen.dart';
import 'features/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Logger
  AppLogger.info('🚀 Initializing Live BD TV App...');
  
  runApp(
    const ProviderScope(
      child: LiveBDTVApp(),
    ),
  );
}

class LiveBDTVApp extends StatelessWidget {
  const LiveBDTVApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: AppTheme.darkTheme,
      home: const SplashScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
      },
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1.0, // Fixed text scale
          ),
          child: child ?? const SizedBox(),
        );
      },
    );
  }
}
