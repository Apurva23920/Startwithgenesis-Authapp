import 'package:flutter/material.dart';
import 'package:ninja_brew_crew/screens/home/home.dart';

class NewUserHome extends StatefulWidget {
  @override
  _NewUserHomeState createState() => _NewUserHomeState();
}

class _NewUserHomeState extends State<NewUserHome> {
  String email;
  String name;
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
                  "PROFILE", style: TextStyle(fontWeight: FontWeight.bold),),
                centerTitle: true,
                
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
                   
                  child: Column(
                    children: <Widget>[  

                      Container(
                         alignment: Alignment.center,
                         height:150,
                      child:Stack(
                       children: <Widget>[
                           Image.asset('assets/AnishJha.png'),
                      
                           Positioned(
                            bottom: 8,right:4,
                            child: Icon(Icons.add_a_photo,color: Colors.grey[400],),
                      ),
                       ],
                      ),
                      ),



                      Padding(
                        padding: const EdgeInsets.only(left: 40.0,right: 20.0,bottom:10.0,),
                        child: TextFormField(
                          validator: (val) => val.isEmpty ? 'Enter your Name' : null,
                          onChanged: (val){
                               setState(()=>name=val);
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              labelText: 'Full Name'),
                        ),
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0,right: 20.0,bottom:20,),
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
                     
                      
                         
                      
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
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


  

  