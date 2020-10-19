import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:haru_flutter/constants/constants.dart';
import 'package:haru_flutter/providers/firebase_login.dart';
import 'package:haru_flutter/services/sizes/Sizeconfig.dart';

class LogoutPage extends StatelessWidget {

  final FirebaseLogin _auth = FirebaseLogin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(50),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipOval(
                  child: Image.network(_auth.auth.currentUser.photoURL,
                      width: 100, height: 100, fit: BoxFit.cover)),
              SizedBox(height: 20),
              Text('Welcome,', textAlign: TextAlign.center),
              Text(_auth.auth.currentUser.displayName,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              SizedBox(height: 20),
              OutlineButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                onPressed: () {
                  _auth.signOut();
                  _auth.logout();
                  print("로그아웃");
                  Navigator.popAndPushNamed(context, "/");
                },
                borderSide: BorderSide(color: kRed),
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
                        padding: EdgeInsets.only(
                            left: getProportionateScreenWidth(10)),
                        child: Text(
                          "Logout of Google",
                          style:
                          kMont.copyWith(fontSize: 16, color: kBlackGrey),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}