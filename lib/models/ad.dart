import 'package:aimimi/models/user.dart';

class Ad {
  String content;
  String title;
  String category;
  String goalID;
  DateTime createdAt;
  CreatedBy createdBy;

  Ad({
    this.content,
    this.title,
    this.category,
    this.createdAt,
    this.goalID,
    this.createdBy,
  });
}
