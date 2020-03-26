
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth{
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  Future<String> signInWithGoogle();
  void signOutWithGoogle();
  Future<void> signOut();
}


class Auth implements BaseAuth{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signInWithEmailAndPassword(String email, String password) async{ 
    AuthResult user = await _firebaseAuth.signInWithEmailAndPassword(email:email, password:password);
    return user.user.uid;
  }

  Future<String> createUserWithEmailAndPassword(String email, String password) async{
    AuthResult user = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password:password);
    return user.user.uid;
  }

  Future<String> currentUser() async{
    FirebaseUser user = await _firebaseAuth.currentUser(); 
    return user.uid;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
    final AuthResult authResult = await _firebaseAuth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _firebaseAuth.currentUser();
    assert(user.uid == currentUser.uid);

    return 'signInWithGoogle succeeded: $user';
  }

  void signOutWithGoogle() async {
      await googleSignIn.signOut();
    print("User Sign Out");
  }

}

