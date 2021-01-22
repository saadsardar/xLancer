import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:xlancer/Models/user.dart';

class Freelancer extends ChangeNotifier {
  String userId;
  String name;
  String picture;
  String location;
  String title;
  String rate;
  String phoneNumber;
  String summary;
  List<String> portfolio;
  List<String> skills;
  List<String> certifications;

  //List<String> comments;
  String ratings;
  Freelancer({
    this.userId,
    this.name,
    this.picture,
    this.location,
    this.title,
    this.rate,
    this.summary,
    this.portfolio,
    this.skills,
    this.phoneNumber,
    //this.comments,
    this.ratings,
    this.certifications,
  });
  Freelancer.fromJson(Map<String, dynamic> json)
      : this.userId = json['id'],
        this.name = json['name'],
        this.picture = json['picture'],
        this.location = json['location'],
        this.title = json['title'],
        this.phoneNumber = json['phoneNumber'],
        this.rate = json['rate'],
        this.summary = json['summary'],
        //this.portfolio = json['portfolio'],
        //this.skills = json['skills'],
        this.ratings = json['summary'];
  //this.certifications = json['certifications'];
// }
// class Freelancers extends ChangeNotifier{
  Future<String> setFreelancer(String user) async {
    List<String> rand = [];
    List<String> rand2 = [];
    List<String> rand0 = [];
    String errormsg = '';
    // print('Setting Freelancer');
    // portfolio.remove(true);
    // certifications.remove(true);

    print('User ID Before: $user');

    //userId = Provider.of<User>(context, listen: false).userId;
    try {
      final userSnap = await FirebaseFirestore.instance
          .collection('freelancers')
          .doc(user)
          .get();
      // print('name is name');

      final userInfo = userSnap.data();
      // print(' userid of saad $user');
      // //name = userInfo['name'];
      // print('name is name');
      //print(' userid of saad $user');
      picture = userInfo['picture'];
      //print(' userid of saad $user');
      phoneNumber = userInfo['phoneNumber'];
      location = userInfo['location'];
      title = userInfo['title'];
      summary = userInfo['summary'];
      //portfolio = userInfo['portfolio'];
      //skills = ['skills'].toList();
      //userInfo['skills'];
      //comments = userInfo['comments'];
      rate = userInfo['rate'];
      print(' userid of saad $user');
//print('name is name');
      final dataSnapshot0 = await FirebaseFirestore.instance
          .collection('freelancers/$user/skills/')
          .get();
      //print('Fetech $skills');
      print('Khan saab');
      final data0 = dataSnapshot0.docs;
      data0.forEach(
        (e) {
          var map0 = e.data();
          //map['id'] = e.id;

          rand0.add(map0['skills']);

          print("rand");
          print('Khan saab2');
          print(map0['skills']);
        },
      );
      print("Getting links");
      skills = rand0;
      final dataSnapshot = await FirebaseFirestore.instance
          .collection('freelancers/$user/certicates/')
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
          .collection('freelancers/$user/portfolio/')
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

  Future<List<String>> setUserPortfolio(String userId) async {
    List<String> p = [];
    final dataSnapshot2 = await FirebaseFirestore.instance
        .collection('freelancers/$userId/portfolio/')
        .get();
    final data2 = dataSnapshot2.docs;
    data2.forEach(
      (e) {
        var map2 = e.data();
        //map['id'] = e.id;
        p.add(map2['link']);
        // print("Getting links");
        //print(map2['link']);
      },
    );
    return p;
  }

  Future<List<String>> setUserCertificate(String userId) async {
    List<String> c = [];
    final dataSnapshot0 = await FirebaseFirestore.instance
        .collection('freelancers/$userId/certicates/')
        .get();
    final data0 = dataSnapshot0.docs;
    data0.forEach(
      (e) {
        var map0 = e.data();
        //map['id'] = e.id;
        c.add(map0['link']);
        // print("Getting links");
        //print(map2['link']);
      },
    );
    return c;
  }

  Future<List<String>> setUserSkills(String userId) async {
    List<String> s = [];
    final dataSnapshot1 = await FirebaseFirestore.instance
        .collection('freelancers/$userId/skills/')
        .get();
    final data1 = dataSnapshot1.docs;
    data1.forEach(
      (e) {
        var map1 = e.data();
        //map['id'] = e.id;
        s.add(map1['skills']);
        // print("Getting links");
        //print(map2['link']);
      },
    );
    return s;
  }

  Future<void> edittitle(String userID, Map<String, dynamic> userInfo) async {
    try {
      print('User id is $userId');
      await FirebaseFirestore.instance
          .collection('freelancers')
          .doc(userID)
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

  Future<void> editlocation(
      String userID, Map<String, dynamic> userInfo) async {
    try {
      await FirebaseFirestore.instance
          .collection('freelancers')
          .doc(userID)
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

  Future<void> editrate(String userID, Map<String, dynamic> userInfo) async {
    try {
      await FirebaseFirestore.instance
          .collection('freelancers')
          .doc(userID)
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

  Future<void> editsummary(String userID, Map<String, dynamic> userInfo) async {
    try {
      await FirebaseFirestore.instance
          .collection('freelancers')
          .doc(userID)
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
  Future<void> addcertificate(
      String userID, Map<String, dynamic> userInfo) async {
    try {
      print('Adding');
      await FirebaseFirestore.instance
          .collection('freelancers/$userID/certicates/')
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

  List<String> getSkills() {
    return skills;
  }

  Future<void> addSkills(String userID, Map<String, dynamic> userInfo) async {
    try {
      await FirebaseFirestore.instance
          .collection('freelancers/$userID/skills/')
          .add(
        {
          'skills': userInfo['tag'],
        },
      );
      skills.add(userInfo['tag']);
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return;
  }

  Future<void> delelteSkill(String userID, String link) async {
    try {
      final dataSnapshot = await FirebaseFirestore.instance
          .collection('freelancers/$userID/skills/')
          .get();
      final data = dataSnapshot.docs;
      data.forEach(
        (e) {
          var map = e.data();
          map['id'] = e.id;
          if (link == map['skills']) {
            // l.add(map2['link']);
            FirebaseFirestore.instance
                .collection('freelancers/$userID/skills/')
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
    notifyListeners();
  }

  Future<void> deleltePortfolio(String userID, String link) async {
    try {
      final dataSnapshot = await FirebaseFirestore.instance
          .collection('freelancers/$userID/portfolio/')
          .get();
      final data = dataSnapshot.docs;
      data.forEach(
        (e) {
          var map = e.data();
          map['id'] = e.id;
          if (link == map['link']) {
            // l.add(map2['link']);
            FirebaseFirestore.instance
                .collection('freelancers/$userID/portfolio/')
                .doc(map['id'])
                .delete();
          }
        },
      );
      final dataSnapshot2 = await FirebaseFirestore.instance
          .collection('freelancers/$userID/certicates/')
          .get();
      final data2 = dataSnapshot2.docs;
      data2.forEach(
        (e) {
          var map2 = e.data();
          map2['id'] = e.id;
          if (link == map2['link']) {
            // l.add(map2['link']);
            FirebaseFirestore.instance
                .collection('freelancers/$userID/certicates/')
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

  Future<void> addportfolio(
      String userID, Map<String, dynamic> userInfo) async {
    try {
      await FirebaseFirestore.instance
          .collection('freelancers/$userID/portfolio/')
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

  Future<List<Freelancer>> getRequestedUsers(List<String> userslist) async {
    String errormsg = '';
    List<Freelancer> rand0 = [];

    rand0 = [];
    rand0.remove(true);

    //List<String> rand1 = [];
    try {
      final dataSnapshot =
          await FirebaseFirestore.instance.collection('freelancers').get();
      final data = dataSnapshot.docs;
      data.forEach(
        (e) {
          var map = e.data();
          map['id'] = e.id;
          if (userslist.contains(map['id'])) {
            print("maps ${map['id']}");
            rand0.add(Freelancer.fromJson(map));
            print("maps}");
          }
        },
      );
    } catch (e) {
      print(e);
      if (e != null) errormsg = e.toString();
    }
    return rand0;
  }
}
