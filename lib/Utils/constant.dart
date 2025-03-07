import 'package:flutter/material.dart';

const kTextFieldDecoration =  InputDecoration(
  hintText: 'Enter a value',
  contentPadding:
  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(kPrimaryColor), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color:Color(kPrimaryColor), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);


const int kPrimaryColor = 0xFF63C196;
const int kSecondaryColor = 0xFF23577A;
const int kTertiary = 0xffAFD9E0;
const int kBlackColor = 0xFF080f0f;
const int kWhiteColor = 0xFFf1f1f1;