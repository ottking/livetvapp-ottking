import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants.dart';
import '../../widgets/widgets.dart';

class AppDownScreen extends StatelessWidget {
  final String reason;

  const AppDownScreen({
    required this.reason,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.horizontalPadding,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Error Icon with gradient
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.neonRed.withOpacity(0.3),
                      AppTheme.neonRed.withOpacity(0.1),
                    ],
                  ),
                ),
                child: const Icon(
                  Icons.construction_outlined,
                  color: AppTheme.neonRed,
                  size: 50,
                ),
              ),
              const SizedBox(height: 40),

              // Title
              Text(
                _getTitle(),
                style: const TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Description
              Text(
                _getDescription(),
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 16,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),

              // Action Button
              if (reason == 'version')
                Column(
                  children: [
                    GradientButton(
                      label: 'আপডেট ডাউনলোড করুন',
                      onPressed: () {
                        // Open Play Store or App Store
                        // Implementation depends on your app store links
                      },
                      width: double.infinity,
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    Text(
                      '${AppConstants.appName} শীঘ্রই ফিরে আসবে',
                      style: const TextStyle(
                        color: AppTheme.neonGreen,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('পুনরায় চেষ্টা করুন'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.neonBlue,
                        foregroundColor: AppTheme.darkBg,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _getTitle() {
    switch (reason) {
      case 'version':
        return 'নতুন সংস্করণ উপলব্ধ';
      case 'maintenance':
        return 'রক্ষণাবেক্ষণাধীন';
      default:
        return 'অপ্রত্যাশিত ত্রুটি';
    }
  }

  String _getDescription() {
    switch (reason) {
      case 'version':
        return 'দয়া করে সর্বশেষ সংস্করণে আপডেট করুন নতুন বৈশিষ্ট্য এবং উন্নতির জন্য।';
      case 'maintenance':
        return '${AppConstants.appName} বর্তমানে রক্ষণাবেক্ষণাধীন। আমরা শীঘ্রই ফিরে আসছি।';
      default:
        return 'দুঃখিত, কিছু ত্রুটি হয়েছে। অনুগ্রহ করে পুনরায় চেষ্টা করুন।';
    }
  }
}
