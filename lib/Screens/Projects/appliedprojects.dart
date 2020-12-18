import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlancer/Models/project.dart';
import 'package:xlancer/Models/projectinfo.dart';
import 'package:xlancer/Models/user.dart';
import 'package:xlancer/Screens/Projects/project_item.dart';

class AppliedProjectScreen extends StatefulWidget {
  @override
  _AppliedProjectScreenState createState() => _AppliedProjectScreenState();
}

class _AppliedProjectScreenState extends State<AppliedProjectScreen> {
  List<Project> loadedProjects = [];

  @override
  Widget build(BuildContext context) {
    final projects = Provider.of<ProjectsInfo>(context, listen: false);
    final plist = Provider.of<Projects>(context, listen: false);
    final user = Provider.of<User>(context, listen: false);
    Future<List<Project>> getProjects() async {
      List<String> list = await projects.getAppliedProjectList(user);
      //print(list);
      List<Project> list2 = await plist.getAppliedProjectList(list);
      return list2;
      //plist.getAppliedProjects(list);
    }

    ;
    return FutureBuilder(
      future: getProjects(),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else {
          if (snap.hasError) {
            return Text(snap.error);
          } else {
            final loadedProjects = snap.data as List<Project>;
            // print('super');
            // print(loadedProjects[0].id);
            if (loadedProjects.isEmpty) {
              return Scaffold(
                  body: Center(
                child: Text('You have not applied to any Projects'),
              ));
            } else {
              return Scaffold(
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
