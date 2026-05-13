import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants.dart';
import '../../core/utils/responsive_helper.dart';
import '../../models/models.dart';
import '../../providers.dart';
import 'custom_player_controller.dart';

class LiveTVPlayerScreen extends ConsumerStatefulWidget {
  final Channel channel;

  const LiveTVPlayerScreen({
    required this.channel,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<LiveTVPlayerScreen> createState() =>
      _LiveTVPlayerScreenState();
}

class _LiveTVPlayerScreenState extends ConsumerState<LiveTVPlayerScreen> {
  late Channel currentChannel;
  bool isPlaying = true;
  bool showControls = true;
  late Future<void> _controlsHideFuture;

  @override
  void initState() {
    super.initState();
    currentChannel = widget.channel;
    _scheduleControlsHide();
  }

  void _scheduleControlsHide() {
    _controlsHideFuture = Future.delayed(
      AppConstants.playerControlsVisibilityDuration,
      () {
        if (mounted) {
          setState(() => showControls = false);
        }
      },
    );
  }

  void _showControlsTemporarily() {
    if (mounted) {
      setState(() => showControls = true);
    }
    _scheduleControlsHide();
  }

  void _onChannelChanged(Channel newChannel) {
    setState(() {
      currentChannel = newChannel;
    });
    _showControlsTemporarily();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final isTV = ResponsiveHelper.isTV(context);

    if (isTV) {
      return _buildTVLayout();
    } else if (isMobile) {
      return _buildMobileLayout();
    } else {
      return _buildTabletLayout();
    }
  }

  Widget _buildTVLayout() {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      body: GestureDetector(
        onTap: _showControlsTemporarily,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Full Screen Video Player
            Container(
              color: Colors.black,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'বিটা প্লেয়ার (better_player ইন্টিগ্রেশন)',
                      style: TextStyle(
                        color: AppTheme.neonGreen,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      currentChannel.name,
                      style: const TextStyle(
                        color: AppTheme.textPrimary,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // TV Controls
            CustomPlayerController(
              channel: currentChannel,
              isVisible: showControls,
              onChannelChanged: _onChannelChanged,
              isTV: true,
            ),
            // Back Button
            Positioned(
              top: 20,
              left: 20,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: AppTheme.textPrimary,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      appBar: AppBar(
        backgroundColor: AppTheme.darkBg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(currentChannel.name),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: _showControlsTemporarily,
        child: Column(
          children: [
            // Video Player - ~40% height
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  AppConstants.mobilePlayerHeightRatio,
              child: Container(
                color: Colors.black,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isPlaying ? Icons.play_circle : Icons.pause_circle,
                            size: 64,
                            color: AppTheme.neonGreen,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            currentChannel.name,
                            style: const TextStyle(
                              color: AppTheme.textPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Controls Overlay
                    CustomPlayerController(
                      channel: currentChannel,
                      isVisible: showControls,
                      onChannelChanged: _onChannelChanged,
                      isTV: false,
                    ),
                  ],
                ),
              ),
            ),
            // Channel List - ~60% height
            Expanded(
              child: _buildChannelList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabletLayout() {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      appBar: AppBar(
        backgroundColor: AppTheme.darkBg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(currentChannel.name),
      ),
      body: GestureDetector(
        onTap: _showControlsTemporarily,
        child: Row(
          children: [
            // Video Player
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.black,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isPlaying ? Icons.play_circle : Icons.pause_circle,
                            size: 80,
                            color: AppTheme.neonGreen,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            currentChannel.name,
                            style: const TextStyle(
                              color: AppTheme.textPrimary,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomPlayerController(
                      channel: currentChannel,
                      isVisible: showControls,
                      onChannelChanged: _onChannelChanged,
                      isTV: false,
                    ),
                  ],
                ),
              ),
            ),
            // Channel List
            SizedBox(
              width: 350,
              child: _buildChannelList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChannelList() {
    return Consumer(
      builder: (context, ref, child) {
        final channelsAsync = ref.watch(channelsProvider);

        return channelsAsync.when(
          data: (channels) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppConstants.horizontalPadding),
                  child: Text(
                    'চ্যানেল সিরিজ',
                    style: const TextStyle(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.all(AppConstants.horizontalPadding),
                    itemCount: channels.length,
                    itemBuilder: (context, index) {
                      final channel = channels[index];
                      final isCurrentChannel =
                          channel.id == currentChannel.id;

                      return GestureDetector(
                        onTap: () => _onChannelChanged(channel),
                        child: Container(
                          margin: const EdgeInsets.only(
                            bottom: AppConstants.verticalPadding,
                          ),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              AppConstants.borderRadius,
                            ),
                            border: Border.all(
                              color: isCurrentChannel
                                  ? AppTheme.neonGreen
                                  : AppTheme.accent,
                              width: isCurrentChannel ? 2 : 1,
                            ),
                            color: isCurrentChannel
                                ? AppTheme.accent.withOpacity(0.3)
                                : Colors.transparent,
                            boxShadow: isCurrentChannel
                                ? [
                                    BoxShadow(
                                      color: AppTheme.neonGreen
                                          .withOpacity(0.2),
                                      blurRadius: 10,
                                    ),
                                  ]
                                : [],
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 60,
                                height: 60,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.network(
                                    channel.logo,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error,
                                            stackTrace) =>
                                        Container(
                                      color: AppTheme.accent,
                                      child: const Icon(
                                        Icons.image,
                                        color: AppTheme.neonGreen,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      channel.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: isCurrentChannel
                                            ? AppTheme.neonGreen
                                            : AppTheme.textPrimary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    if (channel.category.isNotEmpty)
                                      Text(
                                        channel.category,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: AppTheme.textSecondary,
                                          fontSize: 12,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              if (channel.isLive)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppTheme.neonRed,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: const Text(
                                    'লাইভ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                AppTheme.neonGreen,
              ),
            ),
          ),
          error: (error, stack) => Center(
            child: Text(
              'চ্যানেল লোড করতে ব্যর্থ',
              style: TextStyle(color: AppTheme.neonRed),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
