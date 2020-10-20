import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule {
  final String title;
  final String content;
  final Timestamp time;
  final String uid;
  final int category;
  final DocumentReference reference;

  Schedule.fromMap(Map<String, dynamic> map, {this.reference})
      : title = map['title'],
        category = map['category'],
        content = map['content'],
        time = map['time'],
        uid = map['uid'];

  Schedule.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Schedule<$title:$content:$time>";
}
