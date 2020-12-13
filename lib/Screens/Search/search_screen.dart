import 'package:flutter/material.dart';
import 'package:xlancer/Widgets/searchbar.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SearchBar(),
      ],)
    );
  }
}