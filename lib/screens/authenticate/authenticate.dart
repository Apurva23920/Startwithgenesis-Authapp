import 'package:flutter/material.dart';
import 'package:ninja_brew_crew/screens/authenticate/login_email.dart';
import 'package:ninja_brew_crew/screens/authenticate/signup_email.dart';


class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn=true;
  
  
  void toggleView(){
    setState(() {
      showSignIn= !showSignIn;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignIn(toggleView: toggleView);
    }
    else{
      return Register(toggleView: toggleView);
    }
   
  }
}