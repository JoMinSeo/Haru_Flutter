import 'package:flutter/material.dart';
import 'package:haru_flutter/components/circle_button.dart';
import 'package:haru_flutter/constants/constants.dart';
import 'package:haru_flutter/providers/date_provider.dart';
import 'package:haru_flutter/providers/firebase_provider.dart';
import 'package:haru_flutter/providers/selecdate_provider.dart';
import 'package:haru_flutter/services/sizes/Sizeconfig.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:provider/provider.dart';

class MainBody extends StatelessWidget {
  DatePickerController _controller = DatePickerController();

  @override
  Widget build(BuildContext context) {

    final firebaseProvider = Provider.of<FirebaseProvider>(context);
    final selectprovider = Provider.of<SelectDateProvider>(context);
    final date = DateTime.now();
    
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCurrentDate(context);
    });

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
                Consumer<DateProvider>(
                  builder: (ctx, date, _){
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
                 selectprovider.selectedValue = date;
                },
              ),
            ),
            Text("${firebaseProvider.getUser()}")
          ],
        ),
      ),
    );
  }

   getCurrentDate(BuildContext context) {
    var date = new DateTime.now().toString();
    var dateParse = DateTime.parse(date);

    switch(dateParse.month){
      case 1:
        Provider.of<DateProvider>(context, listen: false).finalMonth = "January";
        break;
      case 2:
        Provider.of<DateProvider>(context, listen: false).finalMonth = "February";
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
        Provider.of<DateProvider>(context, listen: false).finalMonth = "September";
        break;
      case 10:
        Provider.of<DateProvider>(context, listen: false).finalMonth = "October";
        break;
      case 11:
        Provider.of<DateProvider>(context, listen: false).finalMonth = "November";
        break;
      case 12:
        Provider.of<DateProvider>(context, listen: false).finalMonth = "December";
        break;
      default:
        print("이상한데 씨발");
        break;
    }
  }
}
