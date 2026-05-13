import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants.dart';
import '../../core/config/app_config.dart';
import '../../core/utils/logger.dart';
import '../../services/firebase_service.dart';
import '../auth/app_down_screen.dart';
import '../home/home_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _initializeApp();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  Future<void> _initializeApp() async {
    try {
      AppLogger.info('🚀 Initializing app...');
      
      // Initialize Firebase
      final firebaseService = FirebaseService();
      await firebaseService.initialize();
      AppLogger.info('✅ Firebase initialized');

      // Fetch app config
      final configData = await firebaseService.fetchAppConfig();
      AppLogger.info('✅ App config fetched');

      // Get current version
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;
      AppLogger.info('📦 Current version: $currentVersion');

      // Check version and maintenance mode
      final config = ConfigManager().config;
      
      if (config.maintenanceMode) {
        AppLogger.warning('🔧 Maintenance mode is active');
        _navigateToAppDown('maintenance');
        return;
      }

      if (!ConfigManager().isVersionCompatible(currentVersion)) {
        AppLogger.warning('⚠️ Version mismatch');
        _navigateToAppDown('version');
        return;
      }

      AppLogger.info('✅ All checks passed');
      
      // Wait for animation to complete
      await Future.delayed(const Duration(seconds: 2));
      
      _navigateToHome();
    } catch (e) {
      AppLogger.error('❌ Initialization error: $e');
      _navigateToAppDown('error');
    }
  }

  void _navigateToHome() {
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  void _navigateToAppDown(String reason) {
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => AppDownScreen(reason: reason),
        ),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo/Brand
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [AppTheme.neonGreen, AppTheme.neonBlue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.neonGreen.withOpacity(0.3),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'BD',
                      style: TextStyle(
                        color: AppTheme.darkBg,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  AppConstants.appName,
                  style: TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Live Television Streaming',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 50),
                // Animated loading indicator
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color.lerp(
                            AppTheme.neonGreen,
                            AppTheme.neonBlue,
                            _animationController.value,
                          )!,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
