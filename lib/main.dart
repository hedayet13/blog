import 'package:blog/authentication/phoneAuthentication.dart';
import 'package:blog/firstScreen.dart';
import 'package:blog/signUp.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:blog/authentication/auth.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  loginPage()
    );
  }
}

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _success;
  String _userEmail;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Center(
          child: Container(
//            color: Color(0xFF080e33),
          color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _emailController,
                      validator: (String value){
                        if(value.isEmpty){
                          return'Please input some text';
                        }
                        return null;
                      },
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.alternate_email,
                            color: Colors.blue,
                          ),
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.blue),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 3.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      validator: (String value){
                        if (value.length<6){
                          return 'Your password must be greater than 6 characters';
                        }
                      },

                      obscureText: true,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.security,
                            color: Colors.red,
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.deepOrange),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.deepOrange, width: 3.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                      color: Colors.blue,
                      shape: StadiumBorder(),
                      onPressed: () async{
                        _signInWithEmailAndPassword();
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      splashColor: Colors.indigoAccent,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
                    },

                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                      color: Colors.redAccent,
                      shape: StadiumBorder(),

                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      splashColor: Color(0xFF400000),
                    ),
                    SizedBox(height: 10,),
                    RaisedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>PhonePage()));
                        },
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 80),
                    color: Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.phone),
                        Text('Create account Using Phone Number')
                      ],
                    ),
                    )

                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed:() {
            handleSignIn().then((FirebaseUser user) => print(user)).catchError((e)=>print(e));
          },
          label: Text("Google Sign In",) ,
          icon: Icon(Icons.mail),
          ),
        );
  }

  void _signInWithEmailAndPassword() async{
    final FirebaseUser user = (await _auth.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text)).user;
    if (user!= null){
      setState(() {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>FirstScreen()));
        _success = true;
        _userEmail= user.email;
      });
    }else{
      setState(() {
        _success = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

