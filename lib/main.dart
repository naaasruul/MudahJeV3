import 'package:flutter/material.dart';
import 'package:mudahjev3/Screen/LoginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mudahjev3/Screen/Registration.dart';
import 'package:provider/provider.dart';
import 'MyProvider/auth_provider.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures that Flutter is ready before initializing Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Using the generated configuration options
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
  ],child: MyApp(),));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MUDAH JE V3',

      theme: ThemeData(
        fontFamily: 'Quicksand',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18, color: Colors.black),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black),
          bodySmall:TextStyle(fontSize: 12, color: Colors.black)
        ),
        scaffoldBackgroundColor: Color(0xFFf1f1f1),
      ),
      home: LoginScreen(),
    );
  }
}
