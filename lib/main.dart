import 'package:blog/firstScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';


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

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Container(
//            color: Color(0xFF080e33),
          color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
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
                    onPressed: () {},
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>FirstScreen()));
                  },

                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                    color: Colors.redAccent,
                    shape: StadiumBorder(),

                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    splashColor: Color(0xFF400000),
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed:() {

             },
          label: Text("Google Sign In",) ,
          icon: Icon(Icons.mail),
          ),
        );
  }


}
