import 'package:flutter/material.dart';
import 'package:ninja_brew_crew/screens/authenticate/login_email.dart';
import 'package:ninja_brew_crew/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth= AuthService();
  final _formKey = GlobalKey<FormState>(); 
  
  //text field state
  String email='';
  String password='';
  String fullName='';
  String phoneNo='';
  String confirmPassword='';
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
                  "SIGN UP", style: TextStyle(fontWeight: FontWeight.bold),),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back), 
                    onPressed:()=> Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginEmail(),)),
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
                        padding: const EdgeInsets.only(left:23,right:20,),
                        child: TextFormField(
                          
                          onChanged: (val){
                               setState(()=>fullName=val);
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              labelText: 'Full Name'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:23,right:20,),
                        child: TextFormField(
                         
                          onChanged: (val){
                               setState(()=>email=val);
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              labelText: 'Email'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:15,right:20,),
                        child: TextFormField(
                          
                          onChanged: (val){
                               setState(()=>phoneNo=val);
                          },
                          decoration: InputDecoration(
                              prefixIcon: Image.asset('assets/india-flag.png'),
                              labelText: 'Phone'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:23,right:20,),
                        child: TextFormField(
                          obscureText: true,
                          // To hide text which will be typed(password) 
                          
                          onChanged: (val){
                             setState(()=>password=val);
                          },
                          
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              labelText: 'Password',
                              suffixIcon: Icon(Icons.remove_red_eye)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:23,right:20,),
                        child: TextFormField(
                          obscureText: true,
                          // To hide text which will be typed(password) 
                          
                          onChanged: (val){
                             setState(()=>password=val);
                          },
                          
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              labelText: 'Confirm Password',
                              suffixIcon: Icon(Icons.remove_red_eye)),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left:34.0,right:4.0),
                                child: Icon(Icons.assignment_turned_in,
                                  color: Color(0xffffb034),
                                  size: 24.0,
                                  ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(),
                                child:Text(
                                  'I Agree to ',
                                  style: TextStyle(fontWeight:FontWeight.bold,fontSize: 16.0,color: Colors.grey),
                                  
                                  ),
                                ),
                                Padding(
                                padding: EdgeInsets.symmetric(),
                                child:Text(
                                  'Terms and Conditions',
                                  style: TextStyle(fontWeight:FontWeight.bold,fontSize: 16.0,color: Color(0xffffb034)),
                                  
                                  ),
                                ),
                            ],
                          ),
                           Row(
                             children: <Widget>[
                               Padding(
                                    padding: EdgeInsets.only(left: 46.0),
                                     
                                    child:Text(
                                      'and ',
                                      style: TextStyle(fontWeight:FontWeight.bold,fontSize: 16.0,color: Colors.grey),
                                      
                                      ),
                                    ),
                                    Padding(
                                    padding: EdgeInsets.only(),
                                     
                                    child:Text(
                                      'Privacy Policy',
                                      style: TextStyle(fontWeight:FontWeight.bold,fontSize: 16.0,color: Color(0xffffb034)),
                                      
                                      ),
                                    ),
                             ],
                           ),
                        ],
                      ),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: ()async{
                               if(_formKey.currentState.validate()){
                                 dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                                 if(result == null){
                                   setState(() {
                                     error='Please enter a valid email';
                                   });
                                 }
                               }
                            },
                          
                            child: Container(
                              margin: EdgeInsets.only(right: 50,left:50, top: 20),
                              decoration: BoxDecoration(
                                  color: Color(0xffFBB034),
                                  borderRadius: BorderRadius.circular(12)),
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '       Proceed       ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white, ) ,
                                
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
              
              SizedBox(height: 12.0,),
              Text(
                error,
                style: TextStyle(color: Colors.white,fontSize: 14.0),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                          text: "Click here to login",
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
}

// Custom Clipper Class
class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    // Add Path lines to form slight cut
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height );
    return path;
  }

  // we don't need to render it again and again as UI renders
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}


  