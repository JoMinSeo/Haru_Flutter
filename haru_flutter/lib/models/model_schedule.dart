import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule {
  final String title;
  final String content;
  final Timestamp timestamp;
  final String uid;
  final DocumentReference reference;

  Schedule.fromMap(Map<String, dynamic> map, {this.reference})
      : title = map['title'],
        content = map['content'],
        timestamp = map['timestamp'],
        uid = map['uid'];

  Schedule.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Schedule<$title:$content>";
}
