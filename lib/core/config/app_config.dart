import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class AppConfig {
  late String apiUrl;
  late String secret;
  late String masterSecret;
  late String minVersion;
  late bool maintenanceMode;

  void updateFromJson(Map<String, dynamic> json) {
    apiUrl = json['api_url'] ?? '';
    secret = json['secret'] ?? '';
    masterSecret = json['master_secret'] ?? '';
    minVersion = json['min_version'] ?? '1.0.0';
    maintenanceMode = json['maintenance_mode'] ?? false;
  }

  Map<String, dynamic> toJson() => {
    'api_url': apiUrl,
    'secret': secret,
    'master_secret': masterSecret,
    'min_version': minVersion,
    'maintenance_mode': maintenanceMode,
  };
}

class ConfigManager {
  static final ConfigManager _instance = ConfigManager._internal();
  static final Logger _logger = Logger();

  late AppConfig _config;

  ConfigManager._internal();

  factory ConfigManager() {
    return _instance;
  }

  AppConfig get config => _config;

  Future<void> initialize(Map<String, dynamic> configJson) async {
    try {
      _config = AppConfig();
      _config.updateFromJson(configJson);
      _logger.i('Config initialized successfully');
    } catch (e) {
      _logger.e('Error initializing config: $e');
      rethrow;
    }
  }

  bool isMaintenanceMode() => _config.maintenanceMode;

  bool isVersionCompatible(String currentVersion) {
    return _compareVersions(currentVersion, _config.minVersion) >= 0;
  }

  int _compareVersions(String v1, String v2) {
    final parts1 = v1.split('.').map(int.parse).toList();
    final parts2 = v2.split('.').map(int.parse).toList();

    for (int i = 0; i < 3; i++) {
      final p1 = i < parts1.length ? parts1[i] : 0;
      final p2 = i < parts2.length ? parts2[i] : 0;
      
      if (p1 > p2) return 1;
      if (p1 < p2) return -1;
    }
    return 0;
  }

  String getAuthHeader() => 'Bearer ${_config.secret}';
}
