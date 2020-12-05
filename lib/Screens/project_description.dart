import 'package:flutter/material.dart';

class ProjectDescription extends StatelessWidget {
  String title;
  String deadline;
  double price;
  String description;
  String skills;

  ProjectDescription(
    this.title,
    this.deadline,
    this.price,
    this.description,
    this.skills,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Details'),
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
              deadline,
              style: TextStyle(
                fontSize: 19,
                color: Colors.indigo,
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
              'Skills Required',
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
              skills,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
