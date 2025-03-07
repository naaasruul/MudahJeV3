import 'package:flutter/material.dart';
import 'package:mudahjev3/Widgets/MyAppBar.dart';
import 'package:mudahjev3/Widgets/MyContainer.dart';

import 'package:multi_video_player/multi_video_player.dart';

class NoteVideo extends StatefulWidget {
  final List<dynamic> content;
  final int currentIndex;

  NoteVideo({required this.content, required this.currentIndex});

  @override
  State<NoteVideo> createState() => _NoteVideoState();
}

class _NoteVideoState extends State<NoteVideo> {
  late List videoSources;

  int _currentIndex = 0; // To keep track of the current video in the carousel
  String title = '';
  String desc = '';

  @override
  void initState() {
    super.initState();

    print("DATA MAK AU:: ${widget.content}");
    setState(() {
      _currentIndex = widget.currentIndex;
      title = widget.content[_currentIndex]['title'];
      desc = widget.content[_currentIndex]['description'];
    });
    videoSources = widget.content.map((item) => item['url']!).toList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onPrevious() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
      }
    });
  }

  void _onNext() {
    setState(() {
      if (_currentIndex < 4) {
        _currentIndex++;
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Notes', backButton: true),
      body: MyContainer(
        child: Column(
          children: [
            Expanded(
              child: MultiVideoPlayer.network(
                height: 400,
                width: MediaQuery.of(context).size.width,
                videoSourceList: videoSources,
                scrollDirection: Axis.horizontal,
                preloadPagesCount: videoSources.length,
                onPageChanged: (videoPlayerController, index) {
                  print(index);
                  setState(() {
                    title = widget.content[index]['title'];
                    desc = widget.content[index]['description'];
                  });
                },
                getCurrentVideoController: (videoPlayerController) {},
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(textAlign: TextAlign.center, desc)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
