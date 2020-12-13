import 'package:flutter/material.dart';
import 'package:xlancer/Screens/Search/searchResult.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _searchControl = new TextEditingController();
  // @override
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _searchControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: TextField(
        controller: _searchControl,
        style: TextStyle(
          fontSize: 15.0,
          color: Theme.of(context).primaryColor,
        ),
        textInputAction: TextInputAction.search,
        onSubmitted: (v) {
          print(_searchControl.text);
          Navigator.of(context).pushNamed(SearchResultScreen.routeName,
              arguments: _searchControl.text.trim());
        },
        maxLines: 1,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          hintText: "Search Projects",
          prefixIcon: Icon(
            Icons.search,
            color: Colors.blueGrey[300],
          ),
          hintStyle: TextStyle(
            fontSize: 15.0,
            color: Colors.blueGrey[300],
          ),
        ),
      ),
    );
  }
}
