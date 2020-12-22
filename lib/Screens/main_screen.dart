// import 'package:async/async.dart';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:xlancer/Models/freelancer.dart';
import 'package:xlancer/Models/project.dart';
import 'package:xlancer/Models/user.dart';
import 'package:xlancer/Screens/jobs_screen.dart';
import 'package:xlancer/Screens/profile.dart';

import 'Projects/manageprojects.dart';
import 'Projects/uploadProject.dart';
import 'drawer.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main-page';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  PageController _pageController;
  // final AsyncMemoizer _memoizer = AsyncMemoizer();
  bool init = false;
  int _currentIndex;

  @override
  void didChangeDependencies() {
    if (init == false) {
      _currentIndex = 0;
      init = true;
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
    // initialize = false;
    // setUserLocal().then((value) => print('Init State Done'));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> setUserLocal(
      User user, Freelancer freelancer, Projects project) async {
    var msg = '';
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // print('connected');
      }
    } on SocketException catch (_) {
      // print('not connected');
      msg = 'internet';
    }
    try {
      await user.setUser();
      await freelancer.setFreelancer(user);
      //print("freelancer.certifications");
      //print(freelancer.certifications);
    } catch (e) {
      msg = e.toString();
    }
    return msg;
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context, listen: false);
    var freelancer = Provider.of<Freelancer>(context, listen: false);
    var project = Provider.of<Projects>(context, listen: false);
    Widget tryAgainScreen(String msg) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              msg,
              textAlign: TextAlign.center,
              maxLines: 3,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          RaisedButton(
              child: Container(
                child: Text(
                  'Try Again',
                ),
              ),
              onPressed: () {
                setState(() {});
              })
        ],
      );
    }

    return FutureBuilder(
      future: setUserLocal(user, freelancer, project),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          // return Scaffold(
          //   backgroundColor: Theme.of(context).primaryColor,
          //   body: Column(
          //     children: [
          //       SizedBox(
          //         height: MediaQuery.of(context).size.height * 0.2,
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.only(top: 8),
          //         child: Container(
          //           width: MediaQuery.of(context).size.width,
          //           child: Image.asset(
          //             'assets/Logo.png',
          //             fit: BoxFit.contain,
          //           ),
          //         ),
          //       ),
          //       Container(
          //         child: CircularProgressIndicator(),
          //       ),
          //     ],
          //   ),
          // );
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Scaffold(
            key: _scaffoldKey,
            // appBar: AppBar(
            //   backgroundColor: Colors.transparent,
            //   shadowColor: Colors.transparent,
            //   iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            //   actions: [
            //     if (user.isOrganization)
            //       IconButton(
            //           icon: Icon(Icons.message),
            //           onPressed: () {
            //             Navigator.of(context)
            //                 .pushNamed(OrganizationMessagesScreen.routeName);
            //           })
            //   ],
            // ),
            drawer: AppDrawer(),
            body: FutureBuilder(
              future: setUserLocal(user, freelancer, project),
              builder: (ctx, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final msg = snap.data;
                  // var r = freelancer.portfolio[0];
                  // print('Rate is $r');
                  // print(freelancer.location);
                  // print(freelancer.summary);
                  // print(freelancer.title);
                  if (msg != '') {
                    String errormsg = '';
                    if (msg == 'internet')
                      errormsg =
                          'No Internet Connection. Please Check Your Internet Connection & Try Again';
                    else {
                      errormsg = msg;
                    }
                    return tryAgainScreen(errormsg);
                  } else {
                    return SizedBox.expand(
                      child: IndexedStack(
                        index: _currentIndex,
                        children: <Widget>[
                          JobScreen(),
                          ManageProjectScreen(),
                          NewProjectScreen(),
                          ProfilePage(),
                        ],
                      ),
                    );
                  }
                }
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              iconSize: 30,
              selectedItemColor: Theme.of(context).accentColor,
              unselectedItemColor: Theme.of(context).primaryColor,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(label: 'Jobs', icon: Icon(Icons.home)),
                // BottomNavigationBarItem(
                //     label: 'Explore', icon: Icon(Icons.search)),
                // // if (user.isOrganization)
                // BottomNavigationBarItem(label: 'Add', icon: Icon(Icons.add)),
                BottomNavigationBarItem(
                    label: 'Manage', icon: Icon(Icons.work)),
                BottomNavigationBarItem(
                  label: 'Add Project',
                  icon: Icon(Icons.add),
                ),
                BottomNavigationBarItem(
                    label: 'Profile', icon: Icon(Icons.person)),
              ],
            ),
            // }
            //     },
            //   ),
          );
        }
      },
    );
  }
}
