import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlancer/Models/user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:xlancer/ProfileScreens/picture.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<User>(context, listen: false);
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
                      ? Icon(Icons.person)
                      : NetworkImage(
                          userInfo.picture,
                        ),
                ),
                IconButton(
                  color: Theme.of(context).accentColor,
                  icon: Icon(Icons.edit),
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
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              color: Theme.of(context).accentColor,
                              icon: Icon(Icons.edit),
                              onPressed: () {},
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
                            child: Text(
                              'Karachi, Pakistan',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            color: Theme.of(context).accentColor,
                            icon: Icon(Icons.edit),
                            onPressed: () {},
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
                      Text(
                        'Flutter Developer',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        color: Theme.of(context).accentColor,
                        icon: Icon(Icons.edit),
                        onPressed: () {},
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
                      Text(
                        '9.00/hr',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                        child: IconButton(
                          color: Theme.of(context).accentColor,
                          icon: Icon(Icons.edit),
                          onPressed: () {},
                        ),
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
                        child: Text(
                          'dsvbihabicbajcoaocadocbadobcoadbuoabcoa',
                          style: TextStyle(
                            fontSize: 15,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                        child: IconButton(
                          color: Theme.of(context).accentColor,
                          icon: Icon(Icons.edit),
                          onPressed: () {},
                        ),
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
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  'assets/portfolio.jpeg',
                  height: 150,
                  width: 150,
                ),
                Center(
                  child: Text(
                    "Showcase your work to impress clients",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "Add items",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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
                          onPressed: () {},
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
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
