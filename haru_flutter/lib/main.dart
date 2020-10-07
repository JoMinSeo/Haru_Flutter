import 'package:flutter/material.dart';
import 'package:haru_flutter/providers/date_provider.dart';
import 'package:haru_flutter/providers/selecdate_provider.dart';
import 'package:haru_flutter/screens/Login/login_page.dart';
import 'package:haru_flutter/screens/main/main_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: DateProvider(),
        ),
        ChangeNotifierProvider.value(
          value: SelectDateProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Haru',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginPage(),
      ),
    );
  }
}
