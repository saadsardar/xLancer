import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Freelancer extends ChangeNotifier {
  String userId;
  String location;
  String title;
  String rate;
  String summary;
  List<String> portfolio;
  List<String> skills;
  List<String> certifications;
  List<String> comments;
  String ratings;
  Freelancer({
    this.userId,
    this.location,
    this.title,
    this.rate,
    this.summary,
    this.portfolio,
    this.skills,
    this.comments,
    this.ratings,
  });
  Future<void> edittitle(Map<String, dynamic> userInfo) async {
    try {
      await FirebaseFirestore.instance.collection('freelancers').doc(userId).update(
        {
          'title': userInfo['title'],
        },
      );
      title = userInfo['title'];
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return;
  }
    Future<void> editlocation(Map<String, dynamic> userInfo) async {
    try {
      await FirebaseFirestore.instance.collection('freelancers').doc(userId).update(
        {
          'location': userInfo['location'],
        },
      );
      location = userInfo['location'];
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return;
  }
  Future<void> editrate(Map<String, dynamic> userInfo) async {
    try {
      await FirebaseFirestore.instance.collection('freelancers').doc(userId).update(
        {
          'rate': userInfo['rate'],
        },
      );
      rate = userInfo['rate'];
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return;
  }
    Future<void> editsummary(Map<String, dynamic> userInfo) async {
    try {
      await FirebaseFirestore.instance.collection('freelancers').doc(userId).update(
        {
          'summary': userInfo['summary'],
        },
      );
      summary = userInfo['summary'];
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return;
  }
      Future<void> editportfolio(Map<String, dynamic> userInfo) async {
    try {
      await FirebaseFirestore.instance.collection('freelancers').doc(userId).update(
        {
          'portfolio': userInfo['portfolio'],
        },
      );
      portfolio = userInfo['portfolio'];
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return;
  }
  Future<void> editskills(Map<String, dynamic> userInfo) async {
    try {
      await FirebaseFirestore.instance.collection('freelancers').doc(userId).update(
        {
          'skills': userInfo['skills'],
        },
      );
      skills = userInfo['skills'];
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return;
  }
}