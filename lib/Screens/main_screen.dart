import 'package:flutter/material.dart';
import 'package:xlancer/Screens/profile.dart';
import 'jobs_screen.dart';
import 'message_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
   static const routeName = '/mainscreen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> _pages = [
    JobScreen(),
    MessageScreen(),
    ProfilePage(),
  ];

  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: AppDrawer(),
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 35,
              color: Colors.black,
            ),
            title: Text(
              'jobs',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              'message',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.message),
          //   title: Text('messaging'),
          // ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              'profile',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
        ],
        //backgroundColor: Colors.green[500],
        //selectedItemColor: Colors.grey,
      ),
    );
  }
}
