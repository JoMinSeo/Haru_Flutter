import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:haru_flutter/constants/constants.dart';
import 'package:haru_flutter/screens/add_schedule_page.dart';
import 'package:haru_flutter/screens/bug/bugreport_page.dart';
import 'package:haru_flutter/screens/logout/logout_page.dart';
import 'package:haru_flutter/screens/main/main_body.dart';
import 'package:haru_flutter/services/sizes/Sizeconfig.dart';

class MainPage extends StatelessWidget {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: MainBody(),
      floatingActionButton: Builder(
        builder: (context) => FabCircularMenu(
          key: fabKey,
          alignment: Alignment.bottomRight,
          ringColor: kPink,
          ringDiameter: 350.0,
          ringWidth: 100.0,
          fabSize: getProportionateScreenWidth(52),
          fabElevation: 8.0,
          fabColor: kRed,
          fabOpenColor: kPink,
          fabOpenIcon: Icon(Icons.add, color: kWhite),
          fabCloseIcon: Icon(Icons.close, color: kWhite),
          fabMargin: const EdgeInsets.all(16.0),
          animationDuration: const Duration(milliseconds: 800),
          animationCurve: Curves.easeInOutCirc,
          onDisplayChange: (isOpen) {},
          children: <Widget>[
            RawMaterialButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => SingleChildScrollView(
                    child: Container(
                      // padding: EdgeInsets.only(
                      //     bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: AddSchedulePage(),
                    ),
                  ),
                );
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Icon(Icons.add, color: Colors.white),
            ),
            RawMaterialButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => BugReportPage()));
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            RawMaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LogoutPage()));
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Icon(Icons.settings, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  // void _showSnackBar(BuildContext context, String message) {
  //   Scaffold.of(context).showSnackBar(SnackBar(
  //     content: Text(message),
  //     duration: const Duration(milliseconds: 1000),
  //   ));
  // }
}
