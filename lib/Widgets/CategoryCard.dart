import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mudahjev3/Screen/LessonScreen.dart';
import 'package:mudahjev3/Utils/constant.dart';

final _firestore = FirebaseFirestore.instance;

class CategoryStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
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
            var categoryCard = CategoryCard(
              type: 'note',
                title: categoryData['title'],
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LessonScreen(
                                // send data to lesson screen inside here
                                category: categoryData,
                              )));
                });

            categoryList.add(categoryCard);
            print(categoryData);
          }

          return Expanded(
              child: GridView.count(
            crossAxisCount: 2,
            children: categoryList,
          ));
        });
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String type;
  final VoidCallback onTap;

  CategoryCard({
    required this.title,
    required this.onTap,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 4.0,
        child: Center(
          child: RichText(text: TextSpan(children: [
            WidgetSpan(child: type == 'note'? Icon(Icons.import_contacts) : Icon(Icons.emoji_objects_outlined)),
            TextSpan(
              text: ' $title',
              style:const TextStyle(color: Colors.black, fontSize: 20),
            )
          ])),
        ),
      ),
    );
  }
}
