import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:xlancer/Models/projectinfo.dart';
import 'package:xlancer/Models/user.dart';

class Project {
  final String id;
  final String title;
  final String description;
  final String price;
  bool isSaved;
  final String level;
  DateTime deadline;
  final String ownerId;
  DateTime date;

  Project({
    this.id,
    this.title,
    this.description,
    this.price,
    this.isSaved,
    this.level,
    this.deadline,
    this.ownerId,
    this.date,
  });
//  String get getprojectId {
//     return id;
//   }
//    String get getOwnerId {
//     return ownerId;
//   }
  Project.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.title = json['title'],
        this.description = json['description'],
        this.price = json['price'],
        this.isSaved = json['isSaved'],
        this.deadline = json['deadline'].toDate(),
        this.level = (json['level']),
        this.ownerId = json['ownerId'],
        this.date = json['date'].toDate();
}

class Projects with ChangeNotifier {
  List<Project> _projectList = [];
  List<Project> _myprojectList = [];
  //List<Project> _appliedprojectList2 = [];
  Future<List<Project>> getAppliedProjectList(List<String> list) async {
    // _appliedprojectList2 = [];
    // _appliedprojectList2.remove(true);
    _projectList = [];
    _projectList.remove(true);
    // print('Getting projects in which you have applied');
    //for (int i = 0; i < list.length; i++) {
    try {
      final dataSnapshot =
          await FirebaseFirestore.instance.collection('project').get();
      final data = dataSnapshot.docs;
      data.forEach(
        (e) {
          var map = e.data();
          map['id'] = e.id;
          print(map['id']);
          print("Coming here3");
          if (list.contains(map['id'])) {
            print("Coming here");
            print(map['id']);
            _projectList.add(Project.fromJson(map));
          }
        },
      );
    } catch (e) {
      print(e);
      // }
    }
    return [..._projectList];
  }

  Future<void> deleteProject(String id) async {
    try {
      print('Deleting $id');
      await FirebaseFirestore.instance.collection('project').doc(id).delete();
      final dataSnapshot =
          await FirebaseFirestore.instance.collection('projectInfo').get();
      final data = dataSnapshot.docs;
      data.forEach(
        (e) {
          var map = e.data();
          map['id'] = e.id;
          if (id == map['pid']) {
            // l.add(map2['link']);
            FirebaseFirestore.instance
                .collection('projectInfo')
                .doc(map['id'])
                .delete();
          }
        },
      );
      // await FirebaseFirestore.instance
      //     .collection('projectinfo')
      //     .where("pid", isEqualTo: id)
      //     .get()
      //     .delete();
    } catch (e) {
      print(e);
    }
    print('Deleting done');
  }
  // Future<void> savedProject(bool saved, String pid) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('project')
  //         .doc(pid)
  //         .update(
  //       {
  //         'isSaved': saved,
  //       },
  //     );
  //     // isSaved = userInfo['summary'];
  //   } catch (e) {
  //     print(e);
  //   }
  //   notifyListeners();
  //   return;
  // }

  Future<List<Project>> getMyProjectList(User user) async {
    _myprojectList = [];
    _myprojectList.remove(true);
    //print('Getting myprojects');
    try {
      final dataSnapshot =
          await FirebaseFirestore.instance.collection('project').get();
      final data = dataSnapshot.docs;
      data.forEach(
        (e) {
          var map = e.data();
          map['id'] = e.id;
          if (user.userId == map['ownerId']) {
            //print('going to JSON');
            _myprojectList.add(Project.fromJson(map));
            //print('Back from JSON');
          }
        },
      );
    } catch (e) {
      print(e);
    }
    //print(_projectList);
    return [..._myprojectList];
  }
  // Future<List<ProjectsInfo>> getAppliedProjects(Future<List<ProjectInfo>> list) async {
  //   _myprojectList = [];
  //   _myprojectList.remove(true);
  //   print('Getting Appliedprojectslist');
  //   try {
  //     final dataSnapshot =
  //         await FirebaseFirestore.instance.collection('project').get();
  //     final data = dataSnapshot.docs;
  //     data.forEach(
  //       (e) {
  //         var map = e.data();
  //         map['id'] = e.id;
  //         //if (project.appId == map['ownerId']) {
  //           print('going to JSON');
  //           _myprojectList.add(Project.fromJson(map));
  //           print('Back from JSON');
  //         //}
  //       },
  //     );
  //     //     list.forEach((e) {
  //     // print('GetCaseList Func: ${e.id} ${e.price}');
  //  // });
  //   } catch (e) {
  //     print(e);
  //   }
  //   //print(_projectList);
  //   return [..._myprojectList];
  // }

  Future<List<Project>> get getProjectList async {
    _projectList = [];
    _projectList.remove(true);
    //print('Getting projects');
    try {
      final dataSnapshot =
          await FirebaseFirestore.instance.collection('project').get();
      final data = dataSnapshot.docs;
      data.forEach(
        (e) {
          var map = e.data();
          //print('map');
          print(map['level']);
          map['id'] = e.id;
          //print('going to JSON');
          _projectList.add(Project.fromJson(map));
          //print('Back from JSON');
          // print(_projectList);
        },
      );
    } catch (e) {
      print(e);
    }
    // print('done');
    // _projectList.forEach((e) {
    //   print('GetCaseList Func: ${e.id} ${e.price}');
    // });

    //print(_projectList);
    return [..._projectList];
  }
  // String<? get getpid
  //   {return id;}

  // ignore: missing_return
  Future<String> addNewProject(Map<String, dynamic> newProjectDetails) async {
    try {
      var newProject =
          await FirebaseFirestore.instance.collection('project').add({
        'title': newProjectDetails['title'],
        'description': newProjectDetails['description'],
        'deadline': newProjectDetails['deadline'],
        'price': newProjectDetails['price'],
        'ownerId': newProjectDetails['ownerId'],
        'level': newProjectDetails['level'],
        'isSaved': newProjectDetails['isSaved'],
        'date': DateTime.now(),
      });

      _projectList.add(
        Project(
          id: newProject.id,
          title: newProjectDetails['title'],
          description: newProjectDetails['description'],
          price: newProjectDetails['price'],
          deadline: newProjectDetails['deadline'],
          ownerId: newProjectDetails['ownerId'],
          level: newProjectDetails['level'],
          isSaved: newProjectDetails['isSaved'],
          date: DateTime.now(),
        ),
      );

      return newProject.id;
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }

  Future<List<Project>> searchProject(String pattern) async {
    // print('In Case $pattern');
    List<Project> searchedProject = [];
    if (_projectList.isEmpty) {
      await getProjectList;
    }
    _projectList.forEach((e) {
      if (e.title.toLowerCase().contains(pattern) ||
          e.description.toLowerCase().contains(pattern)) {
        searchedProject.add(e);
        // print(e.name);
      }
    });
    return searchedProject;
  }
}
