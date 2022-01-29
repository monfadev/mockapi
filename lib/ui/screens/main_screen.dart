import 'package:flutter/material.dart';
import 'package:my_http_mockapi/ui/pages/home_page.dart';

import 'create_user_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> widgets = [
    HomePage(),
    Center(child: Text("Coming Soon")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("http", style: TextStyle(color: Colors.black))),
      body: widgets[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Person"),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black.withOpacity(.5),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      floatingActionButton: (_currentIndex == 0)
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateUserScreen()));
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}
