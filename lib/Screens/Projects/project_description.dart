import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:xlancer/Models/project.dart';
import 'package:xlancer/Models/projectinfo.dart';
import 'package:xlancer/Models/user.dart';

class ProjectDescription extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  bool isSaved;
  final String level;
  DateTime deadline;
  final String ownerId;
  DateTime date;

  ProjectDescription(
    this.title,
    this.description,
    this.price,
    this.isSaved,
    this.level,
    this.deadline,
    this.ownerId,
    this.date,
  );
  @override
  Widget build(BuildContext context) {
    final apply = Provider.of<ProjectsInfo>(context, listen: false);
    final project = Provider.of<Projects>(context, listen: false);
    final user = Provider.of<User>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Center(
              child: Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          )),
          ListTile(
            leading: Icon(
              Icons.access_time,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              // deadline.toString(),
              DateFormat('yyyy-MM-dd').format(deadline),
              style: TextStyle(
                fontSize: 19,
                color: Colors.green,
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Text(
              'Project Budget',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            //color: Colors.amberAccent,
            height: 70,
            //width: double.infinity,
            child: Text(
              '$price\\-',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Text(
              'Expirence Required',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Text(
              level,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          RaisedButton(
            onPressed: () {
              Map<String, dynamic> appliedProject = {
                // 'pid': project.id,
                // 'ownerId': project.ownerId,
                'appId': user.userId,
              };
              apply.applyForProject(appliedProject);
            },
            child: Text("Apply"),
          )
        ],
      ),
    );
  }
}
