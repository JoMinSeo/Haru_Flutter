import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:haru_flutter/constants/constants.dart';
import 'package:haru_flutter/screens/main/main_page.dart';
import 'package:haru_flutter/services/sizes/Sizeconfig.dart';

FirebaseAuth auth = FirebaseAuth.instance;
GoogleSignIn googleSignIn = GoogleSignIn();

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(30),
        ),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "Haru",
                style: kBold.copyWith(fontSize: 42),
              ),
              _signInButton(),
              loginSuccessButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: kGrey,
      onPressed: () => StatefulWidget.of(context).si,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      borderSide: BorderSide(color: kBlack),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(12),
            horizontal: getProportionateScreenWidth(20)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage("assets/images/google.png"),
              height: getProportionateScreenHeight(36.0),
            ),
            Padding(
              padding: EdgeInsets.only(left: getProportionateScreenWidth(10)),
              child: Text(
                "Sign in with Google",
                style: kMont.copyWith(fontSize: 16, color: kBlackGrey),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget loginSuccessButton() {
    return ButtonTheme(
      minWidth: SizeConfig.screenWidth,
      height: getProportionateScreenHeight(68),
      buttonColor: kPurple,
      shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10)),
      child: InkWell(
        child: RaisedButton(
          color: kPurple,
          child: Text(
            '시작', style: kMedium.copyWith(fontSize: 24, color: Colors.white),),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MainPage()));
          },
        ),
      ),
    );
  }
}
