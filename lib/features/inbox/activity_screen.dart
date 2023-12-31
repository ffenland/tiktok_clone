import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/size.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  final List<String> _notifications = List.generate(20, (index) => "${index}h");

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );
  late final Animation<double> _animation =
      Tween(begin: 0.0, end: 0.5).animate(_animationController);

  void _onDismissed(String notification) {
    _notifications.remove(notification);
    setState(() {});
  }

  void _onTitleTap() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: GestureDetector(
            onTap: _onTitleTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Activity"),
                Gaps.h5,
                RotationTransition(
                    turns: _animation,
                    child: const FaIcon(FontAwesomeIcons.chevronDown))
              ],
            ),
          )),
      body: ListView(
        children: [
          Gaps.v14,
          Padding(
            padding: const EdgeInsets.only(left: Sizes.size16),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "New",
                    style: TextStyle(
                      fontSize: Sizes.size14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  TextSpan(
                    text: "  If you want to delete, swipe right to left.",
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: Sizes.size12,
                    ),
                  )
                ],
              ),
            ),
          ),
          Gaps.v10,
          for (var notification in _notifications)
            Dismissible(
              direction: DismissDirection.endToStart,
              key: Key(notification),
              onDismissed: (direction) => _onDismissed(notification),
              background: Container(
                alignment: Alignment.centerLeft,
                color: Colors.green,
                child: const Padding(
                  padding: EdgeInsets.only(left: Sizes.size20),
                  child: FaIcon(
                    FontAwesomeIcons.checkDouble,
                    color: Colors.white,
                    size: Sizes.size32,
                  ),
                ),
              ),
              secondaryBackground: Container(
                alignment: Alignment.centerRight,
                color: Colors.red,
                child: const Padding(
                  padding: EdgeInsets.only(right: Sizes.size20),
                  child: FaIcon(
                    FontAwesomeIcons.trashCan,
                    color: Colors.white,
                    size: Sizes.size32,
                  ),
                ),
              ),
              child: ListTile(
                minVerticalPadding: Sizes.size16,
                leading: Container(
                  width: Sizes.size48,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: Sizes.size1,
                      )),
                  child: const Center(
                      child: FaIcon(
                    FontAwesomeIcons.bell,
                    color: Colors.black,
                  )),
                ),
                title: RichText(
                  text: TextSpan(
                    text: "Account Updates: ",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: Sizes.size16,
                    ),
                    children: [
                      const TextSpan(
                        text: "Upload longer videos.",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: notification,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
                trailing: const FaIcon(
                  FontAwesomeIcons.chevronRight,
                  size: Sizes.size16,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
