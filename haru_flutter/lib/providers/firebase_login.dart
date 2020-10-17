import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status { unauth, auth, loading }

class FirebaseLogin{
  Status _status;
  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;
  Stream<User> user; // Firebase에 로그인 된 사용자
  Stream<Map<String, dynamic>> profile;

  String _uuid;
  var name;
  var image;

  bool isUserSignedIn = false;


  Status get status => _status;

  set status(Status val) {
    _status = val;
  }

  FirebaseLogin() {
    user = auth.authStateChanges();
    print(user);

    profile = user.switchMap((User u) {
      if (u != null) {
        return _db
            .collection('users')
            .doc(u.uid)
            .snapshots()
            .map((snap) => snap.data());
      } else {
        return Stream.value({});
      }
    });
  }

  // 구글 계정을 이용하여 Firebase에 로그인
  Future<User> signInWithGoogleAccount() async {
    status = Status.loading;
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    status = Status.auth;

    User user = (await auth.signInWithCredential(credential)).user;
    _uuid = user.uid;
    name = user.displayName;
    image = user.photoURL;

    return user;
  }

  // Firebase로부터 로그아웃
  @override
  Future<void> signOut() {
    status = Status.loading;
    auth.signOut();
  }

  login() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', _uuid);
  }

  logout() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove('uid');
    user = null;
  }

  // // Firebase로부터 회원 탈퇴
  // withdrawalAccount() async {
  //   await delete(user);
  //   user = null;
  // }

  autoLogin() async {
    var prefs = await SharedPreferences.getInstance();

    String _uid = prefs.getString('uid');
    //print("Autologin: "+_uid);
    return _uid.toString();
  }
}
