import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mudahjev3/Screen/LoginScreen.dart';
import 'package:mudahjev3/Utils/constant.dart';
import 'package:mudahjev3/Widgets/AuthFooter.dart';
import 'package:mudahjev3/Widgets/AuthTitle.dart';
import 'package:mudahjev3/Widgets/MainButton.dart';
import 'package:mudahjev3/Widgets/MyButton.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

final _auth = FirebaseAuth.instance;

class _RegistrationState extends State<Registration> {
  Future<void> addUserToFirestore(String username, int initialScore) async {
    // Get current user's UID
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    print('UID:: $uid');

    // Reference to the Firestore 'users' collection
    final userRef = FirebaseFirestore.instance.collection('users').doc(uid);

    // Add or update the user document
    await userRef.set({
      'highestScore': initialScore,
      'username': username,
      'quizHistory': [],
    });
  }

  Future<void> registerUser(
      String email, String password, String username) async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = newUser.user;
      user?.updateProfile(displayName: username); //added this line

      await addUserToFirestore(username, 0);

      print(newUser);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } catch (e) {
      print('ERROR:::: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool showSpinner = false;
    String email = '';
    String password = '';
    String name = '';

    return Scaffold(
      backgroundColor: const Color(0xFFf1f1f1),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(bottom: 50),
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('assets/logo.png'),
                    ),
                  ),
                ),
              ),
              AuthTitle(
                  title: 'Register',
                  desc: 'Please enter details to register'),

              SizedBox(
                height: 8,
              ),
              TextField(
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black),
                onChanged: (value) {
                  //Do something with the user input.\
                  name = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your name'),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black),
                onChanged: (value) {
                  //Do something with the user input.\
                  email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black),
                onChanged: (value) {
                  //Do something with the user input.
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              const SizedBox(
                height: 24.0,
              ),

              MainButton(
                onPress: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  await registerUser(email, password, name);

                  setState(() {
                    showSpinner = false;
                  });

                  //Implement registration functionality.
                  //     print(email);
                  //     print(password);
                },
                text: 'Register',
                buttonColor: const Color(kPrimaryColor),
              ),

              AuthFooter(navigatorText:'Login',text: 'Already have an account?', navigator: (){
                Navigator.pop(context);
              })
            ],
          ),
        ),
      ),
    );
  }
}

