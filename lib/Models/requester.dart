// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class Requester extends ChangeNotifier {
//   String userId;
//   String name;
//   String picture;
//   String location;
//   String title;
//   String rate;
//   String summary;
//   List<String> portfolio;
//   List<String> skills;
//   List<String> certifications;
//   //List<String> comments;
//   String ratings;
//   Requester({
//     this.userId,
//     this.name,
//     this.location,
//     this.title,
//     this.rate,
//     this.summary,
//     this.portfolio,
//     this.skills,
//     //this.comments,
//     this.ratings,
//     this.certifications,
//   });

//   Future<List<String>> getRequestedUsers(List<String> userslist) async {
//     String errormsg = '';
//     List<String> rand0 = [];
//     try {
//       final dataSnapshot =
//           await FirebaseFirestore.instance.collection('users').get();
//       final data = dataSnapshot.docs;
//       data.forEach(
//         (e) {
//           var map = e.data();
//           map['id'] = e.id;
//           if (userslist.contains(map['id'])) {
//             rand0.add(map['appId']['pid']);
//           }
//         },
//       );
//     } catch (e) {
//       print(e);
//       if (e != null) errormsg = e.toString();
//     }
//     return rand0;
//   }
// }
