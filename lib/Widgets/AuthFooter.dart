import 'package:flutter/material.dart';
import 'package:mudahjev3/Utils/constant.dart';
class AuthFooter extends StatelessWidget {
  final String text;
  final String navigatorText;
  final VoidCallback navigator;

  AuthFooter({
    required this.text,
    required this.navigator,
    required this.navigatorText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text),
          GestureDetector(
              onTap: navigator,
              child: Text(
                navigatorText,
                style: TextStyle(color: Color(kPrimaryColor)),
              )),
        ],
      ),
    );
  }
}
