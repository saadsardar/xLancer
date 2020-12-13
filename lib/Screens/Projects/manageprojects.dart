import 'package:flutter/material.dart';
import 'package:xlancer/Screens/Search/search_screen.dart';
import 'package:xlancer/Screens/saved_screen.dart';

import '../drawer.dart';

import 'myprojects.dart';


class ManageProjectScreen extends StatefulWidget {
  @override
  _ManageProjectScreenState createState() => _ManageProjectScreenState();
}

class _ManageProjectScreenState extends State<ManageProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Manage Projects',
          ),
          bottom: TabBar(tabs: <Widget>[
            Tab(
              child: Text(
                'My Projects',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Tab(
              child: Text(
                'Applied',
                style: TextStyle(fontSize: 20),
              ),
            ),
            // Tab(
            //   child: Text(
            //     'Saved',
            //     style: TextStyle(fontSize: 20),
            //   ),
            // ),
          ]),
        ),
        body: TabBarView(
          children: <Widget>[
            MyProjectScreen(),
            SearchScreen(),
            //SavedScreen(),
          ],
        ),
      ),
    );
  }
}
