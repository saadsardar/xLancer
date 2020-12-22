import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlancer/Models/freelancer.dart';
import 'package:xlancer/Models/projectinfo.dart';
import 'package:xlancer/Models/user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:xlancer/ProfileScreens/certficates.dart';
import 'package:xlancer/ProfileScreens/name.dart';
import 'package:xlancer/ProfileScreens/portfolio.dart';
import 'package:xlancer/ProfileScreens/skills.dart';

class ViewProfilePage extends StatefulWidget {
  static const routeName = '/View-Profile';
  String pid;
  String userId;
  String name;
  String picture;
  String location;
  String title;
  String rate;
  String summary;
  List<String> portfolio;
  List<String> skills;
  List<String> certifications;
  //List<String> comments;
  String ratings;
  ViewProfilePage(
    this.pid,
    this.userId,
    this.name,
    this.picture,
    this.location,
    this.title,
    this.rate,
    this.summary,
    this.portfolio,
    this.skills,
    //this.comments,
    this.ratings,
    this.certifications,
  );

  @override
  _ViewProfilePageState createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<User>(context, listen: false);
    final userInfo2 = Provider.of<Freelancer>(context, listen: false);
    final pp = Provider.of<ProjectsInfo>(context, listen: false);
    print("userInfo2.portfolio");
    print(userInfo2.skills);
    //buildPortfolio() {}
    buildSkills(List<String> tags) {
      return Container(
        padding: EdgeInsets.only(left: 20),
        height: 200.0,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            primary: false,
            itemCount: tags.length == 0 ? 0 : tags.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.green, spreadRadius: 1),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.work),
                    Container(
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(10),
                      //   color: Colors.white,
                      //   boxShadow: [
                      //     BoxShadow(color: Colors.green, spreadRadius: 3),
                      //   ],
                      // ),
                      child: Text(
                        tags[index],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // IconButton(
                    //   onPressed: () async {
                    //       await userInfo2.delelteSkill(tags[index]);
                    //       setState(() {});
                    //     },
                    //   icon: Icon(
                    //     Icons.delete,
                    //     color: Colors.red,
                    //   ),
                    // ),
                  ],
                ),
              );
            }),
      );
    }

    buildSlider(List<String> images) {
      return Container(
        padding: EdgeInsets.only(left: 20),
        height: 200.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          primary: false,
          itemCount: images.length == 0 ? 0 : images.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      images[index],
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          ),
                        );
                      },
                      height: 250.0,
                      width: MediaQuery.of(context).size.width * 0.8,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Positioned(
                  //   top: 5,
                  //   right: 10,
                  //   child: IconButton(
                  //       icon: Icon(
                  //         Icons.delete,
                  //         color: Colors.red,
                  //       ),
                  //       onPressed: () async {
                  //         await userInfo2.deleltePortfolio(images[index]);
                  //         setState(() {});
                  //       }),
                  // ),
                ],
              ),
            );
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          RaisedButton(
            child: Text("Approve"),
            onPressed: () {
              print(widget.userId);
              pp.approveRequest(widget.pid, widget.userId);
            },
          )
        ],
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            child: Row(
              children: [
                //Text(userInfo.name.toString()),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: userInfo.picture == ''
                      ? AssetImage(
                          'assets/nopost.png',
                        )
                      : NetworkImage(
                          userInfo.picture,
                        ),
                ),
                // IconButton(
                //   color: Theme.of(context).accentColor,
                //   icon: Icon(
                //     Icons.edit,
                //     size: 18,
                //   ),
                //   onPressed: () {
                //     Navigator.of(context)
                //         .pushNamed(EditPicture.routeName)
                //         .then((value) => setState(() {}));
                //   },
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          children: [
                            Text(
                              userInfo.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              color: Theme.of(context).accentColor,
                              icon: Icon(
                                Icons.edit,
                                size: 18,
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(EditName.routeName)
                                    .then((value) => setState(() {}));
                              },
                            ),
                          ],
                        ),
                      ),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              FontAwesomeIcons.locationArrow,
                              size: 15,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child:
                                //userInfo2.location == ''
                                //  ? null
                                //:
                                Text(
                              userInfo2.location ?? 'Choose Location',
                              // 'Karachi, Pakistan',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // IconButton(
                          //   color: Theme.of(context).accentColor,
                          //   icon: Icon(
                          //     Icons.edit,
                          //     size: 18,
                          //   ),
                          //   onPressed: () {
                          //     Navigator.of(context)
                          //         .pushNamed(EditLocation.routeName)
                          //         .then((value) => setState(() {}));
                          //   },
                          // ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[200],
            height: 10,
          ),
          Container(
            child: Row(
              children: [
                //if title is null then add title
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                  ),
                  child: Row(
                    children: [
                      // userInfo2.title == ''
                      //     ? null
                      //:
                      Text(
                        userInfo2.title ?? 'Add Title',
                        //'Flutter Developer',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // IconButton(
                      //   color: Theme.of(context).accentColor,
                      //   icon: Icon(
                      //     Icons.edit,
                      //     size: 18,
                      //   ),
                      //   onPressed: () {
                      //     Navigator.of(context)
                      //         .pushNamed(EditTitle.routeName)
                      //         .then((value) => setState(() {}));
                      //   },
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //           Container(
          //   color: Colors.grey[200],
          //   height: 10,
          // ),
          Container(
            child: Row(
              children: [
                //if title is null then add title
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                  ),
                  child: Row(
                    children: [
                      //userInfo2.rate == ''
                      //? null
                      //:
                      Text('\$'),
                      Text(
                        userInfo2.rate ?? 'Add your Rate',
                        //'9.00/hr',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // IconButton(
                      //   color: Theme.of(context).accentColor,
                      //   icon: Icon(
                      //     Icons.edit,
                      //     size: 18,
                      //   ),
                      //   onPressed: () {
                      //     Navigator.of(context)
                      //         .pushNamed(EditRate.routeName)
                      //         .then((value) => setState(() {}));
                      //   },
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                //if title is null then add title
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                  ),
                  child: Row(
                    children: [
                      Container(
                        child:
                            //userInfo2.summary == ''
                            //  ? null
                            //:
                            Text(
                          userInfo2.summary ?? 'Add Summary',
                          //'dsvbihabicbajcoaocadocbadobcoadbuoabcoa',
                          style: TextStyle(
                            fontSize: 15,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // IconButton(
                      //   color: Theme.of(context).accentColor,
                      //   icon: Icon(Icons.edit, size: 18),
                      //   onPressed: () {
                      //     Navigator.of(context)
                      //         .pushNamed(EditSummary.routeName)
                      //         .then((value) => setState(() {}));
                      //   },
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            //color: Colors.grey[200],
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  //                   <--- left side
                  color: Colors.black,
                  width: 0.5,
                ),
                top: BorderSide(
                  //                    <--- top side
                  color: Colors.black,
                  width: 0.5,
                ),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Portfolio',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                        child: IconButton(
                          color: Theme.of(context).accentColor,
                          icon: Icon(Icons.add),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(AddPortfolio.routeName)
                                .then((value) => setState(() {}));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // if (

                userInfo2.portfolio == null || userInfo2.portfolio.isEmpty
                    //)
                    //   {
                    ? Column(
                        children: [
                          Image.asset(
                            'assets/nopost.png',
                            height: 150,
                            width: 150,
                          ),
                          // Center(
                          //   child: Text(
                          //     "Ask for details in chat",
                          //     style: TextStyle(
                          //       fontSize: 20,
                          //       fontWeight: FontWeight.bold,
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          // // Center(
                          //   child: FlatButton(
                          //     onPressed: () {
                          //       Navigator.of(context)
                          //           .pushNamed(AddPortfolio.routeName)
                          //           .then((value) => setState(() {}));
                          //     },
                          //     child: Text(
                          //       "Add items",
                          //       style: TextStyle(
                          //         color: Colors.green,
                          //         fontSize: 20,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      )

                    // else
                    //   {
                    //   if(userInfo2.portfolio.isEmpty)
                    //    Text('data')

                    : buildSlider(userInfo2.portfolio),
                //},
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          // Container(
          //   //color: Colors.grey[200],
          //   height: 20,
          // ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  //                   <--- left side
                  color: Colors.black,
                  width: 0.5,
                ),
                top: BorderSide(
                  //                    <--- top side
                  color: Colors.black,
                  width: 0.5,
                ),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Skills',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                        child: IconButton(
                          color: Theme.of(context).accentColor,
                          icon: Icon(Icons.add),
                          onPressed: () {
                            //     Navigator.of(context)
                            // .pushNamed(EditSkills.routeName)
                            // .then((value) => setState(() {}));
                            Navigator.of(context)
                                .pushNamed(EditSkills.routeName)
                                .then((value) => setState(() {}));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                userInfo2.skills == null || userInfo2.skills.isEmpty
                    ? Column(
                        children: [
                          Image.asset(
                            'assets/nopost.png',
                            height: 150,
                            width: 150,
                          ),
                          // Center(
                          //   child: Text(
                          //     "Showcase your work to impress clients",
                          //     style: TextStyle(
                          //       fontSize: 20,
                          //       fontWeight: FontWeight.bold,
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          // Center(
                          //   child: FlatButton(
                          //     onPressed: () {
                          //       Navigator.of(context)
                          //           .pushNamed(AddPortfolio.routeName)
                          //           .then((value) => setState(() {}));
                          //     },
                          //     child: Text(
                          //       "Add items",
                          //       style: TextStyle(
                          //         color: Colors.green,
                          //         fontSize: 20,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      )
                    : //Text("data"),
                    buildSkills(userInfo2.skills),
              ],
            ),

            //list here which shows skills tags
          ),
          Container(
            color: Colors.grey[200],
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  //                   <--- left side
                  color: Colors.black,
                  width: 0.5,
                ),
                top: BorderSide(
                  //                    <--- top side
                  color: Colors.black,
                  width: 0.5,
                ),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Certifications',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.white,
                          child: IconButton(
                            color: Theme.of(context).accentColor,
                            icon: Icon(Icons.add),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(AddCertificate.routeName)
                                  .then((value) => setState(() {}));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                userInfo2.certifications == null ||
                        userInfo2.certifications.isEmpty
                    //)
                    //   {
                    ? Column(
                        children: [
                          Image.asset(
                            'assets/nopost.png',
                            height: 150,
                            width: 150,
                          ),
                          // Center(
                          //   child: Text(
                          //     "Showcase your Certificates to impress clients",
                          //     style: TextStyle(
                          //       fontSize: 20,
                          //       fontWeight: FontWeight.bold,
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          // Center(
                          //   child: FlatButton(
                          //     onPressed: () {
                          //       Navigator.of(context)
                          //           .pushNamed(AddPortfolio.routeName)
                          //           .then((value) => setState(() {}));
                          //     },
                          //     child: Text(
                          //       "Add items",
                          //       style: TextStyle(
                          //         color: Colors.green,
                          //         fontSize: 20,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      )

                    // else
                    //   {
                    //   if(userInfo2.portfolio.isEmpty)
                    //    Text('data')

                    : buildSlider(userInfo2.certifications),
                //},
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
