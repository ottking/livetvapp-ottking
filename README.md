# Live BD TV - বাংলাদেশের প্রথম প্রোডাকশন-রেডি Flutter লাইভ টিভি অ্যাপ

![Status](https://img.shields.io/badge/status-Production%20Ready-brightgreen)
![Flutter](https://img.shields.io/badge/Flutter-3.24%2B-blue)
![License](https://img.shields.io/badge/License-MIT-yellow)

একটি আধুনিক, সুন্দর এবং পারফরম্যান্স-অপটিমাইজড লাইভ টিভি স্ট্রিমিং অ্যাপ যা Netflix এবং জিওসিনেমার মতো ডার্ক থিম ব্যবহার করে।

## 🎯 প্রধান বৈশিষ্ট্য

### 📱 মাল্টি-ডিভাইস সাপোর্ট
- **Android Mobile**: সম্পূর্ণ অপটিমাইজড মোবাইল UI
- **Android Smart TV**: টাচলেস নেভিগেশন এবং ফোকাস ম্যানেজমেন্ট সহ
- **Responsive Design**: ট্যাবলেট, স্মার্টফোন এবং টিভি সব ডিভাইসে নিখুঁত

### 🎨 ডিজাইন & থিমিং
- **Netflix + Geo Cinema Style**: কালো ব্যাকগ্রাউন্ড
- **Neon Green & Red Accents**: আকর্ষণীয় গ্রাডিয়েন্ট এবং শেডো
- **Smooth Animations**: ২০০-৬০০ms অ্যানিমেশন ডিউরেশন
- **Shadow & Gradient Effects**: উচ্চ-মানের ভিজ্যুয়াল উপাদান

### 🔴 লাইভ টিভি স্ট্রিমিং
- **Better Player Integration**: HLS, DASH (MPD), সাপোর্ট
- **DRM Support**: Widevine, ClearKey, নো-ডিআরএম
- **Custom Player Controller**: ১০s রিওয়াইন্ড/ফরওয়ার্ড, প্লে/পজ
- **Quality Selection**: মাল্টিপল কোয়ালিটি অপশন
- **Channel Auto-Switch**: লাইভ চ্যানেল চেঞ্জ করলে স্বয়ংক্রিয় আপডেট

### 🎬 চলচ্চিত্র ও রিল্স
- **Movie Grid**: সুন্দর পোস্টার গ্রিড লেআউট
- **Reels Page View**: ভার্টিক্যাল স্ক্রলিং রিল্স প্লেয়ার
- **Rating & Metadata**: চলচ্চিত্রের রেটিং এবং তথ্য প্রদর্শন

### 🔧 Firebase ইন্টিগ্রেশন
- **Real-time Config**: Firebase থেকে রিয়েল-টাইম অ্যাপ কনফিগ
- **Version Check**: মিনিমাম ভার্সন ম্যাচিং
- **Maintenance Mode**: সার্ভার ডাউনটাইমের জন্য মেইনটেন্যান্স স্ক্রিন

### 🔐 সিকিউরিটি
- **Firebase Authentication**: সিকিউর অথেন্টিকেশন
- **Secret Header Injection**: Dio ইন্টারসেপ্টর দিয়ে সিকিউর API কল
- **DRM License**: কন্টেন্ট সুরক্ষা

### ⚡ পারফরম্যান্স
- **Image Caching**: ৩০ দিনের ইমেজ ক্যাশ
- **Config Caching**: ১ ঘন্টার কনফিগ ক্যাশ
- **Lazy Loading**: চাহিদা অনুযায়ী কন্টেন্ট লোডিং
- **Optimized Rebuilds**: Riverpod দিয়ে স্মার্ট স্টেট ম্যানেজমেন্ট

## 📐 প্রজেক্ট স্ট্রাকচার

```
lib/
├── core/
│   ├── config/
│   │   └── app_config.dart          # Firebase কনফিগ ম্যানেজমেন্ট
│   ├── theme/
│   │   └── app_theme.dart           # থিমিং (Dark Mode, Colors, Typography)
│   ├── utils/
│   │   ├── exceptions.dart          # কাস্টম এক্সেপশন
│   │   ├── logger.dart              # লগিং সিস্টেম
│   │   └── responsive_helper.dart   # রেসপন্সিভ ডিজাইন হেল্পার
│   └── constants.dart               # অ্যাপ কনস্ট্যান্ট
├── features/
│   ├── auth/
│   │   ├── splash_screen.dart       # স্প্ল্যাশ স্ক্রিন + ইনিশিয়ালাইজেশন
│   │   └── app_down_screen.dart     # মেইনটেন্যান্স/ভার্সন স্ক্রিন
│   ├── home/
│   │   ├── home_screen.dart         # মেইন হোম স্ক্রিন
│   │   ├── home_screen_mobile.dart  # মোবাইল লেআউট (ট্যাব বেসড)
│   │   └── home_screen_tv.dart      # টিভি লেআউট (সাইডবার + গ্রিড)
│   ├── live_tv/
│   │   ├── live_tv_player_screen.dart        # প্লেয়ার মেইন স্ক্রিন
│   │   └── custom_player_controller.dart     # কাস্টম প্লেয়ার কন্ট্রোলার
│   ├── movies/
│   │   └── movies_screen.dart       # চলচ্চিত্র স্ক্রিন
│   └── reels/
│       └── reels_screen.dart        # রিল্স স্ক্রিন
├── models/
│   ├── channel.dart                 # চ্যানেল মডেল
│   ├── movie.dart                   # চলচ্চিত্র মডেল
│   ├── reel.dart                    # রিল মডেল
│   └── models.dart                  # এক্সপোর্ট ফাইল
├── services/
│   ├── firebase_service.dart        # Firebase সার্ভিস
│   ├── dio_client.dart              # নেটওয়ার্ক ক্লায়েন্ট
│   └── services.dart                # এক্সপোর্ট ফাইল
├── widgets/
│   ├── gradient_button.dart         # গ্রাডিয়েন্ট বাটন
│   ├── cached_image_widget.dart     # ইমেজ ক্যাশিং + শিমার
│   ├── loading_error_widgets.dart   # লোডিং & এরর উইজেট
│   └── widgets.dart                 # এক্সপোর্ট ফাইল
├── providers.dart                   # Riverpod প্রোভাইডার (State)
└── main.dart                        # অ্যাপ এন্ট্রি পয়েন্ট
```

## 🛠 টেকনোলজি স্ট্যাক

### ফ্রেমওয়ার্ক & SDK
- **Flutter**: ৩.২৪+
- **Dart**: ৩.৪+
- **Platform**: Android (iOS আসছে শীঘ্রই)

### স্টেট ম্যানেজমেন্ট
- **Riverpod**: ২.৪.০ - প্রোভাইডার বেসড স্টেট ম্যানেজমেন্ট

### নেটওয়ার্কিং
- **Dio**: ৫.৩.০ - HTTP ক্লায়েন্ট
- **Firebase Realtime DB**: রিয়েল-টাইম কনফিগ

### ভিডিও স্ট্রিমিং
- **Better Player**: ০.০.৮৩ - ভিডিও প্লেয়ার
- **Protocols**: HLS, DASH (MPD)
- **DRM**: Widevine, ClearKey

### UI/UX
- **Google Fonts**: সুন্দর টাইপোগ্রাফি
- **Cached Network Image**: ইমেজ ক্যাশিং + প্লেসহোল্ডার
- **Shimmer**: শিমার লোডিং এফেক্ট

### ক্যাশিং & স্টোরেজ
- **Hive**: স্থানীয় ডেটা স্টোরেজ
- **Cached Network Image**: ইমেজ ক্যাশ

### লগিং & ডিবাগিং
- **Logger**: প্রিটি কনসোল লগিং
- **Pretty Dio Logger**: নেটওয়ার্ক রিকোয়েস্ট লগিং

## 🚀 দ্রুত শুরু করুন

### প্রিকোয়ারজিট
- Flutter SDK (৩.২৪+)
- Android SDK (API ২১+)
- Firebase প্রজেক্ট
- Code Editor (VS Code, Android Studio)

### ইনস্টলেশন

1. **প্রজেক্ট ক্লোন করুন**
```bash
git clone <repository-url>
cd live_bd_tv
```

2. **ডিপেন্ডেন্সি ইনস্টল করুন**
```bash
flutter pub get
```

3. **Firebase সেটআপ করুন** (দেখুন `SETUP_GUIDE.md`)
```bash
# google-services.json android/app/ এ রাখুন
```

4. **অ্যাপ রান করুন**
```bash
flutter run
```

5. **রিলিজ বিল্ড তৈরি করুন**
```bash
flutter build apk --release
# অথবা
flutter build appbundle --release
```

## 📚 স্ক্রীন ফ্লো

```
Splash Screen
    ↓
    ├─ Firebase কনফিগ চেক
    ├─ ভার্সন ম্যাচিং
    └─ মেইনটেন্যান্স মোড চেক
        ↓
    ├─ ❌ ব্যর্থ → App Down Screen
    └─ ✅ সফল → Home Screen
                ↓
    ┌─────────┬─────────┬─────────┐
    ↓         ↓         ↓
Live TV    Movies    Reels
 Tab       Tab       Tab
    ↓         ↓         ↓
Live TV   Movie     Reel
Player    Grid      Page View
Screen    View      (Vertical)
    ↓
Channel List + Player
```

## 🎮 ব্যবহারকারী গাইড

### মোবাইল ব্যবহার

1. **হোম স্ক্রিনে**: তিনটি ট্যাব - লাইভ টিভি, চলচ্চিত্র, রিল্স
2. **চ্যানেল নির্বাচন**: গ্রিড থেকে চ্যানেল ট্যাপ করুন
3. **প্লেয়ারে**: 
   - উপরে: ভিডিও প্লেয়ার (40% হাইট)
   - নিচে: চ্যানেল লিস্ট (60% হাইট)
   - ট্যাপ করলে কন্ট্রোল দেখা যাবে

### টিভি ব্যবহার

1. **সাইডবার**: বাম পাশে ন্যাভিগেশন
2. **গ্রিড**: চ্যানেল/চলচ্চিত্র/রিল্স গ্রিড
3. **ইনফো প্যানেল**: দক্ষিণে নির্বাচিত আইটেমের তথ্য
4. **ফোকাস**: রিমোট দিয়ে আইটেম নির্বাচন করুন

## 🔧 কনফিগারেশন

### Firebase Config Structure

```json
{
  "app_config": {
    "v1_0_0": {
      "api_url": "https://api.livebdtv.com",
      "secret": "your_secret_key",
      "master_secret": "your_master_secret",
      "min_version": "1.0.0",
      "maintenance_mode": false
    }
  }
}
```

### কাস্টম থিম কালার

[lib/core/theme/app_theme.dart](lib/core/theme/app_theme.dart) এ সম্পাদনা করুন:

```dart
static const Color darkBg = Color(0xFF0F0F0F);          // মূল ব্যাকগ্রাউন্ড
static const Color neonGreen = Color(0xFF00FF88);       // প্রাইমারি অ্যাকসেন্ট
static const Color neonRed = Color(0xFFFF0055);         // সেকেন্ডারি অ্যাকসেন্ট
static const Color neonBlue = Color(0xFF00D9FF);        // টার্শিয়ারি অ্যাকসেন্ট
```

## 📊 স্ট্যাটিস্টিক্স

- **মোট লাইন কোড**: ~২৫০০+ লাইন
- **কম্পোনেন্ট**: ২০+ উইজেট
- **স্ক্রিন**: ৭ টি মেইন স্ক্রিন
- **API ইন্টিগ্রেশন**: Firebase + Dio
- **ডেটা মডেল**: ৩ টি (Channel, Movie, Reel)

## 🐛 ট্রাবলশুটিং

### সমস্যা: Firebase সংযোগ ব্যর্থ
**সমাধান**: 
- `google-services.json` চেক করুন
- Firebase প্রজেক্ট ID ম্যাচ করুন
- ইন্টারনেট সংযোগ চেক করুন

### সমস্যা: ইমেজ লোড হচ্ছে না
**সমাধান**:
- URL সঠিক কিনা চেক করুন
- ইন্টারনেট সংযোগ যাচাই করুন
- ক্যাশ ক্লিয়ার করুন: `flutter clean`

### সমস্যা: প্লেয়ার কাজ করছে না
**সমাধান**:
- স্ট্রিম URL সঠিক কিনা যাচাই করুন
- HLS/DASH সাপোর্ট চেক করুন
- DRM লাইসেন্স সার্ভার কনফিগার করুন

## 📝 লাইসেন্স

এই প্রজেক্ট MIT লাইসেন্সের অধীন। বিস্তারিত দেখুন [LICENSE](LICENSE) ফাইল।

## 👨‍💻 ডেভেলপার

**Senior Flutter & UI/UX Developer**
- প্রোডাকশন-রেডি কোড
- সেরা প্র্যাকটিস অনুসরণ
- সম্পূর্ণ ডকুমেন্টেশন

## 🤝 অবদান রাখুন

১. ফর্ক করুন
২. ফিচার ব্র্যাঞ্চ তৈরি করুন (`git checkout -b feature/amazing-feature`)
৩. পরিবর্তন কমিট করুন (`git commit -m 'Add amazing feature'`)
৪. ব্র্যাঞ্চ পুশ করুন (`git push origin feature/amazing-feature`)
৫. Pull Request খুলুন

## 📞 সাপোর্ট

সমস্যা বা পরামর্শের জন্য:
- GitHub Issues খুলুন
- ইমেইল পাঠান: support@livebdtv.com

## 🔗 দরকারি লিঙ্ক

- [Flutter Documentation](https://flutter.dev/docs)
- [Firebase Setup Guide](SETUP_GUIDE.md)
- [Better Player Package](https://pub.dev/packages/better_player)
- [Riverpod State Management](https://riverpod.dev)

---

**Live BD TV** - প্রিমিয়াম লাইভ টিভি স্ট্রিমিং অভিজ্ঞতা 🚀
