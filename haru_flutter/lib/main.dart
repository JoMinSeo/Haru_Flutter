import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:haru_flutter/providers/date_provider.dart';
import 'package:haru_flutter/providers/firebase_login.dart';
import 'package:haru_flutter/providers/selecdate_provider.dart';
import 'package:haru_flutter/screens/Login/login_page.dart';
import 'package:haru_flutter/screens/main/main_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => RoutePage(),
          '/loginPage': (BuildContext context) => LoginPage(),
          '/mainPage': (BuildContext context) => MainPage(),
        },
      ),
    );
  }
}

class RoutePage extends StatefulWidget {
  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {

  FirebaseLogin _auth = FirebaseLogin();

  @override
  void initState() {
    super.initState();
    print("Init state");
    _auth.autoLogin().then((value){
      if(value == 'null')
      {
        print(_auth.isUserSignedIn);
        setState(() {
          _auth.isUserSignedIn = false;
        });
      }
      else if(value !=null)
      {
        setState(() {
          _auth.isUserSignedIn = true;
        });
      }
      else{
        setState(() {
          _auth.isUserSignedIn = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _auth.isUserSignedIn == true ? MainPage() : LoginPage();
  }
}

