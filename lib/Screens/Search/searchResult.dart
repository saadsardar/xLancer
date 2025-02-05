import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlancer/Models/project.dart';
import 'package:xlancer/Screens/Projects/project_item.dart';

class SearchResultScreen extends StatelessWidget {
  static const routeName = '/searchResult-screen';
  @override
  Widget build(BuildContext context) {
    final searchString = ModalRoute.of(context).settings.arguments as String;
    final pattern = searchString.toLowerCase();
    List<Project> searchedCases;

    Future<void> getPatterns() async {
      searchedCases = await Provider.of<Projects>(context, listen: false)
          .searchProject(pattern);
    }

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Search Results For \'$searchString\'',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            FutureBuilder(
              future: getPatterns(),
              builder: (ctx, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return SearchComplete(
                    searchedCases: searchedCases,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SearchComplete extends StatelessWidget {
  final searchedCases;
  SearchComplete({this.searchedCases});

  @override
  Widget build(BuildContext context) {
    Widget heading(String heading) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Text(
          heading,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (searchedCases.length == 0)
          Center(
            child: Text(
              'No Results Found.',
              // textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        if (searchedCases.length > 0) heading('Projects'),
        if (searchedCases.length > 0)
          SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (ctx, i) => ProjectItem(
                    searchedCases[i].id,
                    searchedCases[i].title,
                    searchedCases[i].description,
                    searchedCases[i].price,
                    searchedCases[i].isSaved,
                    searchedCases[i].level,
                    searchedCases[i].deadline,
                    searchedCases[i].ownerId,
                    searchedCases[i].date,
                    //loadedProjects[i].skills,
                  ),
                  padding: const EdgeInsets.all(10),
                  itemCount: searchedCases.length,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
