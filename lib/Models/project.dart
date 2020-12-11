import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Project with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  bool isSaved;
  final String level;
  final String deadline;
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
  Project.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.title = json['title'],
        this.description = json['description'],
        this.price = json['price'],
        this.isSaved = json['isSaved'],
        this.deadline = json['deadline'].toDate(),
        this.level = (json['level']).toDouble(),
        this.ownerId = json['ownerId'].toDouble(),
        this.date = json['date'].toDate();

  List<Project> _projectList = [];

  // int get casesCount {
  //   return _projectList.length;
  // }

  Future<List<Project>> get getProjectList async {
    _projectList = [];
    _projectList.remove(true);
    print('Getting projects');
    try {
      final dataSnapshot =
          await FirebaseFirestore.instance.collection('project').get();
      final data = dataSnapshot.docs;
      data.forEach(
        (e) {
          var map = e.data();
          map['id'] = e.id;
          _projectList.add(Project.fromJson(map));
        },
      );
    } catch (e) {
      print(e);
    }
    print('done');
    // _casesList.forEach((e) {
    //   print('GetCaseList Func: ${e.name} ${e.organizationID}');
    // });
    return [..._projectList];
  }

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
