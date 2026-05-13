import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants.dart';
import '../../core/utils/responsive_helper.dart';
import '../../providers.dart';
import '../../widgets/widgets.dart';
import 'home_screen_mobile.dart';
import 'home_screen_tv.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      body: ResponsiveHelper.isTV(context)
          ? const HomeScreenTV()
          : const HomeScreenMobile(),
    );
  }
}
