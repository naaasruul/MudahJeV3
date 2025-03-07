import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mudahjev3/Screen/LessonScreen.dart';
import 'package:mudahjev3/Screen/QuizScreen.dart';
import 'package:mudahjev3/Widgets/CategoryCard.dart';

final _firestore = FirebaseFirestore.instance;
class ExerciseStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('categories').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }

          final categories = snapshot.data?.docs;
          List<CategoryCard> categoryList = [];

          for (var category in categories!) {
            final categoryData = category.data() as Map<String, dynamic>;
            var categoryCard =
            CategoryCard(title:'Quiz \n ${categoryData['title']}',type: 'exercise', onTap: () {
              print(categoryData['lessons']['quizzes']);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>QuizScreen(
                // send data to lesson screen inside here
                content: categoryData['lessons']['quizzes'],
              )));
            });

            categoryList.add(categoryCard);
          }

          return Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: categoryList,
              ));
        });
  }
}

