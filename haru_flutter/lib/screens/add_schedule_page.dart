import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:haru_flutter/constants/constants.dart';
import 'package:haru_flutter/firebase_login.dart';
import 'package:haru_flutter/providers/list_provider.dart';
import 'package:haru_flutter/providers/selecdate_provider.dart';
import 'package:haru_flutter/services/sizes/Sizeconfig.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddSchedulePage extends StatefulWidget {
  @override
  _AddSchedulePageState createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  FocusNode titleFocusNode;
  FocusNode contentFocusNode;
  ListProvider listProvider;
  SelectDateProvider selectDateProvider;
  final FirebaseLogin _auth = FirebaseLogin();

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of<ListProvider>(context);
    selectDateProvider = Provider.of<SelectDateProvider>(context);
    List<String> list = ['Meeting', 'Work', 'Life'];

    return Container(
      color: Color(0xFF757575),
      child: Container(
        // height: getProportionateScreenHeight(400),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: getProportionateScreenHeight(80),
              decoration: BoxDecoration(
                  color: kYellow,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0))),
              child: Center(
                child: Text(
                  "Create a new Task",
                  style: kMedium.copyWith(fontSize: 24, color: kWhite),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenHeight(10),
              ),
              child: TextField(
                autofocus: false,
                onTap: _requestFocus,
                controller: listProvider.titleTextController,
                textAlign: TextAlign.start,
                focusNode: titleFocusNode,
                onChanged: (text) {
                  listProvider.title = text;
                },
                decoration: InputDecoration(
                  hintText: "What's the matter?",
                  hintStyle: kMedium,
                  focusColor: kYellow,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kBlack),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kYellow),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      listProvider.title =
                          listProvider.titleTextController.text;
                    },
                    icon: Icon(Icons.add_circle, color: kYellow),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(10),
                horizontal: getProportionateScreenWidth(20),
              ),
              child: TextField(
                autofocus: false,
                controller: listProvider.contentTextController,
                textAlign: TextAlign.start,
                focusNode: contentFocusNode,
                onChanged: (text) {
                  listProvider.content = text;
                },
                decoration: InputDecoration(
                  hintText: "What is the content?",
                  hintStyle: kMedium,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kBlack),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kYellow),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      listProvider.content =
                          listProvider.contentTextController.text;
                    },
                    icon: Icon(Icons.add_circle, color: kYellow),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      theme: DatePickerTheme(
                        containerHeight: getProportionateScreenHeight(210),
                      ),
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      maxTime: DateTime(2025, 12, 31), onConfirm: (date) {
                    print('confirm1 $date');
                    listProvider.fullTime = date;
                    listProvider.compareTime =
                        date;
                    listProvider.date = DateFormat('yyyy-MM-dd').format(date);
                    setState(() {});
                  }, currentTime: DateTime.now(), locale: LocaleType.ko);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.date_range,
                                  size: 20.0,
                                  color: kYellow,
                                ),
                                SizedBox(
                                  width: getProportionateScreenWidth(10),
                                ),
                                Text(
                                  " ${listProvider.date}",
                                  style: kMedium.copyWith(
                                      color: kYellow, fontSize: 18),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "  Change",
                        style: kMedium.copyWith(color: kYellow, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                onPressed: () {
                  DatePicker.showTimePicker(context,
                      theme: DatePickerTheme(
                        containerHeight: getProportionateScreenHeight(210),
                      ),
                      showTitleActions: true, onConfirm: (time) {
                    print('confirm2 $time');
                    listProvider.fullTime = time;
                    listProvider.time = DateFormat('HH:mm:ss').format(time);
                  }, currentTime: listProvider.fullTime, locale: LocaleType.en);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.access_time,
                                  size: 20.0,
                                  color: kYellow,
                                ),
                                SizedBox(
                                  width: getProportionateScreenWidth(10),
                                ),
                                Text(" ${listProvider.time}",
                                    style: kMedium.copyWith(
                                        color: kYellow, fontSize: 18)),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "  Change",
                        style: kMedium.copyWith(color: kYellow, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(12),
            ),
            Container(
              child: Column(
                children: [
                  Text(
                    'Select Category',
                    style: kMedium.copyWith(fontSize: 20),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(24),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      customRadio(list[0], 0, kPink),
                      customRadio(list[1], 1, kPurple),
                      customRadio(list[2], 2, kYellow),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenHeight(36),
              ),
              child: SizedBox(
                width: double.infinity,
                height: getProportionateScreenHeight(55),
                child: FlatButton(
                  color: kPink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  onPressed: () {
                    addData();
                    listProvider.init();
                    Navigator.pop(context);
                  },
                  child: Text(
                    "complete",
                    style: kMedium.copyWith(color: kWhite, fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    titleFocusNode = FocusNode();
    contentFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    titleFocusNode.dispose();
    contentFocusNode.dispose();
  }

  void _requestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(titleFocusNode);
    });
  }

  addData() {
    Map<String, dynamic> data = {
      "UID": _auth.auth.currentUser.uid,
      "category": listProvider.categoryIdx,
      "content": listProvider.content,
      "alarmTime": listProvider.fullTime,
      "date": listProvider.compareTime,
      "title": listProvider.title,
    };

    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('schedule');
    collectionReference.add(data);
  }

  Widget customRadio(String txt, int index, Color color) {
    return SizedBox(
      height: getProportionateScreenHeight(55),
      child: OutlineButton(
        onPressed: () => listProvider.categoryIdx = index,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        borderSide: BorderSide(
            color: listProvider.categoryIdx == index ? color : kGrey),
        child: Text(txt, style: kMedium),
      ),
    );
  }
}
