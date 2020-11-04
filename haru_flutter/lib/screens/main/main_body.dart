import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:haru_flutter/constants/constants.dart';
import 'package:haru_flutter/models/model_schedule.dart';
import 'package:haru_flutter/providers/date_provider.dart';
import 'package:haru_flutter/providers/selecdate_provider.dart';
import 'package:haru_flutter/services/sizes/Sizeconfig.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

class MainBody extends StatefulWidget {
  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  DatePickerController _controller = DatePickerController();

  FirebaseFirestore firebaseStore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> streamData;

  SelectDateProvider selectDateProvider;

  Widget _fetchData(BuildContext context) {
    // 1603357200000
    Timestamp timestamp = Timestamp.fromDate(selectDateProvider.selectedValue);
    print(timestamp);
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('schedule')
          .where('date', isEqualTo: timestamp)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return _buildList(context, snapshot.data.docs);
        }
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<Schedule> schedule =
        snapshot.map((d) => Schedule.fromSnapshot(d)).toList();
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: (getProportionateScreenHeight(10)));
        },
        shrinkWrap: true,
        itemCount: schedule.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return bigListItem(context, snapshot[index], index);
          } else if (index == 1) {
            return bigListItem(context, snapshot[index], index);
          } else {
            return smallListItem(context, snapshot[index], index);
          }
        },
      ),
    );
  }

  Widget bigListItem(BuildContext context, DocumentSnapshot data, int index) {
    final schedule = Schedule.fromSnapshot(data);
    DateTime dateTime = schedule.alarmTime.toDate();
    String resultDate = DateFormat.jm().add_jm().format(dateTime);
    return InkWell(
      child: Container(
          height: getProportionateScreenHeight(120),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: schedule.category == 0
                ? kPink
                : schedule.category == 1 ? kPurple : kYellow,
            boxShadow: [
              BoxShadow(
                color: Color(0x10000000),
                offset: Offset(0, 0),
                blurRadius: 6,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenHeight(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      schedule.title,
                      style: kMedium.copyWith(color: kWhite, fontSize: 20),
                    ),
                    Text(
                      schedule.content,
                      style: kMedium.copyWith(color: kWhite, fontSize: 12),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(6),
                    ),
                    Container(
                      height: getProportionateScreenHeight(32),
                      width: getProportionateScreenWidth(60),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: kWhite,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(5),
                            vertical: getProportionateScreenHeight(4)),
                        child: Text(
                          resultDate,
                          textAlign: TextAlign.center,
                          style: kMedium.copyWith(
                              color: schedule.category == 0
                                  ? kPink
                                  : schedule.category == 1 ? kPurple : kYellow,
                              fontSize: 12),
                        ),
                      ),
                    )
                  ],
                ),
                IconButton(
                  onPressed: () {
                    deleteData(index);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: kWhite,
                  ),
                )
              ],
            ),
          )),
    );
  }

  @override
  void initState() {
    super.initState();
    firebaseCloudMessagingListeners();
  }

  Widget smallListItem(BuildContext context, DocumentSnapshot data, int index) {
    final schedule = Schedule.fromSnapshot(data);
    return InkWell(
      child: Container(
        height: getProportionateScreenHeight(56),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: schedule.category == 0
              ? kPink
              : schedule.category == 1 ? kPurple : kYellow,
          boxShadow: [
            BoxShadow(
              color: Color(0x10000000),
              offset: Offset(0, 0),
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(10),
                  horizontal: getProportionateScreenWidth(20)),
              child: Text(
                schedule.title,
                style: kMedium.copyWith(color: kWhite, fontSize: 20),
              ),
            ),
            Padding(
                padding:
                    EdgeInsets.only(right: getProportionateScreenWidth(20)),
                child: IconButton(
                  onPressed: () {
                    deleteData(index);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: kWhite,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  getCurrentDate(BuildContext context) {
    var date = new DateTime.now().toString();
    var dateParse = DateTime.parse(date);

    switch (dateParse.month) {
      case 1:
        Provider.of<DateProvider>(context, listen: false).finalMonth =
            "January";
        break;
      case 2:
        Provider.of<DateProvider>(context, listen: false).finalMonth =
            "February";
        break;
      case 3:
        Provider.of<DateProvider>(context, listen: false).finalMonth = "March";
        break;
      case 4:
        Provider.of<DateProvider>(context, listen: false).finalMonth = "April";
        break;
      case 5:
        Provider.of<DateProvider>(context, listen: false).finalMonth = "May";
        break;
      case 6:
        Provider.of<DateProvider>(context, listen: false).finalMonth = "June";
        break;
      case 7:
        Provider.of<DateProvider>(context, listen: false).finalMonth = "July";
        break;
      case 8:
        Provider.of<DateProvider>(context, listen: false).finalMonth = "August";
        break;
      case 9:
        Provider.of<DateProvider>(context, listen: false).finalMonth =
            "September";
        break;
      case 10:
        Provider.of<DateProvider>(context, listen: false).finalMonth =
            "October";
        break;
      case 11:
        Provider.of<DateProvider>(context, listen: false).finalMonth =
            "November";
        break;
      case 12:
        Provider.of<DateProvider>(context, listen: false).finalMonth =
            "December";
        break;
      default:
        print("이상한데 씨발");
        break;
    }
  }

  deleteData(int idx) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('schedule');
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[idx].reference.delete();
  }

  void firebaseCloudMessagingListeners() {
    // if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token) {
      print('token:' + token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
        // showDialog(
        //   context: context,
        //   builder: (context) => AlertDialog(
        //     content: ListTile(
        //       title: Text(message['notification']['title']),
        //       subtitle: Text(message['notification']['body']),
        //     ),
        //     actions: <Widget>[
        //       FlatButton(
        //         child: Text('Ok'),
        //         onPressed: () => Navigator.of(context).pop(),
        //       ),
        //     ],
        //   ),
        // );
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    selectDateProvider = Provider.of<SelectDateProvider>(context);
    final date = DateTime.now();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCurrentDate(context);
      _fetchData(context);
    });

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(10),
        vertical: getProportionateScreenHeight(20),
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Consumer<DateProvider>(
                  builder: (ctx, date, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          date.finalMonth,
                          style: kBook.copyWith(fontSize: 36),
                        ),
                        Text(
                          'Today',
                          style: kBold.copyWith(fontSize: 32),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(10),
              ),
              child: DatePicker(
                DateTime.now(),
                width: getProportionateScreenWidth(60),
                height: getProportionateScreenHeight(120),
                controller: _controller,
                initialSelectedDate: date,
                daysCount: DateTime.daysPerWeek,
                selectionColor: kYellow,
                selectedTextColor: kWhite,
                monthTextStyle: kMedium,
                dayTextStyle: kMedium,
                dateTextStyle: kMedium.copyWith(fontSize: 28),
                onDateChange: (date) {
                  print("하하: $date");
                  _fetchData(context);
                  selectDateProvider.selectedValue = date;
                },
              ),
            ),
            _fetchData(context),
          ],
        ),
      ),
    );
  }
}
