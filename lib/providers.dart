import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';
import '../services/firebase_service.dart';

final firebaseServiceProvider = Provider((ref) => FirebaseService());

final appConfigProvider = FutureProvider((ref) async {
  final firebase = ref.watch(firebaseServiceProvider);
  return await firebase.fetchAppConfig();
});

final channelsProvider = FutureProvider((ref) async {
  final firebase = ref.watch(firebaseServiceProvider);
  final configData = await firebase.fetchChannels();
  return configData.map((e) => Channel.fromJson(e)).toList();
});

final moviesProvider = FutureProvider((ref) async {
  final firebase = ref.watch(firebaseServiceProvider);
  final moviesData = await firebase.fetchMovies();
  return moviesData.map((e) => Movie.fromJson(e)).toList();
});

final reelsProvider = FutureProvider((ref) async {
  final firebase = ref.watch(firebaseServiceProvider);
  final reelsData = await firebase.fetchReels();
  return reelsData.map((e) => Reel.fromJson(e)).toList();
});

final selectedChannelProvider = StateProvider<Channel?>((ref) => null);

final playingChannelProvider = StateProvider<Channel?>((ref) => null);
