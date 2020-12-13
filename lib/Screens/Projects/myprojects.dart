import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlancer/Models/project.dart';
import 'package:xlancer/Models/user.dart';
import 'package:xlancer/Screens/Projects/project_item.dart';


class MyProjectScreen extends StatefulWidget {
  @override
  _MyProjectScreenState createState() => _MyProjectScreenState();
}

class _MyProjectScreenState extends State<MyProjectScreen> {
  List<Project> loadedProjects = [];

  @override
  Widget build(BuildContext context) {
    final projects = Provider.of<Projects>(context, listen: false);
    final user = Provider.of<User>(context, listen: false);
    return FutureBuilder(
      future: projects.getMyProjectList(user),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else {
          if (snap.hasError) {
            return Text(snap.error);
          } else {
            final loadedProjects = snap.data as List<Project>;
            //print('super');
            //print(loadedProjects[0].id);

            if (loadedProjects.isEmpty) {
              return Scaffold(
                  // floatingActionButton: FloatingActionButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => NewProjectScreen()),
                  //     );
                  //     //NewProjectScreen();
                  //   },
                  //   child: Icon(Icons.add),
                  //   backgroundColor: Theme.of(context).accentColor,
                  // ),
                  //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                  body: Center(
                    child: Text('You have not uploaded any Projects'),
                  ));
            } else {
              return Scaffold(
                // floatingActionButton: FloatingActionButton(
                //   onPressed: () {
                //     Navigator.of(context).pushNamedAndRemoveUntil(
                //         NewProjectScreen.routeName, (route) => false);
                //   },
                //   child: Icon(Icons.add),
                //   backgroundColor: Theme.of(context).primaryColor,
                // ),
                //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                body: ListView.builder(
                  itemBuilder: (ctx, i) => ProjectItem(
                    loadedProjects[i].id,
                    loadedProjects[i].title,
                    loadedProjects[i].description,
                    loadedProjects[i].price,
                    loadedProjects[i].isSaved,
                    loadedProjects[i].level,
                    loadedProjects[i].deadline,
                    loadedProjects[i].ownerId,
                    loadedProjects[i].date,
                    //loadedProjects[i].skills,
                  ),
                  padding: const EdgeInsets.all(10),
                  itemCount: loadedProjects.length,
                ),
              );
            }
          }
        }
      },
    );
  }
}
