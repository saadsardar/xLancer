import 'package:flutter/material.dart';
import 'package:xlancer/Screens/project_description.dart';

class ProjectItem extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final String level;
  final String deadline;
  final String description;
  final String skills;

  ProjectItem(
    this.id,
    this.title,
    this.price,
    this.level,
    this.deadline,
    this.description,
    this.skills,
  );
  void func() {
    print("In func");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProjectDescription(
              title,
              deadline,
              price,
              description,
              skills,
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
                      title,
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
                GestureDetector(
                  onTap: () {
                    print('dislike');
                    func();
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.lightGreen,
                    child: Icon(
                      Icons.thumb_down,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    print('favourite');
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            ListTile(
              title: Row(
                children: [
                  //Icon(Icons.),
                  Text(
                    '\u{20B9}$price',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              subtitle: Text(
                'Budget',
                style: TextStyle(
                    fontSize: 19,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              trailing: Text(
                level,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
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
                  color: Colors.black,
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
