import 'package:flutter/material.dart';

import 'ui/screens/main_screen.dart';

void main() {
  runApp(Root());
}

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "http",
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(backgroundColor: Colors.white, elevation: 0),
        scaffoldBackgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      home: MainScreen(),
    );
  }
}
