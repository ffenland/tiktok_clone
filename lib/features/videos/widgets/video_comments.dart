import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/size.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  bool _isWriting = false;

  void _onStartWriting() {
    setState(() {
      _isWriting = true;
    });
  }

  void _onClosePressed() {
    Navigator.of(context).pop();
    _isWriting = false;
  }

  void _stopWriting() {
    FocusScope.of(context).unfocus();
    _isWriting = false;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.8,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          title: const Text("123213 comments"),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: _onClosePressed,
                icon: const FaIcon(FontAwesomeIcons.xmark))
          ],
        ),
        body: GestureDetector(
          onTap: _stopWriting,
          child: Stack(
            children: [
              ListView.separated(
                padding: const EdgeInsets.only(
                  top: Sizes.size10,
                  left: Sizes.size16,
                  right: Sizes.size16,
                  bottom: Sizes.size96,
                ),
                itemCount: 10,
                separatorBuilder: (context, index) => Gaps.v10,
                itemBuilder: (context, index) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      child: Text("ffen"),
                    ),
                    Gaps.h10,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ffen",
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: Sizes.size14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Gaps.v5,
                          const Text(
                              "sadklfasdjflkasdjflkasdjfasldkfjasldkfjasdlkfjasdlkfjasdflkasdjf")
                        ],
                      ),
                    ),
                    Gaps.h10,
                    Column(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.heart,
                          color: Colors.grey.shade500,
                        ),
                        Gaps.v2,
                        Text(
                          "52,2K",
                          style: TextStyle(
                            color: Colors.grey.shade500,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                width: size.width,
                child: BottomAppBar(
                  color: Colors.white,
                  child: Row(children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey.shade500,
                      foregroundColor: Colors.white,
                      child: const Text("ffen"),
                    ),
                    Gaps.h10,
                    Expanded(
                      child: TextField(
                        onTap: _onStartWriting,
                        decoration: InputDecoration(
                          hintText: "Write comment",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Sizes.size12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: Sizes.size12,
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: Sizes.size14),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.at,
                                  color: Colors.grey.shade800,
                                ),
                                Gaps.h10,
                                FaIcon(
                                  FontAwesomeIcons.gift,
                                  color: Colors.grey.shade800,
                                ),
                                Gaps.h10,
                                FaIcon(
                                  FontAwesomeIcons.faceSmile,
                                  color: Colors.grey.shade800,
                                ),
                                Gaps.h10,
                                GestureDetector(
                                  onTap: _stopWriting,
                                  child: FaIcon(
                                    FontAwesomeIcons.circleArrowUp,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        minLines: null,
                        maxLines: null,
                        expands: true,
                      ),
                    )
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
