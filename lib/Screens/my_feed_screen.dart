import 'package:flutter/material.dart';
import 'package:xlancer/Models/project.dart';
import 'package:xlancer/Screens/project_item.dart';

class MyFeedScreen extends StatelessWidget {
  List<Project> loadedProjects = [
    Project(
        id: 'p1',
        title: 'CARPOOL APP ',
        description: 'an app for carpool',
        price: 100.0,
        level: 'intermediate level',
        deadline: 'closes in 1 week',
        skills:
            'PHp, Java, JavaScript, Software Architecture, Software testing'),
    Project(
        id: 'p2',
        title: 'KIDS APP ',
        description: 'an app for kids',
        price: 80.0,
        level: 'entry level',
        deadline: 'closes in 3 week',
        skills:
            'PHp, Java, JavaScript, Software Architecture, Software testing'),
    Project(
        id: 'p3',
        title: 'HOME DECOR APP',
        description: 'an app for home decoration an app for home decoration an app for home decoration an app for home decoration ',
        price: 120.0,
        level: 'intermediate level',
        deadline: 'closes in 2 week',
        skills:
            'PHp, Java, JavaScript, Software Architecture, Software testing'),
    Project(
        id: 'p4',
        title: 'SCHOOL MANAGEMENT WEBSITE',
        description: 'a website for school management',
        price: 100.0,
        level: 'entry level',
        deadline: 'closes in 1 month',
        skills:
            'PHp, Java, JavaScript, Software Architecture, Software testing'),
    Project(
        id: 'p5',
        title: 'GRAPHIC DESIGNING',
        description: 'logo designing',
        price: 150.0,
        level: 'entry level',
        deadline: 'closes in 5 week',
        skills:
            'PHp, Java, JavaScript, Software Architecture, Software testing'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (ctx, i) => ProjectItem(
          loadedProjects[i].id,
          loadedProjects[i].title,
          loadedProjects[i].price,
          loadedProjects[i].level,
          loadedProjects[i].deadline,
          loadedProjects[i].description,
          loadedProjects[i].skills,
        ),

        padding: const EdgeInsets.all(10),
        itemCount: loadedProjects.length,
      ),
    );
  }
}
