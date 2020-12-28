import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:xlancer/Models/projectinfo.dart';
import 'package:xlancer/Models/user.dart';
import 'package:xlancer/Screens/Projects/profileItem.dart';
import 'package:xlancer/Screens/Projects/viewProfile.dart';
import 'package:xlancer/Widgets/SuccessMessageDialog.dart';

class ProjectDescription extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final String price;
  bool isSaved;
  final String level;
  DateTime deadline;
  final String ownerId;
  DateTime date;

  ProjectDescription(
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
  Widget build(BuildContext context) {
    final apply = Provider.of<ProjectsInfo>(context, listen: false);

    //final project = Provider.of<Projects>(context, listen: false);
    final user = Provider.of<User>(context, listen: false);
    bool isApproved = false;
    bool isComplete = false;
    Future<bool> checkifapplied() async {
      var isapplied = await apply.isApplied(id, user.userId);
      isApproved = await apply.isApprove(id, user.userId);
      isComplete = await apply.isComplete(id, user.userId);
      return isapplied;
    }

    Future<String> confirmedCampaignSubmit() async {
      var msg = '';
      Map<String, dynamic> appliedProject = {
        'pid': id,
        'ownerId': ownerId,
        'appId': user.userId,
      };

      try {
        msg = await apply.applyForProject(appliedProject);
      } catch (e) {
        print(e);
      }
      return msg;
    }

    Future<void> _confirmationDialogBox() async {
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0)), //this right here
          child: Container(
            height: 350.0,
            width: 300.0,
            child: FutureBuilder(
                future: confirmedCampaignSubmit(),
                builder: (ctx, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    final msg = snap.data as String;
                    if (msg == '') {
                      return successMessage(context, 'Thankyou For Applying!');
                    } else {
                      return errorMsg(context, msg);
                    }
                  }
                }),
          ),
        ),
      );
    }

    Future<void> _showMyDialog() async {
      return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Container(
            height: 350.0,
            width: 300.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Are you sure?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Apply At $title',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 30.0)),
                FlatButton(
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Theme.of(context).accentColor,
                    ),
                    child: Center(
                      child: Text(
                        'Confirm',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.purple, fontSize: 20.0),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    _confirmationDialogBox();
                  },
                ),
                SizedBox(height: 15),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Theme.of(context).accentColor,
                    ),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.purple, fontSize: 18.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          // Padding(
          //     padding: EdgeInsets.only(right: 20.0),
          //     child: GestureDetector(
          //       onTap: () {
          //         final RenderBox box = context.findRenderObject();
          //         Share.share("text",
          //             subject: "subject",
          //             sharePositionOrigin:
          //                 box.localToGlobal(Offset.zero) & box.size);
          //       },
          //       child: Icon(Icons.share),
          //     )),
        ],
        title: Text(title),
      ),
      // FutureBuilder(
      //           future: confirmedCampaignSubmit(),
      //           builder: (ctx, snap) {
      //             if (snap.connectionState == ConnectionState.waiting) {
      //               return Center(
      //                 child: CircularProgressIndicator(),
      //               );
      //             } else {
      //               final msg = snap.data as String;
      //               if (msg == '') {
      //                 return successMessage(
      //                     context, 'Thankyou For Your Contribution!');
      //               } else {
      //                 return errorMsg(context, msg);
      //               }
      //             }
      //           }),
      body: FutureBuilder(
        future: checkifapplied(),
        builder: (ctx, snap) {
          print("Ap");
          print(snap.data);
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (user.userId != ownerId)
                  // RaisedButton(
                  //   color: Theme.of(context).primaryColor,

                  // ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: RawMaterialButton(
                          shape: new RoundedRectangleBorder(),
                          elevation: 0.0,
                          child: Container(
                            width: 200,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Theme.of(context).accentColor,
                            ),
                            child: Center(
                              child: snap.data == false
                                  ? Text(
                                      "Apply",
                                      //:"Applied",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                      ),
                                    )
                                  : isApproved
                                      ? Text(
                                          "Approved",
                                          //:"Applied",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                          ),
                                        )
                                      : Text(
                                          "Applied",
                                          //:"Applied",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                          ),
                                        ),
                            ),
                          ),
                          onPressed: () {
                            snap.data == false ? _showMyDialog() : null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      if (isApproved)
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: RawMaterialButton(
                            shape: new RoundedRectangleBorder(),
                            elevation: 0.0,
                            onPressed: () async {
                              await apply.finishProject(id, user.userId);
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              width: 200,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Theme.of(context).accentColor,
                              ),
                              child: Center(
                                child: Text(
                                  "Mark as Done",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                if (user.userId == ownerId)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: RawMaterialButton(
                      shape: new RoundedRectangleBorder(),
                      elevation: 0.0,
                      child: Container(
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Theme.of(context).accentColor,
                        ),
                        child: Center(
                          child: Text(
                            "View Requests",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(ProfileItem.routeName,
                            arguments: ProjectDescription(
                              id,
                              title,
                              description,
                              price,
                              isSaved,
                              level,
                              deadline,
                              ownerId,
                              date,
                            ));
                        // ProfileItem(id);
                      },
                    ),
                  ),
              ],
            );
          }
        },
      ),
    );
  }
}
