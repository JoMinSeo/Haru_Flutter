import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _auth;

  bool isUserSignedIn = false;

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
    _auth = FirebaseAuth.instanceFor(app: defaultApp);
    checkIfUserIsSignedIn();
  }

  void checkIfUserIsSignedIn() async {
    var userSignedIn = await _googleSignIn.isSignedIn();

    setState(() {
      isUserSignedIn = userSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
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
              Align(
                alignment: Alignment.center,
                child: OutlineButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onPressed: () {
                    onGoogleSignIn(context);
                  },
                  borderSide: BorderSide(color: isUserSignedIn ? kPurple : kPink),
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
                            isUserSignedIn ? "login complete" : "Sign in with Google",
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
        ),
      ),
    );
  }

  Future<User> _handleSignIn() async {
    User user;
    bool userSignedIn = await _googleSignIn.isSignedIn();

    setState(() {
      isUserSignedIn = userSignedIn;
    });

    if (isUserSignedIn) {
      user = _auth.currentUser;
    } else {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      user = (await _auth.signInWithCredential(credential)).user;
      userSignedIn = await _googleSignIn.isSignedIn();
      setState(() {
        isUserSignedIn = userSignedIn;
      });
    }

    return user;
  }

  void onGoogleSignIn(BuildContext context) async {
    User user = await _handleSignIn();
    var userSignedIn = await _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("로그인 성공"),));

    setState(() {
      isUserSignedIn = userSignedIn == null ? true : false;
    });
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
            isUserSignedIn == true
                ? Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainPage(user, _googleSignIn)))
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
