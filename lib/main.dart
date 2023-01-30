import 'package:demo_chat/chat_page.dart';
import 'package:demo_chat/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: ChatPage(),
      home: HomePage(),
    );
  }
}
