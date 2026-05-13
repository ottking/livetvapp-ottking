import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants.dart';
import '../../models/models.dart';

class CustomPlayerController extends StatefulWidget {
  final Channel channel;
  final bool isVisible;
  final Function(Channel) onChannelChanged;
  final bool isTV;

  const CustomPlayerController({
    required this.channel,
    required this.isVisible,
    required this.onChannelChanged,
    required this.isTV,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomPlayerController> createState() =>
      _CustomPlayerControllerState();
}

class _CustomPlayerControllerState extends State<CustomPlayerController>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppConstants.mediumAnimationDuration,
      vsync: this,
    );

    if (widget.isVisible) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(CustomPlayerController oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible && !oldWidget.isVisible) {
      _animationController.forward();
    } else if (!widget.isVisible && oldWidget.isVisible) {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Dark overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.transparent,
                  Colors.black.withOpacity(0.5),
                ],
              ),
            ),
          ),
          // Top Control Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildTopBar(),
          ),
          // Bottom Control Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomBar(),
          ),
          // Center Controls
          if (!widget.isTV)
            Center(
              child: _buildCenterControls(),
            ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
            color: Colors.white,
            iconSize: 28,
          ),
          Text(
            widget.channel.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              // Show info
            },
            color: Colors.white,
            iconSize: 28,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.7),
          ],
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Progress bar
          Container(
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Colors.white24,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: 0.35,
                backgroundColor: Colors.transparent,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppTheme.neonGreen,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const SizedBox(width: 12),
              _buildControlButton(
                icon: Icons.replay_10,
                onPressed: () {},
                label: '১০s',
              ),
              const Spacer(),
              _buildControlButton(
                icon: Icons.play_circle,
                onPressed: () {},
                label: 'প্লে',
                size: 40,
              ),
              const Spacer(),
              _buildControlButton(
                icon: Icons.forward_10,
                onPressed: () {},
                label: '১০s',
              ),
              const SizedBox(width: 12),
              _buildControlButton(
                icon: Icons.settings,
                onPressed: () {},
                label: 'গুণমান',
              ),
              const SizedBox(width: 12),
              _buildControlButton(
                icon: Icons.lock,
                onPressed: () {},
                label: 'লক',
              ),
              const SizedBox(width: 12),
              _buildControlButton(
                icon: Icons.fullscreen,
                onPressed: () {},
                label: 'ফুল',
              ),
              const SizedBox(width: 12),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const SizedBox(width: 12),
              Text(
                '00:45 / 01:30',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCenterControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCenterButton(
          icon: Icons.replay_10,
          onPressed: () {},
          label: 'পিছনে ১০s',
        ),
        _buildCenterButton(
          icon: Icons.play_circle_outline,
          onPressed: () {},
          label: 'প্লে/পজ',
          large: true,
        ),
        _buildCenterButton(
          icon: Icons.forward_10,
          onPressed: () {},
          label: 'সামনে ১০s',
        ),
      ],
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onPressed,
    required String label,
    double size = 28,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon),
          onPressed: onPressed,
          color: AppTheme.neonGreen,
          iconSize: size,
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildCenterButton({
    required IconData icon,
    required VoidCallback onPressed,
    required String label,
    bool large = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black.withOpacity(0.5),
          ),
          child: IconButton(
            icon: Icon(icon),
            onPressed: onPressed,
            color: AppTheme.neonGreen,
            iconSize: large ? 56 : 40,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
