# Live BD TV - ডেভেলপমেন্ট গাইড

## 📖 শুরু করার আগে

১. **Flutter ইনস্টল করুন** (3.24+)
```bash
flutter --version
```

২. **প্রজেক্ট ক্লোন করুন**
```bash
git clone <repository-url>
cd live_bd_tv
```

৩. **ডিপেন্ডেন্সি ইনস্টল করুন**
```bash
flutter pub get
```

## 🔨 ডেভেলপমেন্ট কমান্ডস

### চালান
```bash
# একটি ডিভাইসে
flutter run

# ডিবাগ মোডে
flutter run --debug

# রিলিজ মোডে
flutter run --release

# একটি নির্দিষ্ট ডিভাইসে
flutter run -d <device-id>

# সব ডিভাইসে
flutter run -d all
```

### টেস্ট
```bash
# সব টেস্ট চালান
flutter test

# কভারেজ রিপোর্ট
flutter test --coverage

# ওয়াচ মোডে (ফাইল পরিবর্তনে পুনরায় চালান)
flutter test --watch
```

### বিল্ড
```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release

# App Bundle (Play Store)
flutter build appbundle --release

# সব আর্টিফ্যাক্ট পরিষ্কার করুন
flutter clean
```

### কোড জেনারেশন
```bash
# Riverpod কোড জেনারেট করুন
flutter pub run build_runner build

# --delete-conflicting-outputs ফ্ল্যাগ দিয়ে
flutter pub run build_runner build --delete-conflicting-outputs

# ওয়াচ মোডে
flutter pub run build_runner watch
```

## 🏗️ প্রজেক্ট স্ট্রাকচার মেনে চলা

### নতুন ফিচার যোগ করার সময়
1. `features/` এ নতুন ফোল্ডার তৈরি করুন
2. Model, Service, UI কম্পোনেন্ট আলাদা রাখুন
3. Riverpod Provider `providers.dart` এ যোগ করুন
4. ডকুমেন্টেশন আপডেট করুন

### নামকরণ নিয়ম
```dart
// ফাইল নামকরণ: snake_case
file_name.dart

// ক্লাস নামকরণ: PascalCase
class MyClass { }

// ভেরিয়েবল/ফাংশন নামকরণ: camelCase
final myVariable;
void myFunction() { }

// কনস্ট্যান্ট: UPPER_SNAKE_CASE
const MY_CONSTANT = 'value';
```

## 📝 কোডিং স্ট্যান্ডার্ড

### ইম্পোর্ট অর্ডার
```dart
// 1. Dart imports
import 'dart:async';
import 'package:flutter/material.dart';

// 2. Package imports
import 'package:riverpod/riverpod.dart';

// 3. Relative imports
import '../core/theme/app_theme.dart';
```

### নাল সেফটি
```dart
// Good
final String? optionalValue;
final String requiredValue; // Must be initialized

// Use ?? operator
final value = nullableValue ?? defaultValue;

// Use late if you're sure
late final String lateValue;
```

### কনস্ট কনস্ট্রাক্টর
```dart
// Good - সবসময় const ব্যবহার করুন
const SizedBox(height: 16)

// যখন মুটেবল পার্টস থাকে
GestureDetector(
  onTap: () { },
)
```

## 🐛 ডিবাগিং

### লগিং
```dart
import '../../core/utils/logger.dart';

AppLogger.debug('Debug message');
AppLogger.info('Info message');
AppLogger.warning('Warning message');
AppLogger.error('Error message');
AppLogger.wtf('What a terrible failure');
```

### Flutter DevTools
```bash
flutter pub global activate devtools
flutter pub global run devtools
```

### Hot Reload
```bash
# চলমান অ্যাপে:
r - Hot reload
R - Hot restart
q - Quit
```

## 🧪 টেস্টিং

### ইউনিট টেস্ট
```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Channel Model', () {
    test('should create channel from JSON', () {
      final json = {
        'id': 'ch1',
        'name': 'Test Channel',
        // ...
      };
      
      final channel = Channel.fromJson(json);
      
      expect(channel.id, 'ch1');
      expect(channel.name, 'Test Channel');
    });
  });
}
```

### উইজেট টেস্ট
```dart
void main() {
  testWidgets('GradientButton should render', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GradientButton(
            label: 'Test',
            onPressed: () { },
          ),
        ),
      ),
    );
    
    expect(find.text('Test'), findsOneWidget);
  });
}
```

## 📦 ডিপেন্ডেন্সি ম্যানেজমেন্ট

### নতুন প্যাকেজ যোগ করা
```bash
flutter pub add package_name

# নির্দিষ্ট ভার্সন
flutter pub add package_name:^1.2.0
```

### ডিপেন্ডেন্সি আপডেট
```bash
# সব প্যাকেজ আপডেট করুন
flutter pub upgrade

# নির্দিষ্ট প্যাকেজ আপডেট করুন
flutter pub upgrade package_name

# ক্যাশ পরিষ্কার করুন
flutter pub cache clean
```

## 🎨 থিম কাস্টমাইজেশন

সব রঙ কাস্টমাইজ করতে `lib/core/theme/app_theme.dart` এ যান:

```dart
static const Color darkBg = Color(0xFF0F0F0F);      // Background
static const Color neonGreen = Color(0xFF00FF88);  // Primary
static const Color neonRed = Color(0xFFFF0055);    // Secondary
```

## 🔑 এনভায়রনমেন্ট ভেরিয়েবল

আপনার প্রজেক্ট রুটে `.env` ফাইল তৈরি করুন:

```
FIREBASE_DATABASE_URL=https://...firebaseio.com
API_SECRET=your_secret_key
```

## 🚀 পারফরম্যান্স টিপস

1. **ইমেজ অপটিমাইজ করুন**
   - 300x450px এর বেশি ছোট রাখুন
   - WebP ফরম্যাট ব্যবহার করুন যখন সম্ভব

2. **ListViews অপটিমাইজ করুন**
   - `.builder` ব্যবহার করুন
   - `addAutomaticKeepAlives: false` চেষ্টা করুন

3. **Animations সীমিত করুন**
   - 600ms এর চেয়ে দীর্ঘ এড়িয়ে চলুন
   - `SingleTickerProviderStateMixin` ব্যবহার করুন

4. **Memory ম্যানেজমেন্ট**
   - Controllers সবসময় dispose করুন
   - Subscriptions cancel করুন

## 🔗 দরকারি রিসোর্স

- [Flutter Documentation](https://flutter.dev/docs)
- [Riverpod Guide](https://riverpod.dev)
- [Firebase Flutter Setup](https://firebase.flutter.dev)
- [Material Design 3](https://m3.material.io/)

---

কোনো প্রশ্ন থাকলে GitHub Issues খুলুন। Happy Coding! 🎉
