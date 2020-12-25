import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlancer/Models/freelancer.dart';
import 'package:xlancer/Models/project.dart';
import 'package:xlancer/Models/projectinfo.dart';
import 'package:xlancer/ProfileScreens/certficates.dart';
import 'package:xlancer/ProfileScreens/location.dart';
import 'package:xlancer/ProfileScreens/name.dart';
import 'package:xlancer/ProfileScreens/picture.dart';
import 'package:xlancer/ProfileScreens/portfolio.dart';
import 'package:xlancer/ProfileScreens/rate.dart';
import 'package:xlancer/ProfileScreens/summary.dart';
import 'package:xlancer/ProfileScreens/title.dart';
import 'package:xlancer/Screens/Projects/profileItem.dart';
import 'package:xlancer/Screens/Projects/viewProfile.dart';
import 'Models/user.dart';
import 'ProfileScreens/skills.dart';
import 'Screens/Projects/uploadProject.dart';
import 'Screens/Search/searchResult.dart';
import 'Screens/SignUp/register.dart';
import 'Screens/main_screen.dart';
import 'Screens/SignUp/registerGoogle.dart';
import 'Screens/SignUp/registerdetail.dart';
import 'Screens/splashScreen.dart';
// import 'home.dart';

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
        ChangeNotifierProvider<Freelancer>(create: (_) => Freelancer()),
        ChangeNotifierProvider<Projects>(create: (_) => Projects()),
        ChangeNotifierProvider<ProjectsInfo>(create: (_) => ProjectsInfo()),
        //ChangeNotifierProvider<Project>(create: (_) => Project()),
      ],
      child: MaterialApp(
        title: 'X-Lancer',
        debugShowCheckedModeBanner: false,
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
          //Home.routeName: (ctx) => Home(),
          MainScreen.routeName: (ctx) => MainScreen(),
          NavigationScreen.routeName: (ctx) => NavigationScreen(),
          RegisterUserGoogleScreen.routeName: (ctx) =>
              RegisterUserGoogleScreen(),
          EditPicture.routeName: (ctx) => EditPicture(),
          EditTitle.routeName: (ctx) => EditTitle(),
          EditName.routeName: (ctx) => EditName(),
          EditSummary.routeName: (ctx) => EditSummary(),
          EditRate.routeName: (ctx) => EditRate(),
          EditLocation.routeName: (ctx) => EditLocation(),
          AddCertificate.routeName: (ctx) => AddCertificate(),
          AddPortfolio.routeName: (ctx) => AddPortfolio(),
          EditSkills.routeName: (ctx) => EditSkills(),
          NewProjectScreen.routeName: (ctx) => NewProjectScreen(),
          SearchResultScreen.routeName: (ctx) => SearchResultScreen(),
          //ViewProfilePage.routeName: (ctx)=> ViewProfilePage(),
         ProfileItem.routeName:(ctx)=>ProfileItem(),
          //PostJob.routeName:(ctx) => PostJob(),
          //EditSkills.routeName: (ctx) => EditSkills(),
        },
      ),
    );
  }
}
