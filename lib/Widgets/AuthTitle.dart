import 'package:flutter/material.dart';
import 'package:mudahjev3/Utils/constant.dart';

class AuthTitle extends StatelessWidget {
  final String title;
  final String desc;

  AuthTitle({
    required this.title,
    required this.desc
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,textAlign:TextAlign.start,style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w500,
          color: Color(kPrimaryColor),
        ),),
        Text(desc)
      ],
    );
  }
}
