import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/size.dart';

class VideoButton extends StatelessWidget {
  const VideoButton({super.key, required this.icon, required this.name});
  final IconData icon;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FaIcon(icon, color: Colors.white, size: Sizes.size36),
        Gaps.v5,
        Text(
          name,
          style: const TextStyle(
              color: Colors.white,
              fontSize: Sizes.size12,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
