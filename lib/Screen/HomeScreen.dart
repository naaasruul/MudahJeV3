import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mudahjev3/Screen/ExerciseScreen.dart';
import 'package:mudahjev3/Screen/NoteScreen.dart';
import 'package:mudahjev3/Screen/SearchScreen.dart';
import 'package:mudahjev3/Widgets/MyAppBar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:mudahjev3/Utils/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Homescreen extends StatefulWidget {
  @override
  State<Homescreen> createState() => _HomescreenState();
}

final _auth = FirebaseAuth.instance;

class _HomescreenState extends State<Homescreen> {
  int _isSelected = 0;
  bool isLoading = false;

  late final User loggedInUser;

  void getCurrentUser() async {
    setState(() {
      isLoading = true;
    });
    final user = await _auth.currentUser;

    if (user != null) {
      loggedInUser = user;
      print(loggedInUser.email);
    }

    setState(() {
      isLoading = false;
    });
  }

  // List of pages to navigate

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      NoteScreen(username: loggedInUser,),
      SearchScreen(),
      ExerciseScreen(
        username: loggedInUser,
      ),
    ];

    return Scaffold(
      appBar: MyAppBar(title: 'Mudah Je', backButton: false),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color(kPrimaryColor),
        items: const <Widget>[
          Icon(Icons.book_rounded, size: 30),
          Icon(Icons.search, size: 30),
          Icon(Icons.bolt, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _isSelected = index;
          });
        },
      ),
      body:
          ModalProgressHUD(inAsyncCall: isLoading, child: _pages[_isSelected]),
    );
  }
}
