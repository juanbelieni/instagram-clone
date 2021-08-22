import 'package:flutter/material.dart';
import 'package:instagram_clone/app/user/user_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: UserScreen(),
    );
  }
}