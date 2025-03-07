import 'package:flutter/material.dart';
import 'package:mudahjev3/Screen/NoteVideo.dart';
import 'package:mudahjev3/Utils/constant.dart';
import 'package:mudahjev3/Widgets/MyAppBar.dart';
import 'package:transformable_list_view/transformable_list_view.dart';

class LessonScreen extends StatefulWidget {
  final Map<String, dynamic> category;

  LessonScreen({
    required this.category
});
  @override
  State<LessonScreen> createState() => _LessonScreenState();
}


class _LessonScreenState extends State<LessonScreen> {
  Matrix4 getTransformMatrix(TransformableListItem item) {
    /// final scale of child when the animation is completed
    const endScaleBound = 0.3;

    /// 0 when animation completed and [scale] == [endScaleBound]
    /// 1 when animation starts and [scale] == 1
    final animationProgress = item.visibleExtent / item.size.height;

    /// result matrix
    final paintTransform = Matrix4.identity();

    /// animate only if item is on edge
    if (item.position != TransformableListItemPosition.middle) {
      final scale = endScaleBound + ((1 - endScaleBound) * animationProgress);

      paintTransform
        ..translate(item.size.width / 2)
        ..scale(scale)
        ..translate(-item.size.width / 2);
    }

    return paintTransform;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(title: 'Lesson', backButton: true),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  widget.category['title'],
                  style: TextStyle(fontSize: 32, color: Color(kBlackColor)),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      var notes = widget.category['lessons']['notes'][index];
                      var listNotes = widget.category['lessons']['notes'];
                      return ListTile(
                        title: Text(notes['title']),
                        subtitle: Text(notes['description']),
                        leading: Icon(Icons.star),
                        onTap: () {
                          // Handle tap if needed
                          print('LALALA:: ${notes}');
                          print('go to next push index $index');

                        //   pass the notes to the next page
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>NoteVideo(
                            content: listNotes,
                          currentIndex: index,
                          //   pass data here

                          )));
                        },
                      );
                    },
                    itemCount: widget.category['lessons']['notes'].length,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
//
// TransformableListView.builder
// (
// getTransformMatrix: getTransformMatrix,
// itemBuilder: (context, index) {
// return Container(
// height: 100,
// margin: const EdgeInsets.symmetric(
// horizontal: 16,
// vertical: 4,
// ),
// decoration: BoxDecoration(
// color: index.isEven ? Colors.grey : Colors.blueAccent,
// borderRadius: BorderRadius.circular(20),
// ),
// alignment: Alignment.center,
// child: Text(index.toString()),
// );
// },
// itemCount
// :
// 2
// ,
// )
// ,
