import 'package:aimimi/models/user.dart';

class Feed {
  String content;
  DateTime createdAt;
  String goalID;
  CreatedBy createdBy;
  bool liked;
  List likes;
  List comments;
  Feed(
      {this.content,
      this.createdAt,
      this.goalID,
      this.createdBy,
      this.liked,
      this.likes,
      this.comments});
}
