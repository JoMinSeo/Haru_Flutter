import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();

class FirebaseProvider extends ChangeNotifier {
  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseAuth auth;
  bool _isUserSignedIn = false;

  User _user; // Firebase에 로그인 된 사용자

  User get user => _user;

  set user(User value) {
    _user = value;
    notifyListeners();
  }

  bool get isUserSignedIn => _isUserSignedIn;

  set isUserSignedIn(bool isUserSignedIn){
    _isUserSignedIn = isUserSignedIn;
    print("값이 이렇게 설정 되었어요 + $isUserSignedIn");
    notifyListeners();
  }

  // // 최근 Firebase에 로그인한 사용자의 정보 획득
  // _prepareUser() {
  //   _user = _auth.currentUser;
  // }

  // 구글 계정을 이용하여 Firebase에 로그인
  Future<User> signInWithGoogleAccount() async {
    // try {
    bool userSignedIn = await googleSignIn.isSignedIn();
    print("로그인상태는 $userSignedIn");
    print("$user");
    isUserSignedIn = userSignedIn;

    if (isUserSignedIn) {
      print("데이터는 $isUserSignedIn입니다.");
      user = auth.currentUser;
      print("처리후 유저 : $user");
    } else {
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      user = (await auth.signInWithCredential(credential)).user;
      userSignedIn = await googleSignIn.isSignedIn();
      isUserSignedIn = userSignedIn;
      print(isUserSignedIn);
    }
    // } on Exception catch (e) {
    //   logger.e(e.toString());
    //   List<String> result = e.toString().split(", ");
    //   return null;
    // }
    notifyListeners();
    return user;
  }

  // Firebase로부터 로그아웃
  signOut() async {
    await auth.signOut();
    user = null;
    isUserSignedIn = false;
  }

  // 사용자에게 비밀번호 재설정 메일을 영어로 전송 시도
  sendPasswordResetEmailByEnglish() async {
    await auth.setLanguageCode("en");
    sendPasswordResetEmail();
  }

  // 사용자에게 비밀번호 재설정 메일을 한글로 전송 시도
  sendPasswordResetEmailByKorean() async {
    await auth.setLanguageCode("ko");
    sendPasswordResetEmail();
  }

  // 사용자에게 비밀번호 재설정 메일을 전송
  sendPasswordResetEmail() async {
    auth.sendPasswordResetEmail(email: user.email);
  }

  // Firebase로부터 회원 탈퇴
  withdrawalAccount() async {
    await user.delete();
    user = null;
    isUserSignedIn = false;
  }
}
