import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/size.dart';
import 'package:tiktok_clone/features/videos/widgets/video_button.dart';
import 'package:tiktok_clone/features/videos/widgets/video_comments.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  final Function onVideoFinished;
  final int index;
  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
  });

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/video1.mp4");
  late final AnimationController _animationController;

  bool _isPaused = false;

  final Duration _animationDuration = const Duration(milliseconds: 200);

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _initVideoPlayer() async {
    // initialize를 무조건 해줘야한다.
    await _videoPlayerController.initialize();

    setState(() {});
    _videoPlayerController.addListener(_onVideoChange);
    await _videoPlayerController.setLooping(true);
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    }
    if (_videoPlayerController.value.isPlaying && info.visibleFraction < 1) {
      _onToggelPause();
    }
  }

  void _onToggelPause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _isPaused = true;
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _isPaused = false;
      _animationController.forward();
    }
    setState(() {});
  }

  void _onCommentsTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _onToggelPause();
    }
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => const VideoComments(),
    );
    _onToggelPause();
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animationDuration,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned.fill(child: GestureDetector(onTap: _onToggelPause)),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      child: child,
                    );
                  },
                  child: AnimatedOpacity(
                    duration: _animationDuration,
                    opacity: _isPaused ? 1 : 0,
                    child: const FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size48,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 30,
            left: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "@ffen",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gaps.v8,
                Text(
                  "This is my kids",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size14,
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            right: 10,
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 25,
                  foregroundImage: NetworkImage(
                      "https://static.vecteezy.com/system/resources/previews/009/292/244/original/default-avatar-icon-of-social-media-user-vector.jpg"),
                  child: Text("FFen"),
                ),
                Gaps.v14,
                const VideoButton(
                  icon: FontAwesomeIcons.solidHeart,
                  name: "2.4 M",
                ),
                Gaps.v14,
                GestureDetector(
                  onTap: () => _onCommentsTap(context),
                  child: const VideoButton(
                    icon: FontAwesomeIcons.solidComment,
                    name: "33K",
                  ),
                ),
                Gaps.v14,
                const VideoButton(
                  icon: FontAwesomeIcons.share,
                  name: "Share",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
