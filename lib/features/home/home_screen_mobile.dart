import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants.dart';
import '../../models/models.dart';
import '../../providers.dart';
import '../../widgets/widgets.dart';
import '../live_tv/live_tv_player_screen.dart';

class HomeScreenMobile extends ConsumerWidget {
  const HomeScreenMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channelsAsync = ref.watch(channelsProvider);
    final moviesAsync = ref.watch(moviesProvider);
    final reelsAsync = ref.watch(reelsProvider);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppTheme.darkBg,
        appBar: AppBar(
          backgroundColor: AppTheme.darkBg,
          elevation: 0,
          title: const Text(
            AppConstants.appName,
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: AppTheme.neonGreen,
            indicatorWeight: 4,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
            tabs: const [
              Tab(text: 'লাইভ টিভি'),
              Tab(text: 'চলচ্চিত্র'),
              Tab(text: 'রিলস'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildLiveChannelsTab(channelsAsync),
            _buildMoviesTab(moviesAsync),
            _buildReelsTab(reelsAsync),
          ],
        ),
      ),
    );
  }

  Widget _buildLiveChannelsTab(AsyncValue<List<Channel>> channelsAsync) {
    return channelsAsync.when(
      data: (channels) {
        if (channels.isEmpty) {
          return Center(
            child: ErrorWidget(
              message: 'কোনো চ্যানেল খুঁজে পাওয়া যায়নি',
            ),
          );
        }
        return GridView.builder(
          padding: const EdgeInsets.all(AppConstants.horizontalPadding),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: channels.length,
          itemBuilder: (context, index) {
            final channel = channels[index];
            return _buildChannelCard(context, channel);
          },
        );
      },
      loading: () => const LoadingWidget(message: 'চ্যানেল লোড হচ্ছে...'),
      error: (error, stack) => ErrorWidget(
        message: 'চ্যানেল লোড করতে ব্যর্থ হয়েছে',
      ),
    );
  }

  Widget _buildChannelCard(BuildContext context, Channel channel) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LiveTVPlayerScreen(channel: channel),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          boxShadow: [
            BoxShadow(
              color: AppTheme.neonGreen.withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            CachedImageWidget(
              imageUrl: channel.logo,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
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
                    channel.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (channel.isLive)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.neonRed,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoviesTab(AsyncValue<List<Movie>> moviesAsync) {
    return moviesAsync.when(
      data: (movies) {
        if (movies.isEmpty) {
          return Center(
            child: ErrorWidget(
              message: 'কোনো চলচ্চিত্র খুঁজে পাওয়া যায়নি',
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(AppConstants.horizontalPadding),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return _buildMovieCard(context, movie);
          },
        );
      },
      loading: () => const LoadingWidget(message: 'চলচ্চিত্র লোড হচ্ছে...'),
      error: (error, stack) => ErrorWidget(
        message: 'চলচ্চিত্র লোড করতে ব্যর্থ হয়েছে',
      ),
    );
  }

  Widget _buildMovieCard(BuildContext context, Movie movie) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              height: 140,
              child: CachedImageWidget(
                imageUrl: movie.poster,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
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
                    const SizedBox(height: 4),
                    Text(
                      movie.genre,
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 12,
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
                          ),
                        ),
                      ],
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

  Widget _buildReelsTab(AsyncValue<List<Reel>> reelsAsync) {
    return reelsAsync.when(
      data: (reels) {
        if (reels.isEmpty) {
          return Center(
            child: ErrorWidget(
              message: 'কোনো রিল খুঁজে পাওয়া যায়নি',
            ),
          );
        }
        return PageView.builder(
          itemCount: reels.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final reel = reels[index];
            return _buildReelCard(reel);
          },
        );
      },
      loading: () => const LoadingWidget(message: 'রিল লোড হচ্ছে...'),
      error: (error, stack) => ErrorWidget(
        message: 'রিল লোড করতে ব্যর্থ হয়েছে',
      ),
    );
  }

  Widget _buildReelCard(Reel reel) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CachedImageWidget(
          imageUrl: reel.thumbnail,
          fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.8),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          left: 16,
          right: 16,
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
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.person,
                    color: AppTheme.neonGreen,
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    reel.creator,
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '👁️ ${_formatNumber(reel.views)}',
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '❤️ ${_formatNumber(reel.likes)}',
                    style: const TextStyle(
                      color: AppTheme.neonRed,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
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
