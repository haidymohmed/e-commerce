import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_sign_in/google_sign_in.dart';
class AuthContraller{
  late FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  // ignore: non_constant_identifier_names
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  signUp( email , password , name )async{
    // create User
    var userAccount = await auth.createUserWithEmailAndPassword(email: email, password: password);
    await auth.currentUser!.sendEmailVerification();
    await users.doc(userAccount.user!.uid).set({ 'email' : email, 'name' : name, 'id' : userAccount.user!.uid, 'isAdmin' : false })
        .then((value) => print("Done"))
        .catchError((error) => print("Failed to add user: $error")
    );
    return auth.currentUser!.emailVerified;
  }
  logIn( email , password )async{
    var userLogIn = await auth.signInWithEmailAndPassword(email: email, password: password);
    return userLogIn.user!.uid;
  }
  ifUserIsAdmin(String id)async{
    var x = await users.doc(id).get();
    return x.get('isAdmin');
  }
  forgotPassword(email)async{
    await auth.sendPasswordResetEmail(email: email);
  }
  signOut()async{
    await auth.signOut();
  }
  logInWithGoogle()async {
      // Sign in with Google
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
      return ;
  }
  logInWithFacebook()async{
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login(permissions: ['email,']);
    print("first step");
    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
    print("second step");
    // Once signed in, return the UserCredential
    FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    print("third step");

    return ;
  }
}