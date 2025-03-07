import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mudahjev3/Utils/constant.dart';
import 'package:mudahjev3/Widgets/MyAppBar.dart';
import 'package:mudahjev3/Widgets/MyContainer.dart';
import 'package:multi_video_player/multi_video_player.dart';

class SearchResultScreen extends StatefulWidget {
  final List<Map<String, dynamic>> content;

  SearchResultScreen({
    required this.content,
  });

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  late List videoSources;
  int _currentIndex = 0; // To keep track of the current video in the carousel
  String title = '';
  String desc = '';
  bool _isLoading = false;
  List<Map<String, dynamic>> notes = [];

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    notes = widget.content;
    setState(() {
      title = widget.content[_currentIndex]['title'];
      desc = widget.content[_currentIndex]['pronouns'];
    });
    videoSources = widget.content.map((item) => item['video_url']!).toList();
    _isLoading = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _nextVideo() {
    setState(() {
      if (_currentIndex < videoSources.length - 1) {
        _currentIndex++;
        title = widget.content[_currentIndex]['title'];
        desc = widget.content[_currentIndex]['pronouns'];
      }
    });
  }

  void _previousVideo() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
        title = widget.content[_currentIndex]['title'];
        desc = widget.content[_currentIndex]['pronouns'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'MudahJe', backButton: true),
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: MyContainer(
          child: Container(
            
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    child: MultiVideoPlayer.network(
                      height: 400,
                      width: MediaQuery.of(context).size.width,
                      videoSourceList: videoSources,
                      scrollDirection: Axis.horizontal,
                      preloadPagesCount: videoSources.length,
                      onPageChanged: (videoPlayerController, index) {
                        setState(() {
                          _currentIndex = index;
                          title = widget.content[_currentIndex]['title'];
                          desc = widget.content[_currentIndex]['pronouns'];
                        });
                      },
                    ),
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
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 32),
                      Text(
                        desc,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
