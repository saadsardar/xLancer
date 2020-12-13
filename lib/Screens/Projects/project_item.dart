import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:xlancer/Models/project.dart';
import 'package:xlancer/Screens/Projects/project_description.dart';

class ProjectItem extends StatefulWidget {
  final String id;
  final String title;
  final String description;
  final String price;
  bool isSaved;
  final String level;
  DateTime deadline;
  final String ownerId;
  DateTime date;

  ProjectItem(
    this.id,
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
  _ProjectItemState createState() => _ProjectItemState();
}

class _ProjectItemState extends State<ProjectItem> {
  void func() {
    print("In func");
  }

  @override
  Widget build(BuildContext context) {
    final projects = Provider.of<Projects>(context, listen: false);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProjectDescription(
              widget.title,
              widget.description,
              widget.price,
              widget.isSaved,
              widget.level,
              widget.deadline,
              widget.ownerId,
              widget.date,
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
                      widget.title,
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
                // GestureDetector(
                //   onTap: () {
                //     print('dislike');
                //     func();
                //   },
                //   child: CircleAvatar(
                //     backgroundColor: Colors.lightGreen,
                //     child: Icon(
                //       Icons.thumb_down,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    print(widget.id);
                    projects.deleteProject(widget.id);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.delete,
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
                    '\u{20B9}${widget.price}',
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
                widget.level,
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
                //widget.deadline.toString(),
                DateFormat('yyyy-MM-dd').format(widget.deadline),
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
