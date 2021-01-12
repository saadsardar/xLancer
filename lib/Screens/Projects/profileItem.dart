import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlancer/Models/freelancer.dart';
import 'package:xlancer/Models/project.dart';
import 'package:xlancer/Models/projectinfo.dart';
import 'package:xlancer/Screens/Projects/project_description.dart';
import 'package:xlancer/Screens/Projects/viewProfile.dart';

class ProfileItem extends StatefulWidget {
  static const routeName = '/Profileitem';
  @override
  _ProfileItemState createState() => _ProfileItemState();
}

class _ProfileItemState extends State<ProfileItem> {
  List<Project> loadedProjects = [];

  @override
  Widget build(BuildContext context) {
    final ProjectDescription args = ModalRoute.of(context).settings.arguments;

    //bool isInit = false;
    final pinfo = Provider.of<ProjectsInfo>(context, listen: false);
    final freelancers = Provider.of<Freelancer>(context, listen: false);
    Future<List<Freelancer>> getRequests() async {
      //print("00");
      List<String> list = await pinfo.getRequests(args.id);
      // print('object111');
      // print(list);
      List<Freelancer> list2 = await freelancers.getRequestedUsers(list);
      print(list2);
      return list2;
    }

    return FutureBuilder(
      future: getRequests(),
      // _getData(),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          print('hello');
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else {
          if (snap.hasError) {
            return Text(snap.error);
          } else {
            final loadedProjects = snap.data as List<Freelancer>;
            print('Reached here');
            if (loadedProjects.isEmpty) {
              return Scaffold(
                  body: Center(
                child: Text('No one Applied yet'),
              ));
            } else {
              return Scaffold(
                // loadedProjects[i].id,
                body: ListView.builder(
                  itemBuilder: (ctx, i) {
                    return GestureDetector(
                      onTap: () {
                        print(loadedProjects[i].userId);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ViewProfilePage(
                              args.id,
                              loadedProjects[i].userId,
                              loadedProjects[i].name,
                              loadedProjects[i].picture,
                              loadedProjects[i].location,
                              loadedProjects[i].title,
                              loadedProjects[i].rate,
                              loadedProjects[i].summary,
                              loadedProjects[i].portfolio,
                              loadedProjects[i].skills,
                              loadedProjects[i].ratings,
                              loadedProjects[i].certifications,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 250,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: Container(
                                    padding: const EdgeInsets.all(13.0),
                                    child: Text(
                                      loadedProjects[i].name.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 150),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            ListTile(
                                // title: Row(
                                //   children: [
                                //     //Icon(Icons.),
                                //     Text(
                                //       '\u{20B9}${widget.price}',
                                //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                //     ),
                                //   ],
                                // ),
                                // subtitle: Text(
                                //   'Budget',
                                //   style: TextStyle(
                                //       fontSize: 19,
                                //       color: Colors.black,
                                //       fontWeight: FontWeight.w500),
                                // ),
                                // trailing: Text(
                                //   widget.level,
                                //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                // ),
                                ),
                            ListTile(
                              leading: Icon(
                                Icons.star,
                                size: 30,
                                color: Colors.black,
                              ),
                              // title: Text(
                              //   //widget.deadline.toString(),
                              //   DateFormat('yyyy-MM-dd').format(widget.deadline),
                              //   style: TextStyle(
                              //     fontSize: 19,
                              //     color: Colors.black,
                              //   ),
                              // ),
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
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
