import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/videos/widgets/video_post.dart';

class VideoTimlineScreen extends StatefulWidget {
  const VideoTimlineScreen({super.key});

  @override
  State<VideoTimlineScreen> createState() => _VideoTimlineScreenState();
}

class _VideoTimlineScreenState extends State<VideoTimlineScreen> {
  int _itemCount = 7;

  final PageController _pageController = PageController();

  List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.amber,
    Colors.purple,
    Colors.pink,
    Colors.brown,
  ];

  void _onPageChanged(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 70), curve: Curves.linear);
    if (index == _itemCount - 1) {
      colors.addAll([
        Colors.blue,
        Colors.red,
        Colors.green,
        Colors.amber,
        Colors.purple,
        Colors.pink,
        Colors.brown,
      ]);
      _itemCount = _itemCount + 7;
      setState(() {});
    }
  }

  void _onVideoFinished() {
    return;
  }

  Future<void> _onRefresh() async {
    return Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 60,
      onRefresh: _onRefresh,
      child: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: _itemCount,
        itemBuilder: (context, index) =>
            VideoPost(onVideoFinished: _onVideoFinished, index: index),
        onPageChanged: _onPageChanged,
      ),
    );
  }
}
