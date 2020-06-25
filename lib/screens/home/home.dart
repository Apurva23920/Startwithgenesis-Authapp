import 'package:flutter/material.dart';
import 'package:ninja_brew_crew/services/auth.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner is set to false so that the debug badge from UI is removed
      debugShowCheckedModeBanner: false,
      home: HomeScreen(), // HomeScreen is the landing page of the app
    );
  }
}

// HomeScreen Widget is set to be Stateful but it is also not handling state
// as of now since, its just UI but while implementing features you need to add state variables
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Build method runs again and again as the state changes to rebuild the UI
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // SingleChildScrollView makes the UI not to overflow from bottom when TextField is used or different device is used
      body: SingleChildScrollView(
        
          child: Column( // Column Widget is added to Render the complete UI in vertical direction
            children: <Widget>[
              // App Bar is added in the body parameter of the Scaffold because we need to make it transparent and
              // show the gradient in background. Alternative option will be to use gradient action bar from pub.dev
              AppBar(
                backgroundColor: Color(0xffFBB034),
                elevation: 0,
                // elevation removes the shadow under the action bar
                
                centerTitle: true,
                leading: Icon(Icons.menu),


                // Actions are identified as buttons which are added at the right of App Bar
                actions: <Widget>[
                  IconButton(icon: Icon(Icons.exit_to_app),
                   onPressed: ()async{
                      await _auth.signOut();//code for returning to login page
                   }),
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
                  padding: EdgeInsets.only(top: 50, bottom: 80),
                  margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(1, 1),
                          spreadRadius: 1.0,
                          blurRadius: 2.0,

                          )
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: <Widget>[

                     Container(
                        child: Padding(
                              padding: EdgeInsets.only(right:30,left:30,top: 30,),
                              child: Image.asset('assets/genesis_logo.png'), // loading custom images from assets in Flutter
                              // NOTE that if you have not addressed these images in pubspec.yaml then it will show error
                            ),
                      ),

                    Container(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.check_circle,color: Colors.greenAccent[400],size: 55,),
                               
                      ),
                    ),

                     Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "First Challenge",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Completed",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: Colors.black,
                        ),
                      ), 
                    ],
                  ),
                    ],
              ),
              
              
                ),
          ),
            ]
      
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

