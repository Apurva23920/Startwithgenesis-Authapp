import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ninja_brew_crew/screens/authenticate/login_email.dart';
import 'package:ninja_brew_crew/screens/authenticate/signup_email.dart';
import 'package:ninja_brew_crew/services/auth.dart';
import 'package:ninja_brew_crew/screens/authenticate/phoneOTP.dart';

class PhoneLogIn extends StatefulWidget {
  @override
  _PhoneLogInState createState() => _PhoneLogInState();
}

class _PhoneLogInState extends State<PhoneLogIn> {
  final _formKey = GlobalKey<FormState>(); 
  String phoneNo;
  String verificationId;
  String smsCode;
  String copyPhoneNo;

  bool codeSent= false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // SingleChildScrollView makes the UI not to overflow from bottom when TextField is used or different device is used
      body: SingleChildScrollView(
        child: Container(
          // MediaQuery.of(context).size provides the Dimensions of the parent widget
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            // Adding Linear Gradient to the background of UI
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              // Colors are converted to Integer from Hex Codes by replacing # with 0xff
              colors: [Color(0xffFBB034), Color(0xffF8B313)],
            ),
          ),
          child: Column( // Column Widget is added to Render the complete UI in vertical direction
            children: <Widget>[
              // App Bar is added in the body parameter of the Scaffold because we need to make it transparent and
              // show the gradient in background. Alternative option will be to use gradient action bar from pub.dev
              AppBar(
                automaticallyImplyLeading: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                // elevation removes the shadow under the action bar
                title: Text(
                  "LOGIN", style: TextStyle(fontWeight: FontWeight.bold),),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back), 
                    onPressed:()=> Navigator.pop(context,false),
                    ),
                // Actions are identified as buttons which are added at the right of App Bar
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/genesis_logo.png'),
                  )
                ],
              ),
              ClipPath( // ClipPath is used to clip the child in a custom shape
                clipper: BottomClipper(),
                // here is the custom clipper for bottom cut shape
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  padding: EdgeInsets.only(top: 20, bottom: 25),
                  margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(1, 2),
                          spreadRadius: 1.0,
                          blurRadius: 5.0)
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                   child:Form(
                    key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          onChanged: (val){
                               setState(() {
                                 this.phoneNo = val;
                                 copyPhoneNo=val;
                               });
                          },
                          decoration: InputDecoration(
                              prefixIcon: Image.asset('assets/india-flag.png'),
                              labelText: 'Enter Phone number'),
                        ),
                      ),


                       codeSent?Navigator.push(context,MaterialPageRoute(builder: (context)=>PhoneOTP())):Container(),

                      
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 28),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text('We will send you an One Time Password',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  ),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 28),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text('on this Mobile number',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  ),),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 60.0,),
                      Padding(
                        padding: const EdgeInsets.only(left:28),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginEmail()));
                                  print("login using email and password tap");
                                },
                                child: RichText( // RichText is used to styling a particular text span in a text by grouping them in one widget
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,),
                                    text: 'Login using ',
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Email and Password',
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          InkWell(
                            onTap: ()async{
                                verifyPhone(phoneNo);
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 20, top: 10),
                              decoration: BoxDecoration(
                                  color: Color(0xffFBB034),
                                  borderRadius: BorderRadius.circular(30)),
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                Icons.navigate_next,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                   ),
                ),
              ),
              ClipPath(
                clipper: TopClipper(), // Custom Clipper for top clipping the social login menu box
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 40, bottom: 40),
                  margin: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(1, 2),
                          spreadRadius: 1.0,
                          blurRadius: 5.0),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Or",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff898989),
                        ),
                      ),
                      Text(
                        "Login with Social Media",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff898989),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Image.asset('assets/fb_logo.png',
                            height: 40,width: 40,),
                            // loading custom images from assets in Flutter
                            // NOTE that if you have not addressed these images in pubspec.yaml then it will show error
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Image.asset('assets/google_plus.png',height: 40,width: 40,),
                            
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()),
                    );
                    print("don't have an account tap");

                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                          text: "Click here to signup",
                          style:
                          TextStyle(decoration: TextDecoration.underline),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> verifyPhone(phoneNo)async{
final PhoneVerificationCompleted verified=(AuthCredential authresult){
 AuthService().signIn(authresult);
};
final PhoneVerificationFailed verificationfailed=(AuthException authException){
  print('${authException.message}');
};
final PhoneCodeSent smsSent= ( String verId, [int forceResend]){
  this.verificationId=verId;
  setState(() {
    this.codeSent=true;
  });
};
final PhoneCodeAutoRetrievalTimeout autoTimeout= (String verId){
  this.verificationId=verId;
};

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      timeout: const Duration(seconds: 5),
      verificationCompleted: verified,
      verificationFailed: verificationfailed,
      codeSent: smsSent,
      codeAutoRetrievalTimeout: autoTimeout);
  }
}

// Custom Clipper Class
class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    // Add Path lines to form slight cut
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height - 50);
    return path;
  }

  // we don't need to render it again and again as UI renders
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width, 50);
    path.lineTo(size.width, size.height + 10);
    path.lineTo(0, size.height + 10);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
  