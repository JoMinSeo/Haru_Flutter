import 'package:flutter/material.dart';
import 'package:haru_flutter/components/circle_button.dart';
import 'package:haru_flutter/constants/constants.dart';
import 'package:haru_flutter/providers/date_provider.dart';
import 'package:haru_flutter/providers/selecdate_provider.dart';
import 'package:haru_flutter/services/sizes/Sizeconfig.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:provider/provider.dart';

class MainBody extends StatelessWidget {
  DatePickerController _controller = DatePickerController();
  DateTime _selectedValue = DateTime.now();
  String finalMonth = '';

  @override
  Widget build(BuildContext context) {

    final selectprovider = Provider.of<SelectDateProvider>(context);

    getCurrentDate();
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: getProportionateScreenHeight(20),
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'September',
                      style: kBook.copyWith(fontSize: 36),
                    ),
                    Text(
                      'Today',
                      style: kBold.copyWith(fontSize: 32),
                    ),
                  ],
                ),
              ],
            ),
            DatePicker(
              DateTime.now(),
              width: getProportionateScreenWidth(60),
              height: getProportionateScreenHeight(120),
              controller: _controller,
              initialSelectedDate: DateTime.now(),
              daysCount: DateTime.daysPerWeek,
              selectionColor: kGrey,
              selectedTextColor: kWhite,
              monthTextStyle: kMedium,
              dayTextStyle: kMedium,
              dateTextStyle: kMedium.copyWith(fontSize: 28),
              onDateChange: (date) {
               selectprovider.selectedValue = date;
              },
            )
          ],
        ),
      ),
    );
  }

   getCurrentDate() {
    var date = new DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    // switch(dateParse.month){
    //   case 1:
    //     ;
    //     break;
    //   case 2:
    //     Provider.of<DateProvider>(context, listen: false) = "February";
    //     break;
    //   case 3:
    //     finalMonth = "March";
    //     break;
    //   case 4:
    //     finalMonth = "April";
    //     break;
    //   case 5:
    //     finalMonth = "May";
    //     break;
    //   case 6:
    //     finalMonth = "June";
    //     break;
    //   case 7:
    //     finalMonth = "July";
    //     break;
    //   case 8:
    //     finalMonth = "August";
    //     break;
    //   case 9:
    //     finalMonth = "September";
    //     break;
    //   case 10:
    //     finalMonth = "October";
    //     break;
    //   case 11:
    //     finalMonth = "November";
    //     break;
    //   case 12:
    //     finalMonth = "December";
    //     break;
    //   default:
    //     print("이상한데 씨발");
    //     break;
    // }
  }
}
