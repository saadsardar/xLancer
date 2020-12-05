import 'package:xlancer/Models/user.dart' as UserClass;
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'main_screen.dart';
import 'register.dart';
//import 'package:services_shanapp/Widgets/bottom2.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/splashScreen';
  @override
  Widget build(BuildContext context) {
    // Future<void> wait5Sec() async {
    //   await Future.delayed(const Duration(seconds: 3));
    //   return;
    // }

    // return FutureBuilder(
    //     future: wait5Sec(),
    //     builder: (ctx, snap) {
    //       if (snap.connectionState == ConnectionState.waiting) {
    //         return Scaffold(
    //           backgroundColor: Colors.white,
    //           body: Column(
    //             children: [
    //               SizedBox(
    //                 height: MediaQuery.of(context).size.height * 0.2,
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.only(top: 8),
    //                 child: Container(
    //                   width: MediaQuery.of(context).size.width,
    //                   child: Image.asset(
    //                     'assets/Logo.jpg',
    //                     height: 200,
    //                     width: 200,
    //                     //scale: 0.3,
    //                   //color: Colors.red,
    //                     fit: BoxFit.contain,
    //                   ),
    //                 ),
    //               ),
    //               Expanded(
    //                 child: Container(),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.symmetric(vertical: 2.0),
    //                 child: Text(
    //                   'Developed By',
    //                   style: TextStyle(
    //                     color: Colors.black,
    //                     fontSize: 15,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.only(bottom: 20),
    //                 child: Text(
    //                   'SYK Pvt. Ltd.',
    //                   style: TextStyle(
    //                     color: Colors.black,
    //                     fontSize: 15,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         );
    //       } else {
            return NavigationScreen();
         // }
       // });
  }
}
class NavigationScreen extends StatelessWidget {
  static const routeName = '/navigation-screen';
  @override
  Widget build(BuildContext context) {
    final isLoggedIn =
        Provider.of<UserClass.User>(context, listen: false).loggedIn;
    print('Is Logged In:  $isLoggedIn');
    return Provider.of<UserClass.User>(context, listen: false).loggedIn
        ? MainScreen()
        : RegisterPageUser();
  }
}