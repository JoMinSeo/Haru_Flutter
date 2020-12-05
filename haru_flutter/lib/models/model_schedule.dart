import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule {
  final String title;
  final String content;
  final Timestamp alarmTime;
  final Timestamp date;
  final String uid;
  final int category;
  final String token;
  final DocumentReference reference;

  Schedule.fromMap(Map<String, dynamic> map, {this.reference})
      : title = map['title'],
        category = map['category'],
        content = map['content'],
        date = map['date'],
        token = map['token'],
        alarmTime = map['alarmTime'],
        uid = map['uid'];

  Schedule.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Schedule<$title:$content:$alarmTime:$date>";
}
