import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:haru_flutter/constants/constants.dart';
import 'package:haru_flutter/models/model_schedule.dart';
import 'package:haru_flutter/providers/date_provider.dart';
import 'package:haru_flutter/providers/selecdate_provider.dart';
import 'package:haru_flutter/services/sizes/Sizeconfig.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MainBody extends StatelessWidget {
  DatePickerController _controller = DatePickerController();
  FirebaseFirestore firebaseStore = FirebaseFirestore.instance;
  Stream<QuerySnapshot> streamData;

  Widget _fetchData(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('schedule').snapshots(),
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
    print("큰 스케쥴 $schedule");
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: (getProportionateScreenHeight(10)));
        },
        shrinkWrap: true,
        itemCount: schedule.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return bigListItem(context, snapshot[index]);
          } else if (index == 1) {
            return bigListItem(context, snapshot[index]);
          }
          return smallListItem(context, snapshot[index]);
        },
      ),
    );
  }

  Widget bigListItem(BuildContext context, DocumentSnapshot data) {
    final schedule = Schedule.fromSnapshot(data);
    DateTime dateTime = schedule.time.toDate();
    print("스케쥴 : $schedule");
    return InkWell(
      child: Container(
          height: getProportionateScreenHeight(120),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: schedule.category == 0 ? kPink : schedule.category == 1 ? kPurple : kYellow,
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
            child: Column(
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
                      DateFormat.jm().add_jm().format(dateTime),
                      textAlign: TextAlign.center,
                      style: kMedium.copyWith(color: schedule.category == 0 ? kPink : schedule.category == 1 ? kPurple : kYellow, fontSize: 12),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget smallListItem(BuildContext context, DocumentSnapshot data) {
    final schedule = Schedule.fromSnapshot(data);
    print("스케쥴 : $schedule");
    return InkWell(
      child: Container(
          height: getProportionateScreenHeight(50),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kPurple,
            boxShadow: [
              BoxShadow(
                color: Color(0x10000000),
                offset: Offset(0, 0),
                blurRadius: 6,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Text("안녕하세요")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectProvider = Provider.of<SelectDateProvider>(context);
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
                  selectProvider.selectedValue = date;
                },
              ),
            ),
            _fetchData(context),
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
}
