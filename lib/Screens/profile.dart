import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlancer/Models/freelancer.dart';
import 'package:xlancer/Models/user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:xlancer/ProfileScreens/certficates.dart';
import 'package:xlancer/ProfileScreens/location.dart';
import 'package:xlancer/ProfileScreens/name.dart';
import 'package:xlancer/ProfileScreens/picture.dart';
import 'package:xlancer/ProfileScreens/portfolio.dart';
import 'package:xlancer/ProfileScreens/rate.dart';
import 'package:xlancer/ProfileScreens/skills.dart';
import 'package:xlancer/ProfileScreens/summary.dart';
import 'package:xlancer/ProfileScreens/title.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<User>(context, listen: false);
    final userInfo2 = Provider.of<Freelancer>(context, listen: false);
    buildPortfolio() {}
    buildSlider(List<String> images) {
      return Container(
        padding: EdgeInsets.only(left: 20),
        height: 250.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          primary: false,
          itemCount: images.length == 0
              ? 0
              // places == null ? 0 : places.length
              : images.length,
          itemBuilder: (BuildContext context, int index) {
            // Map place = places[index];
            // if (images.length == 0) {
            //   place = places[index];
            // } else {
            //   // place = images[index];
            // }

            return Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child:
                    //     // images.length == 0
                    //     //     ?
                    //     Image.asset(
                    //   "${place["img"]}",
                    //   height: 250.0,
                    //   width: MediaQuery.of(context).size.width - 40.0,
                    //   fit: BoxFit.cover,
                    // )
                    // :
                    Image.network(
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
            );
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
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
                          'assets/portfolio.jpeg',
                        )
                      : NetworkImage(
                          userInfo.picture,
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
                        .pushNamed(EditPicture.routeName)
                        .then((value) => setState(() {}));
                  },
                ),
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
                          IconButton(
                            color: Theme.of(context).accentColor,
                            icon: Icon(
                              Icons.edit,
                              size: 18,
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(EditLocation.routeName)
                                  .then((value) => setState(() {}));
                            },
                          ),
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
                      IconButton(
                        color: Theme.of(context).accentColor,
                        icon: Icon(
                          Icons.edit,
                          size: 18,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(EditTitle.routeName)
                              .then((value) => setState(() {}));
                        },
                      ),
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
                      IconButton(
                        color: Theme.of(context).accentColor,
                        icon: Icon(
                          Icons.edit,
                          size: 18,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(EditRate.routeName)
                              .then((value) => setState(() {}));
                        },
                      ),
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
                      IconButton(
                        color: Theme.of(context).accentColor,
                        icon: Icon(Icons.edit, size: 18),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(EditSummary.routeName)
                              .then((value) => setState(() {}));
                        },
                      ),
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
                // if (userInfo2.portfolio.isEmpty)
                //   {
                //     Image.asset(
                //       'assets/portfolio.jpeg',
                //       height: 150,
                //       width: 150,
                //     ),
                //     Center(
                //       child: Text(
                //         "Showcase your work to impress clients",
                //         style: TextStyle(
                //           fontSize: 20,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       height: 10,
                //     ),
                //     Center(
                //       child: FlatButton(
                //         onPressed: () {
                //           Navigator.of(context)
                //               .pushNamed(AddPortfolio.routeName)
                //               .then((value) => setState(() {}));
                //         },
                //         child: Text(
                //           "Add items",
                //           style: TextStyle(
                //             color: Colors.green,
                //             fontSize: 20,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //       ),
                //     ),
                //   }
                // else
                //   {
                  //   if(userInfo2.portfolio.isEmpty) 
                  //    Text('data')
                  //   :
                  buildSlider(userInfo2.portfolio),
                  // //},
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
                          icon: Icon(Icons.edit),
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
                //list here which shows skills tags
              ],
            ),
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
                userInfo2.certifications != null
                    ? buildSlider(userInfo2.certifications)
                    : Text(''),
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
