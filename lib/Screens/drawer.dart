import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlancer/Models/user.dart';
import 'package:xlancer/Screens/splashScreen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                //user.name,
                'Kazim Ali',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              accountEmail: Text(
                //user.email,
                'kazim@gmail.com',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              currentAccountPicture: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  backgroundImage:
                      //user.picture == ''
                      //? AssetImage('assets/userIcon.png')
                      //:
                      NetworkImage(
                          'https://scontent.fkhi1-1.fna.fbcdn.net/v/t1.0-9/100710758_3248559528501885_7339629351110967296_o.jpg?_nc_cat=109&ccb=2&_nc_sid=09cbfe&_nc_eui2=AeHqx3HmEwph4a7B3zS6exaufXwA9OioYYJ9fAD06KhhgqwWwq3U-GtqjSJ9MDHNB4xXRw99kXnM_7m7qNZp-w64&_nc_ohc=c5q2fZ7dn_AAX9C-y4u&_nc_ht=scontent.fkhi1-1.fna&oh=2c2ac396fdbadf5f856fd07d7ea3d577&oe=5FEE557C'),
                  // ? 'https://cdn4.vectorstock.com/i/1000x1000/23/18/male-avatar-icon-flat-vector-19152318.jpg'
                  // child: ClipOval(
                  //   child: Image.network(
                  //     user.picture,
                  //     // "https://cdn4.vectorstock.com/i/1000x1000/23/18/male-avatar-icon-flat-vector-19152318.jpg",
                  //   ),
                  // ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                size: 30,
                color: Colors.black,
              ),
              title: Text(
                'Home',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              onTap: () {
                // Navigator.of(context)
                //     .pushReplacementNamed(MainScreen.routeName);
                print('object');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.help,
                size: 30,
                color: Colors.black,
              ),
              title: Text(
                'Help',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.description,
                size: 30,
                color: Colors.black,
              ),
              title: Text(
                'Terms & Conditions',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.star,
                size: 30,
                color: Colors.black,
              ),
              title: Text(
                'Rate our App',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              onTap: () {},
            ),
            // ListTile(
            //   leading: Icon(
            //     Icons.business_center,
            //     size: 30,
            //     color: Colors.black,
            //   ),
            //   title: Text(
            //     'Closed Cases & Campaigns',
            //     style: TextStyle(color: Colors.black, fontSize: 20),
            //   ),
            //   onTap: () async {
            //     // Navigator.of(context).pushNamed(ClosedScreen.routeName);
            //     print('object');
            //   },
            // ),
            // //if (user.isOrganization)
            //   ListTile(
            //     leading: Icon(
            //       Icons.business_center,
            //       size: 30,
            //       color: Colors.black,
            //     ),
            //     title: Text(
            //       'My Organization',
            //       style: TextStyle(color: Colors.black, fontSize: 20),
            //     ),
            //     onTap: () async {
            //       // Navigator.of(context)
            //       //     .pushNamed(FetchOrg.routeName, arguments: user);
            //       print('object');
            //     },
            //   ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                size: 30,
                color: Colors.black,
              ),
              title: Text(
                'Sign out',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              onTap: () async {
                await Provider.of<User>(context, listen: false).signOut();
                Navigator.of(context)
                    .pushReplacementNamed(NavigationScreen.routeName);
                // Navigator.popUntil(
                //     context, ModalRoute.withName(Navigator.defaultRouteName));
                // FirebaseLogics.signOut();
              },
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                size: 30,
                color: Colors.black,
              ),
              title: Text(
                'Test Payment',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              onTap: () async {
                // await Provider.of<User>(context, listen: false).signOut();
               // Navigator.of(context).pushNamed(TestPayment.routeName);
               print('object');
                // await Provider.of<Campaigns>(context, listen: false)
                //     .insertDemoCampaignsInFirebase();
              },
            ),
          ],
        ),
      ),
    );
  }
}
