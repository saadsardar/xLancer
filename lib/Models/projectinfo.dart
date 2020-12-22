import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xlancer/Models/user.dart';

class ProjectInfo {
  final String pid;
  final String ownerId;
  final String appId;
  final bool approve;

  ProjectInfo({
    this.pid,
    this.ownerId,
    this.appId,
    this.approve,
  });
  ProjectInfo.fromJson(Map<String, dynamic> json)
      : this.pid = json['pid'],
        this.ownerId = json['ownerId'],
        this.appId = json['appId'],
        this.approve = json['approve'];
}

class ProjectsInfo with ChangeNotifier {
  //List<ProjectInfo> _myprojectList = [];
  List<String> _appliedprojectList = [];
  List<String> _requestList = [];

  Future<String> applyForProject(Map<String, dynamic> appliedProject) async {
    var msg = '';
    try {
      await FirebaseFirestore.instance.collection('projectInfo').add({
        'pid': appliedProject['pid'],
        'ownerId': appliedProject['ownerId'],
        'appId': appliedProject['appId'],

        // _projectList.add(
        //   ProjectInfo(
        //     pid: appliedProject.['pid'],
        //     ownerId: appliedProject['ownerId'],
        //     appId: appliedProject['appId'],
        //   ),
        // );}
      });
      //return newProject.id;
    } catch (e) {
      print(e);
      msg = e.toString();
    }
    notifyListeners();
    return msg;
  }

  // Future<void> isApprove(String pid, String appid) async {
  //   var id;
  //   try {
  //     final dataSnapshot =
  //         await FirebaseFirestore.instance.collection('projectInfo').get();
  //     final data = dataSnapshot.docs;
  //     data.forEach(
  //       (e) {
  //         var map = e.data();
  //         // print("Pid is $pid  & appid is $appid");
  //         if (appid == map['appId'] && pid == map['pid']) {
  //           map['id'] = e.id;
  //           id = map['id'];
  //         }
  //       },
  //     );
  //     final dataSnapshot2 = await FirebaseFirestore.instance
  //         .collection('projectInfo')
  //         .doc(id)
  //         .get();
  //     final data2 = dataSnapshot2.exists;

  //     //approve = true;
  //   } catch (e) {
  //     print(e);
  //   }
  //   notifyListeners();
  //   return;
  // }

  Future<void> approveRequest(String pid, String appid) async {
    var id;
    try {
      final dataSnapshot =
          await FirebaseFirestore.instance.collection('projectInfo').get();
      final data = dataSnapshot.docs;
      data.forEach(
        (e) {
          var map = e.data();
          // print("Pid is $pid  & appid is $appid");
          if (appid == map['appId'] && pid == map['pid']) {
            map['id'] = e.id;
            id = map['id'];
          }
        },
      );
      print("Salam $id");
      await FirebaseFirestore.instance.collection('projectInfo').doc(id).update(
        {
          'approve': true,
        },
      );
      //approve = true;
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return;
  }

  // Future<List<ProjectInfo>> getMyProjectList(User user) async {
  //   _myprojectList = [];
  //   _myprojectList.remove(true);
  //   print('Getting myprojects');
  //   try {
  //     final dataSnapshot =
  //         await FirebaseFirestore.instance.collection('projectInfo').get();
  //     final data = dataSnapshot.docs;
  //     data.forEach(
  //       (e) {
  //         var map = e.data();
  //         if (user.userId == map['ownerId']) {
  //           print('going to JSON');
  //           _myprojectList.add(ProjectInfo.fromJson(map));
  //           print('Back from JSON');
  //         }
  //       },
  //     );
  //   } catch (e) {
  //     print(e);
  //   }
  //   //print(_projectList);
  //   return [..._myprojectList];
  // }
  Future<List<String>> getAppliedProjectList(User user) async {
    _appliedprojectList = [];
    _appliedprojectList.remove(true);
    print('Inside 1');
    try {
      final dataSnapshot =
          await FirebaseFirestore.instance.collection('projectInfo').get();
      final data = dataSnapshot.docs;
      data.forEach(
        (e) {
          var map = e.data();
          //print('map');
          // print(map['id']);
          //map['id'] = e.id;
          if (user.userId == map['appId']) {
            print('Giving ID');

            _appliedprojectList.add(map['pid']);
            print("ProjectId from info");
            print(map['pid']);
            //pid

            print('Back from JSON22');
          }
          // print(_projectList);
        },
      );
    } catch (e) {
      print(e);
    }
    print('done');
    // _appliedprojectList.forEach((e) {
    //   print('GetCaseList Func: ${e.pid}');
    // });

    //print(_projectList);
    //Projects.getAppliedProjects(_appliedprojectList);
    return [..._appliedprojectList];
  }

  Future<bool> isApplied(projectid, userid) async {
    bool applied = false;
    print('Getting myprojects');
    try {
      final dataSnapshot =
          await FirebaseFirestore.instance.collection('projectInfo').get();
      final data = dataSnapshot.docs;
      data.forEach(
        (e) {
          var map = e.data();
          if (userid == map['appId'] && projectid == map['pid']) {
            applied = true;
          }
        },
      );
    } catch (e) {
      print(e);
    }
    print('User have applied $applied');
    return applied;
  }

  Future<List<String>> getRequests(String pid) async {
    _requestList = [];
    _requestList.remove(true);
    print('Inside 1');
    try {
      final dataSnapshot =
          await FirebaseFirestore.instance.collection('projectInfo').get();
      final data = dataSnapshot.docs;
      data.forEach(
        (e) {
          var map = e.data();
          if (pid == map['pid']) {
            //print('Adding0');
            _requestList.add(map['appId']);
            // print(_appliedprojectList);
          }
        },
      );
    } catch (e) {
      print(e);
    }
    print('done');
    return [..._requestList];
  }
}
