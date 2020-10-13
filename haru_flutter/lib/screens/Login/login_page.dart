import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:haru_flutter/constants/constants.dart';
import 'package:haru_flutter/providers/firebase_provider.dart';
import 'package:haru_flutter/screens/logout/logout_page.dart';
import 'package:haru_flutter/screens/main/main_page.dart';
import 'package:haru_flutter/services/sizes/Sizeconfig.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  FirebaseProvider firebaseProvider;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initApp();
  }

  void initApp() async {
    FirebaseApp defaultApp = await Firebase.initializeApp();
    firebaseProvider.auth = FirebaseAuth.instanceFor(app: defaultApp);
    checkIfUserIsSignedIn();
  }

  void checkIfUserIsSignedIn() async {
    var userSignedIn = await firebaseProvider.googleSignIn.isSignedIn();
    firebaseProvider.isUserSignedIn = userSignedIn;
  }

  @override
  Widget build(BuildContext context) {
    firebaseProvider = Provider.of<FirebaseProvider>(context, listen: false);

    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(30),
        ),
        child: Consumer<FirebaseProvider>(
          builder: (ctx, item, _){
            final boolSign = item.isUserSignedIn;
            return Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Haru",
                    style: kBold.copyWith(fontSize: 42),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: OutlineButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onPressed: () {
                        print("눌렀습니다.");
                        onGoogleSignIn(context);
                      },
                      borderSide: BorderSide(
                          color: boolSign ? kPurple : kPink),
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
                                boolSign
                                    ? "login complete"
                                    : "Sign in with Google",
                                style:
                                kMont.copyWith(fontSize: 16, color: kBlackGrey),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  loginSuccessButton(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void onGoogleSignIn(BuildContext context) async {
    User userLogin = await firebaseProvider.signInWithGoogleAccount();
    print("유저로그인 + $userLogin");

    firebaseProvider.isUserSignedIn = userLogin == null ? false : true;
    print("${firebaseProvider.isUserSignedIn} 로그인버튼 눌렀을때용");
  }

  Widget loginSuccessButton() {
    return ButtonTheme(
      minWidth: SizeConfig.screenWidth,
      height: getProportionateScreenHeight(68),
      buttonColor: kPurple,
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10)),
      child: InkWell(
        child: RaisedButton(
          color: kPurple,
          child: Text(
            '시작',
            style: kMedium.copyWith(fontSize: 24, color: Colors.white),
          ),
          onPressed: () {
            firebaseProvider.isUserSignedIn == true
                ? Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainPage()))
                : _scaffoldKey.currentState.showSnackBar(
                    SnackBar(
                      content: Text(
                        "로그인이 안되어있어요",
                        style: kMedium.copyWith(fontSize: 16),
                      ),
                      elevation: 0.5,
                      backgroundColor: kPurple,
                      duration: Duration(milliseconds: 2000),
                      action: SnackBarAction(
                        label: "확인",
                        textColor: kGrey,
                        disabledTextColor: kWhite,
                        onPressed: () {
                          print("snackBar Action Clicked");
                        },
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
