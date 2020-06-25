import 'package:flutter/material.dart';
import 'package:ninja_brew_crew/screens/authenticate/signup_email.dart';
import 'package:ninja_brew_crew/services/auth.dart';
import 'package:ninja_brew_crew/screens/authenticate/phoneLogIn.dart';
import 'package:ninja_brew_crew/screens/authenticate/forgetPassword.dart';

class LoginEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner is set to false so that the debug badge from UI is removed
      debugShowCheckedModeBanner: false,
      home: SignIn(), // HomeScreen is the landing page of the app
    );
  }
}

// HomeScreen Widget is set to be Stateful but it is also not handling state
// as of now since, its just UI but while implementing features you need to add state variables
class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  // Build method runs again and again as the state changes to rebuild the UI
  final AuthService _auth= AuthService();
  final _formKey = GlobalKey<FormState>(); 
  
  //text field state
  String email='';
  String password='';
  String error='';

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
                backgroundColor: Colors.transparent,
                elevation: 0,
                // elevation removes the shadow under the action bar
                title: Text(
                  "LOGIN", style: TextStyle(fontWeight: FontWeight.bold),),
                centerTitle: true,
                leading: Icon(Icons.arrow_back),
                // Actions are identified as buttons which are added at the right of App Bar
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/genesis_logo.png'),
                  )
                ],
              ),
              ClipPath( 
                // ClipPath is used to clip the child in a custom shape
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
                        padding: const EdgeInsets.only(left:40,right:20,),
                        child: TextFormField(
                          validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                          onChanged: (val){
                               setState(()=>email=val);
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              labelText: 'Email'),
                        ),
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.only(left:40,right:20,),
                        child: TextFormField(
                          obscureText: true,
                          // To hide text which will be typed(password) 
                          validator: (val) => val.length<6 ? 'Enter a password with greater than 5 characters' : null,
                          onChanged: (val){
                             setState(()=>password=val);
                          },
                          
                          
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              labelText: 'Password',
                              suffixIcon: Icon(Icons.remove_red_eye)),
                        ),
                      ),
                      
                      
                      Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 18.0),
                          child: InkWell( // InkWell widget makes the widget clickable and provide call back for touch events
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPassword(),),);
                              print("Forget Password tap");
                            },
                            child: Text(
                              'Forget Password?',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: Color(0xffFBB034),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder:  (context)=>PhoneLogIn()),
                            );
                            print("login using mobile number tap");
                          },
                          child: RichText( // RichText is used to styling a particular text span in a text by grouping them in one widget
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,),
                              text: 'Login using ',
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Mobile Number and OTP',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          InkWell(
                            onTap: ()async{
                               if(_formKey.currentState.validate()){
                                dynamic result= await _auth.signInWithEmailAndPassword(email, password);
                                 if(result == null){
                                   setState(() {
                                    error='Could not sign in using those credentials!';
                                   });
                                 }
                               }
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
                            height: 40,width: 40,), // loading custom images from assets in Flutter
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));
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
                        ),
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