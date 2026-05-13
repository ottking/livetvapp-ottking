pluginManagement {
    val flutterSdkPath =
        run {
            val properties = java.util.Properties()
            file("local.properties").inputStream().use { properties.load(it) }
            val flutterSdkPath = properties.getProperty("flutter.sdk")
            require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
            flutterSdkPath
        }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-gradle-plugin") version "1.0.0" apply false
    
    // ভার্সনটি 8.1.0 থেকে বাড়িয়ে 8.3.2 করা হলো (এটি বেশি স্ট্যাবল)
    id("com.android.application") version "8.3.2" apply false
    
    // কোটলিন ভার্সনটিও কিছুটা আপডেট করা ভালো
    id("org.jetbrains.kotlin.android") version "1.9.10" apply false
    
    // ফায়ারবেস গুগল সার্ভিস লেটেস্ট ভার্সন
    id("com.google.gms.google-services") version "4.4.1" apply false
}

include(":app")
