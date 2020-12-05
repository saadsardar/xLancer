import 'package:flutter/foundation.dart';

class Project {
  final String id;
  final String title;
  final String description;
  final double price;
  final String level;
  final String deadline;
  final String skills;
  bool isSaved;

  Project(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.level,
      @required this.deadline,
      @required this.skills,
      this.isSaved});
}
