import 'package:flutter/material.dart';
import 'package:mudahjev3/Screen/LessonScreen.dart';
import 'package:mudahjev3/Utils/constant.dart';
import 'package:mudahjev3/Widgets/CategoryCard.dart';
import 'package:mudahjev3/Widgets/ProfileCard.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NoteScreen extends StatefulWidget {
  final User username;

  NoteScreen({required this.username});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ProfileCard(
            user: widget.username,
          ),
          const SizedBox(
            height: 32,
          ),
          const Text(
            'Categories',
            style: TextStyle(fontSize: 32,color: Color(kSecondaryColor)),
          ),
          const SizedBox(
            height: 32,
          ),
          CategoryStream()
        ],
      ),
    );
  }
}


