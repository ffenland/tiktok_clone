import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/videos/widgets/video_post.dart';

class VideoTimlineScreen extends StatefulWidget {
  const VideoTimlineScreen({super.key});

  @override
  State<VideoTimlineScreen> createState() => _VideoTimlineScreenState();
}

class _VideoTimlineScreenState extends State<VideoTimlineScreen> {
  int _itemCount = 4;

  final PageController _pageController = PageController();

  final _scrollDuration = const Duration(milliseconds: 150);
  final _scrollCurve = Curves.linear;

  void _onPageChanged(int index) {
    _pageController.animateToPage(
      index,
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
    if (index == _itemCount - 1) {
      _itemCount = _itemCount + 4;
      setState(() {});
    }
  }

  void _onVideoFinished() {
    _pageController.nextPage(
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: _onPageChanged,
      scrollDirection: Axis.vertical,
      itemCount: _itemCount,
      itemBuilder: (context, index) =>
          VideoPost(onVideoFinished: _onVideoFinished, index: index),
    );
  }
}
