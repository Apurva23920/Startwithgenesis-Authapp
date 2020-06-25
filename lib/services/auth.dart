import 'package:firebase_auth/firebase_auth.dart';
import 'package:ninja_brew_crew/models/user.dart';
import 'package:ninja_brew_crew/screens/authenticate/login_email.dart';
import 'package:ninja_brew_crew/screens/home/home.dart';
import 'package:ninja_brew_crew/screens/home/homeNewUser.dart';

class AuthService{
  
  final FirebaseAuth _auth= FirebaseAuth.instance;

  // create user object based on firebaseuser
  User _userFromFirebaseUser(FirebaseUser user){
    return user!=null?User(uid:user.uid):null;
  }
  // auth change user stream
  Stream<User> get user{
    return _auth.onAuthStateChanged
    .map(_userFromFirebaseUser);
  }


 //sign in anonomous
 // Future signInAnon() async{
 //  try{
 //    AuthResult result= await _auth.signInAnonymously();
 //    FirebaseUser user= result.user;
 //    return _userFromFirebaseUser(user);
 //   }catch(e){
 //    print(e.toString());
 //     return null;
      
 //  }
 //}

  //sign in using email & password
  Future signInWithEmailAndPassword(String email,String password)async{
    try{
       AuthResult result= await _auth.signInWithEmailAndPassword(email: email, password: password);
       FirebaseUser user= result.user;
       return Home();
    }catch(e){
     print(e.toString());
     return null;
    }
  }


  //register using email & password
  Future registerWithEmailAndPassword(String email,String password)async{
    try{
       AuthResult result= await _auth.createUserWithEmailAndPassword(email: email, password: password);
       FirebaseUser user= result.user;
       return LoginEmail();
    }catch(e){
     print(e.toString());
     return null;
    }
  }

  //sign in using mobile number 
  signIn(AuthCredential authCreds){
   FirebaseAuth.instance.signInWithCredential(authCreds);
   return NewUserHome();
  }

  //sign in using OTP
  signInWithOTP(smsCode, verId){
    AuthCredential authCreds= PhoneAuthProvider.getCredential(
      verificationId: verId,
       smsCode: smsCode);
       signIn(authCreds);
       return NewUserHome();
  }

  //signout
  Future signOut()async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}