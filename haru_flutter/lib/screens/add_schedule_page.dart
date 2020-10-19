import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haru_flutter/constants/constants.dart';
import 'package:haru_flutter/providers/list_provider.dart';
import 'package:haru_flutter/services/sizes/Sizeconfig.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddSchedulePage extends StatefulWidget {
  @override
  _AddSchedulePageState createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  FocusNode titleFocusNode;
  FocusNode contentFocusNode;

  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<ListProvider>(context);

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
                    color: kPink,
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
                  decoration: InputDecoration(
                    hintText: "What's the matter?",
                    hintStyle: kMedium,
                    focusColor: kRed,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kBlack),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kPink),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add_circle, color: kPink),
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
                  decoration: InputDecoration(
                    hintText: "What is the content?",
                    hintStyle: kMedium,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kBlack),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kPink),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add_circle, color: kPink),
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
                          containerHeight: 210.0,
                        ),
                        showTitleActions: true,
                        minTime: DateTime(2000, 1, 1),
                        maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
                      print('confirm $date');
                      listProvider.date =
                          '${date.year} - ${date.month} - ${date.day}';
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
                                    color: kPink,
                                  ),
                                  SizedBox(
                                    width: getProportionateScreenWidth(10),
                                  ),
                                  Text(
                                    " ${listProvider.date}",
                                    style: kMedium.copyWith(
                                        color: kPink, fontSize: 18),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Text(
                          "  Change",
                          style: kMedium.copyWith(color: kPink, fontSize: 18),
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
                          containerHeight: 210.0,
                        ),
                        showTitleActions: true, onConfirm: (time) {
                      print('confirm $time');
                      listProvider.time =
                          '${time.hour} : ${time.minute} : ${time.second}';
                      setState(() {});
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                    setState(() {});
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
                                    color: kPink,
                                  ),
                                  SizedBox(
                                    width: getProportionateScreenWidth(10),
                                  ),
                                  Text(" ${listProvider.time}",
                                      style: kMedium.copyWith(
                                          color: kPink, fontSize: 18)),
                                ],
                              ),
                            )
                          ],
                        ),
                        Text(
                          "  Change",
                          style: kMedium.copyWith(color: kPink, fontSize: 18),
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
              Container(
                child: Column(
                  children: [
                    Text(
                      'Select Category',
                      style: kMedium.copyWith(fontSize: 20),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          child: FlatButton(
                            color: kPink,
                            onPressed: () {},
                            child: Text(
                              "안녕",
                              style: kBold.copyWith(color: kWhite),
                            ),
                          ),
                        ),
                        InkWell(
                          child: FlatButton(
                            color: kPurple,
                            onPressed: () {},
                            child: Text(
                              "안녕",
                              style: kBold.copyWith(color: kWhite),
                            ),
                          ),
                        ),
                        InkWell(
                          child: FlatButton(
                            color: kYellow,
                            onPressed: () {},
                            child: Text(
                              "안녕",
                              style: kBold.copyWith(color: kWhite),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          )),
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
}
