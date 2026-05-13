import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:logger/logger.dart';
import '../core/config/app_config.dart';
import '../core/utils/exceptions.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  late FirebaseDatabase _database;
  static final Logger _logger = Logger();

  FirebaseService._internal();

  factory FirebaseService() {
    return _instance;
  }

  Future<void> initialize() async {
    try {
      await Firebase.initializeApp();
      _database = FirebaseDatabase.instance;
      _database.databaseURL = 'https://livebdtv-default-rtdb.firebaseio.com';
      _logger.i('Firebase initialized successfully');
    } catch (e) {
      _logger.e('Firebase initialization error: $e');
      throw FirebaseException(
        message: 'Firebase initialization failed',
        originalException: e,
      );
    }
  }

  Future<Map<String, dynamic>> fetchAppConfig() async {
    try {
      final ref = _database.ref('app_config/v1_0_0');
      final snapshot = await ref.get();

      if (!snapshot.exists) {
        throw FirebaseException(
          message: 'App config not found in Firebase',
        );
      }

      final configData = Map<String, dynamic>.from(snapshot.value as Map);
      _logger.i('App config fetched successfully');
      
      await ConfigManager().initialize(configData);
      return configData;
    } catch (e) {
      _logger.e('Error fetching app config: $e');
      throw FirebaseException(
        message: 'Failed to fetch app configuration',
        originalException: e,
      );
    }
  }

  Future<List<Map<String, dynamic>>> fetchChannels() async {
    try {
      final ref = _database.ref('channels');
      final snapshot = await ref.get();

      if (!snapshot.exists) {
        return [];
      }

      final channels = <Map<String, dynamic>>[];
      final data = snapshot.value as Map;
      
      data.forEach((key, value) {
        channels.add(Map<String, dynamic>.from(value));
      });

      _logger.i('Channels fetched: ${channels.length}');
      return channels;
    } catch (e) {
      _logger.e('Error fetching channels: $e');
      throw FirebaseException(
        message: 'Failed to fetch channels',
        originalException: e,
      );
    }
  }

  Future<List<Map<String, dynamic>>> fetchMovies() async {
    try {
      final ref = _database.ref('movies');
      final snapshot = await ref.get();

      if (!snapshot.exists) {
        return [];
      }

      final movies = <Map<String, dynamic>>[];
      final data = snapshot.value as Map;
      
      data.forEach((key, value) {
        movies.add(Map<String, dynamic>.from(value));
      });

      _logger.i('Movies fetched: ${movies.length}');
      return movies;
    } catch (e) {
      _logger.e('Error fetching movies: $e');
      throw FirebaseException(
        message: 'Failed to fetch movies',
        originalException: e,
      );
    }
  }

  Future<List<Map<String, dynamic>>> fetchReels() async {
    try {
      final ref = _database.ref('reels');
      final snapshot = await ref.get();

      if (!snapshot.exists) {
        return [];
      }

      final reels = <Map<String, dynamic>>[];
      final data = snapshot.value as Map;
      
      data.forEach((key, value) {
        reels.add(Map<String, dynamic>.from(value));
      });

      _logger.i('Reels fetched: ${reels.length}');
      return reels;
    } catch (e) {
      _logger.e('Error fetching reels: $e');
      throw FirebaseException(
        message: 'Failed to fetch reels',
        originalException: e,
      );
    }
  }

  Stream<DatabaseEvent> watchChannel(String channelId) {
    return _database.ref('channels/$channelId').onValue;
  }
}
