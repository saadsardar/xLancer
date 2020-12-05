import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Models/user.dart';
import 'Screens/main_screen.dart';
import 'Screens/register.dart';
import 'Screens/registerGoogle.dart';
import 'Screens/registerdetail.dart';
import 'Screens/splashScreen.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseFirestore.instance.settings = Settings();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<User>(create: (_) => User()),
        //ChangeNotifierProvider<Project>(create: (_) => Project()),
      ],
      child: MaterialApp(
        title: 'X-Lancer',
        theme: ThemeData(
          //primarySwatch: Colors.lightBlue,
          primaryColor: Color(0xff4fab4a),
          //accentColor: Colors.green,
          accentColor: Color(0xff73bb44),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
        //SplashScreen(),
        routes: {
          RegisterPageUser.routeName: (ctx) => RegisterPageUser(),
          RegisterUserDetailScreen.routeName: (ctx) =>
              RegisterUserDetailScreen(),
          Home.routeName: (ctx) => Home(),
          MainScreen.routeName: (ctx) => MainScreen(),
          NavigationScreen.routeName: (ctx) => NavigationScreen(),
          RegisterUserGoogleScreen.routeName: (ctx) =>
              RegisterUserGoogleScreen(),
        },
      ),
    );
  }
}
