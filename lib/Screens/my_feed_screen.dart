import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlancer/Models/project.dart';

import 'Projects/project_item.dart';

class MyFeedScreen extends StatefulWidget {
  @override
  _MyFeedScreenState createState() => _MyFeedScreenState();
}

class _MyFeedScreenState extends State<MyFeedScreen> {
  List<Project> loadedProjects = [];

  @override
  Widget build(BuildContext context) {
    //bool isInit = false;
    final projects = Provider.of<Projects>(context, listen: false);

    // Future<void> _getData() async {
    //   loadedProjects = await projects.getProjectList;
    //   //isInit = true;
    //   setState(() {});
    // }

    // Future<void> _getInitData() async {
    //   if (cases.casesCount != 0) {
    //     await _getData();
    //   }
    // }

    return
        //isInit
        //  ?
        // RefreshIndicator(
        //     child: FutureBuilder(
        //       future: _getData(),
        //       builder: (ctx, snap) {
        //         if (snap.connectionState == ConnectionState.waiting) {
        //           return CircularProgressIndicator();
        //         } else {
        //           if (snap.hasError) {
        //             return Text(snap.error);
        //           } else {
        //             return Scaffold(
        //               body: ListView.builder(
        //                 itemBuilder: (ctx, i) => ProjectItem(
        //                   //loadedProjects[i].id,
        //                   loadedProjects[i].title,
        //                   loadedProjects[i].description,
        //                   loadedProjects[i].price,
        //                   loadedProjects[i].isSaved,
        //                   loadedProjects[i].level,
        //                   loadedProjects[i].deadline,
        //                   loadedProjects[i].ownerId,
        //                   loadedProjects[i].date,
        //                 ),
        //                 padding: const EdgeInsets.all(10),
        //                 itemCount: loadedProjects.length,
        //               ),
        //             );
        //           }
        //         }
        //       },
        //     ),
        //     onRefresh: _getData,
        //   )
        //:
        FutureBuilder(
      future: projects.getProjectList,
      // _getData(),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          print('hello');
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else {
          if (snap.hasError) {
            return Text(snap.error);
          } else {
            final loadedProjects = snap.data as List<Project>;
            print('Reached here');
            if (loadedProjects.isEmpty) {
             return
             Scaffold(
                body: Center(child: Text('There are no Projects to show'),)
              );
              
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
