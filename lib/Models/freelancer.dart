import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:xlancer/Models/user.dart';

class Freelancer extends ChangeNotifier {
  String userId;
  String location;
  String title;
  String rate;
  String summary;
  List<String> portfolio;
  List<String> skills;
  List<String> certifications;
  //List<String> comments;
  String ratings;
  Freelancer({
    this.userId,
    this.location,
    this.title,
    this.rate,
    this.summary,
    this.portfolio,
    this.skills,
    //this.comments,
    this.ratings,
    this.certifications,
  });
  //   Future<List<Freelancer>> getCertificates() async {
  //   certifications = [];
  //   final result = await FirebaseFirestore.instance
  //       .collection('freelancers/$userId/certificates')
  //       .get();
  //   final certificateSnapshot = result.docs;

  //   certificateSnapshot.forEach(
  //     (e) {
  //       var map = e.data();
  //       map['id'] = e.id;
  //       certifications.add(PaymentClass.fromJson(map));
  //     },
  //   );
  //   return certifications;
  // }
  // Future<List<Freelancer>> getPortfolio() async {
  //   portfolio = [];
  //   final result = await FirebaseFirestore.instance
  //       .collection('freelancers/$userId/portfolio')
  //       .get();
  //   final portfolioSnapshot = result.docs;

  //   portfolioSnapshot.forEach(
  //     (e) {
  //       var map = e.data();
  //       map['id'] = e.id;
  //       portfolio.add(PaymentClass.fromJson(map));
  //     },
  //   );
  //   return portfolio;
  // }

  Future<String> setFreelancer(context) async {
    List<String> rand = [];
    List<String> rand2 = [];
    List<String> rand0 = [];
    String errormsg = '';
    // print('Setting Freelancer');
    // portfolio.remove(true);
    // certifications.remove(true);

    // print('User ID Before: $userId');

    userId = Provider.of<User>(context, listen: false).userId;
    try {
      final userSnap = await FirebaseFirestore.instance
          .collection('freelancers')
          .doc(userId)
          .get();
      final userInfo = userSnap.data();
      location = userInfo['location'];
      title = userInfo['title'];
      summary = userInfo['summary'];
      //portfolio = userInfo['portfolio'];
      //skills = ['skills'].toList();
      //userInfo['skills'];
      //comments = userInfo['comments'];
      rate = userInfo['rate'];

final dataSnapshot0 = await FirebaseFirestore.instance
          .collection('freelancers/$userId/skills/')
          .get();
      //print('Fetech $skills');
      final data0 = dataSnapshot0.docs;
      data0.forEach(
        (e) {
          var map0 = e.data();
          //map['id'] = e.id;

          rand0.add(map0['skills']);

          print("rand");
          print(map0['skills']);
        },
      );
      print("Getting links");
     skills = rand0;
      final dataSnapshot = await FirebaseFirestore.instance
          .collection('freelancers/$userId/certicates/')
          .get();
      //print('Fetech $skills');
      final data = dataSnapshot.docs;
      data.forEach(
        (e) {
          var map = e.data();
          //map['id'] = e.id;

          rand.add(map['link']);

          //print(rand);
        },
      );
      // print("Getting links");
      certifications = rand;
      // print("Getting links222");
      final dataSnapshot2 = await FirebaseFirestore.instance
          .collection('freelancers/$userId/portfolio/')
          .get();
      final data2 = dataSnapshot2.docs;
      data2.forEach(
        (e) {
          var map2 = e.data();
          //map['id'] = e.id;
          rand2.add(map2['link']);
          // print("Getting links");
          //print(map2['link']);
        },
      );
      portfolio = rand2;
      // print("free");
      // print(portfolio);
    } catch (e) {
      print(e);
      if (e != null) errormsg = e.toString();
    }
    return errormsg;
  }

  Future<void> edittitle(Map<String, dynamic> userInfo) async {
    try {
      await FirebaseFirestore.instance
          .collection('freelancers')
          .doc(userId)
          .update(
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
      await FirebaseFirestore.instance
          .collection('freelancers')
          .doc(userId)
          .update(
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
      await FirebaseFirestore.instance
          .collection('freelancers')
          .doc(userId)
          .update(
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
      await FirebaseFirestore.instance
          .collection('freelancers')
          .doc(userId)
          .update(
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

  // Future<void> editskills(Map<String, dynamic> userInfo) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('freelancers')
  //         .doc(userId)
  //         .update(
  //       {
  //         'skills': userInfo['tags'],
  //       },
  //     );
  //     skills = userInfo['tags'];
  //   } catch (e) {
  //     print(e);
  //   }
  //   notifyListeners();
  //   return;
  // }

  // Future<void> editportfolio(Map<String, dynamic> userInfo) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('freelancers/$userId/portfolio/')
  //         .add(
  //       {
  //         'portfolio': userInfo['portfolio'],
  //       },
  //     );
  //     portfolio = userInfo['portfolio'];
  //   } catch (e) {
  //     print(e);
  //   }
  //   notifyListeners();
  //   return;
  // }

  // Future<void> editskills(Map<String, dynamic> userInfo) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('freelancers')
  //         .doc(userId)
  //         .update(
  //       {
  //         'skills': userInfo['skills'],
  //       },
  //     );
  //     skills = userInfo['skills'];
  //   } catch (e) {
  //     print(e);
  //   }
  //   notifyListeners();
  //   return;
  // }
  Future<void> addcertificate(Map<String, dynamic> userInfo) async {
    try {
      await FirebaseFirestore.instance
          .collection('freelancers/$userId/certicates/')
          .add(
        {
          'link': userInfo['link'],
        },
      );
      certifications.add(userInfo['link']);
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return;
  }
    Future<void> addSkills(Map<String, dynamic> userInfo) async {
    try {
      await FirebaseFirestore.instance
          .collection('freelancers/$userId/skills/')
          .add(
        {
          'skills': userInfo['tag'],
        },
      );
      skills.add(userInfo['skills']);
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return;
  }
  Future<void> delelteSkill(String link) async {
    try {
      final dataSnapshot = await FirebaseFirestore.instance
          .collection('freelancers/$userId/skills/')
          .get();
      final data = dataSnapshot.docs;
      data.forEach(
        (e) {
          var map = e.data();
          map['id'] = e.id;
          if (link == map['skills']) {
            // l.add(map2['link']);
            FirebaseFirestore.instance
                .collection('freelancers/$userId/skills/')
                .doc(map['id'])
                .delete();
          }
        },
      );
      print('Deleting $link');
    } catch (e) {
      print(e);
    }
    print('Deleting skill done');
  }

  Future<void> deleltePortfolio(String link) async {
    try {
      final dataSnapshot = await FirebaseFirestore.instance
          .collection('freelancers/$userId/portfolio/')
          .get();
      final data = dataSnapshot.docs;
      data.forEach(
        (e) {
          var map = e.data();
          map['id'] = e.id;
          if (link == map['link']) {
            // l.add(map2['link']);
            FirebaseFirestore.instance
                .collection('freelancers/$userId/portfolio/')
                .doc(map['id'])
                .delete();
          }
        },
      );
      final dataSnapshot2 = await FirebaseFirestore.instance
          .collection('freelancers/$userId/certicates/')
          .get();
      final data2 = dataSnapshot2.docs;
      data2.forEach(
        (e) {
          var map2 = e.data();
          map2['id'] = e.id;
          if (link == map2['link']) {
            // l.add(map2['link']);
            FirebaseFirestore.instance
                .collection('freelancers/$userId/certicates/')
                .doc(map2['id'])
                .delete();
          }
        },
      );

      print('Deleting $link');
    } catch (e) {
      print(e);
    }
    print('Deleting done');
  }

  Future<void> addportfolio(Map<String, dynamic> userInfo) async {
    try {
      await FirebaseFirestore.instance
          .collection('freelancers/$userId/portfolio/')
          .add(
        {
          'link': userInfo['link'],
        },
      );
      portfolio.add(userInfo['link']);
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return;
  }
}
