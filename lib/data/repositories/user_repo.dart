import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_app/data/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepo {

  // sign up
  Future<UserModel?> signup(String userName ,String email , String password) async{
    try{
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      UserModel userModel = UserModel(
        userId: FirebaseAuth.instance.currentUser!.uid,
        userName: userName,
        email: email,
      );

      await FirebaseFirestore.instance.collection("User").doc(FirebaseAuth.instance.currentUser!.uid).set(userModel.toJson());


      return userModel;


    }catch(e){
      print("in user_repo catch error ${e.toString()}");
      return null;
    }

  }

  // sign in
  Future<UserModel?> signIn(String email , String password) async{
    try{

      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel userModel = UserModel(
        userId: FirebaseAuth.instance.currentUser!.uid,
        email: email,
        userName: ""
      );

      return userModel;

    }catch(e){
      print("in user_repo catch error ${e.toString()}");
      return null;
    }
  }

  // sign out
  Future<void> signOut() async{
    await FirebaseAuth.instance.signOut();
  }

  // check user
  Future<UserModel?> checkUserState() async{
    User? userState = FirebaseAuth.instance.currentUser;
    if(userState != null) {
      return UserModel(email: userState.email , userId: userState.uid);
    }else{
      return null;
    }

  }

  // sign in with google
  Future<UserModel?> signInWithGoogle() async{

    try{
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
     await FirebaseAuth.instance.signInWithCredential(credential);

     UserModel userModel = UserModel(
       userId: FirebaseAuth.instance.currentUser!.uid,
       email: FirebaseAuth.instance.currentUser!.email,
       userName: "" ,
     );

     return userModel;

    }catch(e){
      print("in user_repo catch error ${e.toString()}");
      return null;
    }


  }


  // sign in with faceBook
  Future<void> signInWithFaceBook() async{}

  // to reset password
  Future<void> resetPassword(String myEmail) async{
    var auth = FirebaseAuth.instance;
    try{
      if(myEmail.isNotEmpty){
        await auth.sendPasswordResetEmail(email: myEmail);
      }
    }catch(e){
      throw Exception("in password reset : ${e.toString()}");
    }
  }

}