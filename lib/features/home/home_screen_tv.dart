import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants.dart';
import '../../models/models.dart';
import '../../providers.dart';
import '../../widgets/widgets.dart';
import '../live_tv/live_tv_player_screen.dart';

class HomeScreenTV extends ConsumerStatefulWidget {
  const HomeScreenTV({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreenTV> createState() => _HomeScreenTVState();
}

class _HomeScreenTVState extends ConsumerState<HomeScreenTV> {
  int _selectedTabIndex = 0;
  int? _selectedChannelIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      body: Row(
        children: [
          // Sidebar Navigation
          NavigationRail(
            backgroundColor: AppTheme.darkCard,
            selectedIndex: _selectedTabIndex,
            onDestinationSelected: (int index) {
              setState(() => _selectedTabIndex = index);
            },
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.live_tv),
                label: Text('লাইভ টিভি'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.movie),
                label: Text('চলচ্চিত্র'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.play_circle),
                label: Text('রিলস'),
              ),
            ],
          ),
          // Main Content
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedTabIndex) {
      case 0:
        return _buildLiveChannelsContent();
      case 1:
        return _buildMoviesContent();
      case 2:
        return _buildReelsContent();
      default:
        return const SizedBox();
    }
  }

  Widget _buildLiveChannelsContent() {
    final channelsAsync = ref.watch(channelsProvider);

    return channelsAsync.when(
      data: (channels) {
        if (channels.isEmpty) {
          return Center(
            child: ErrorWidget(
              message: 'কোনো চ্যানেল খুঁজে পাওয়া যায়নি',
            ),
          );
        }
        return Row(
          children: [
            // Channel Grid
            Expanded(
              flex: 2,
              child: GridView.builder(
                padding: const EdgeInsets.all(20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: channels.length,
                itemBuilder: (context, index) {
                  final channel = channels[index];
                  final isSelected = _selectedChannelIndex == index;
                  return _buildChannelCardTV(
                    context,
                    channel,
                    isSelected,
                    () {
                      setState(() => _selectedChannelIndex = index);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LiveTVPlayerScreen(channel: channel),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            // Info Panel
            SizedBox(
              width: 350,
              child: _buildChannelInfoPanel(channels),
            ),
          ],
        );
      },
      loading: () => const LoadingWidget(message: 'চ্যানেল লোড হচ্ছে...'),
      error: (error, stack) => ErrorWidget(
        message: 'চ্যানেল লোড করতে ব্যর্থ হয়েছে',
      ),
    );
  }

  Widget _buildChannelCardTV(
    BuildContext context,
    Channel channel,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppTheme.neonGreen : AppTheme.accent,
            width: isSelected ? 3 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.neonGreen.withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: Stack(
          children: [
            CachedImageWidget(
              imageUrl: channel.logo,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(12),
            ),
            if (channel.isLive)
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.neonRed,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 6,
                        color: Colors.white,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'লাইভ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildChannelInfoPanel(List<Channel> channels) {
    final selectedChannel = _selectedChannelIndex != null
        ? channels[_selectedChannelIndex!]
        : null;

    return Container(
      color: AppTheme.darkCard,
      padding: const EdgeInsets.all(20),
      child: selectedChannel != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedImageWidget(
                  imageUrl: selectedChannel.logo,
                  width: double.infinity,
                  height: 150,
                  borderRadius: BorderRadius.circular(8),
                ),
                const SizedBox(height: 20),
                Text(
                  selectedChannel.name,
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                if (selectedChannel.category.isNotEmpty)
                  Chip(
                    label: Text(selectedChannel.category),
                    backgroundColor: AppTheme.accent,
                    labelStyle: const TextStyle(color: AppTheme.neonGreen),
                  ),
                const SizedBox(height: 15),
                if (selectedChannel.currentProgram != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'বর্তমান অনুষ্ঠান',
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        selectedChannel.currentProgram!,
                        style: const TextStyle(
                          color: AppTheme.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 15),
                if (selectedChannel.description != null)
                  Text(
                    selectedChannel.description!,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),
              ],
            )
          : const Center(
              child: Text(
                'চ্যানেল নির্বাচন করুন',
                style: TextStyle(
                  color: AppTheme.textSecondary,
                ),
              ),
            ),
    );
  }

  Widget _buildMoviesContent() {
    final moviesAsync = ref.watch(moviesProvider);

    return moviesAsync.when(
      data: (movies) {
        if (movies.isEmpty) {
          return Center(
            child: ErrorWidget(
              message: 'কোনো চলচ্চিত্র খুঁজে পাওয়া যায়নি',
            ),
          );
        }
        return GridView.builder(
          padding: const EdgeInsets.all(20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.7,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return _buildMovieCardTV(movie);
          },
        );
      },
      loading: () => const LoadingWidget(message: 'চলচ্চিত্র লোড হচ্ছে...'),
      error: (error, stack) => ErrorWidget(
        message: 'চলচ্চিত্র লোড করতে ব্যর্থ হয়েছে',
      ),
    );
  }

  Widget _buildMovieCardTV(Movie movie) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
          ),
        ],
      ),
      child: Stack(
        children: [
          CachedImageWidget(
            imageUrl: movie.poster,
            borderRadius: BorderRadius.circular(12),
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: AppTheme.neonGreen,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      movie.rating.toStringAsFixed(1),
                      style: const TextStyle(
                        color: AppTheme.neonGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReelsContent() {
    final reelsAsync = ref.watch(reelsProvider);

    return reelsAsync.when(
      data: (reels) {
        if (reels.isEmpty) {
          return Center(
            child: ErrorWidget(
              message: 'কোনো রিল খুঁজে পাওয়া যায়নি',
            ),
          );
        }
        return GridView.builder(
          padding: const EdgeInsets.all(20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.9,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: reels.length,
          itemBuilder: (context, index) {
            final reel = reels[index];
            return _buildReelCardTV(reel);
          },
        );
      },
      loading: () => const LoadingWidget(message: 'রিল লোড হচ্ছে...'),
      error: (error, stack) => ErrorWidget(
        message: 'রিল লোড করতে ব্যর্থ হয়েছে',
      ),
    );
  }

  Widget _buildReelCardTV(Reel reel) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedImageWidget(
            imageUrl: reel.thumbnail,
            borderRadius: BorderRadius.circular(12),
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reel.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '👁️ ${_formatNumber(reel.views)}',
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      '❤️ ${_formatNumber(reel.likes)}',
                      style: const TextStyle(
                        color: AppTheme.neonRed,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
}
