import 'package:flutter/material.dart';
import 'package:xlancer/Screens/saved_screen.dart';
import 'package:xlancer/Screens/search_screen.dart';

import 'drawer.dart';
import 'my_feed_screen.dart';


class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'JOBS',
          ),
          bottom: TabBar(tabs: <Widget>[
            Tab(
              child: Text(
                'My Feed',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Tab(
              child: Text(
                'Search',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Tab(
              child: Text(
                'Saved',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ]),
        ),
        body: TabBarView(
          children: <Widget>[
            MyFeedScreen(),
            SearchScreen(),
            SavedScreen(),
          ],
        ),
      ),
    );
  }
}
