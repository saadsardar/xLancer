import 'package:flutter/foundation.dart';

class Project with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  bool isSaved;
  final String level;
  final String deadline;
  final String skills;

  Project({
    this.id,
    this.title,
    this.description,
    this.price,
    this.isSaved,
    this.level,
    this.deadline,
    this.skills,
  });
}
