
import 'package:blog/firstScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final Firestore _firestore = Firestore.instance;

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _success;
  String _userEmail;
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _sex = TextEditingController();
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Give us valid Information'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _fullName,
                    decoration: InputDecoration(
                      icon:Icon(Icons.perm_identity),
                      labelText: 'Fullname'
                    ),
                  ),
                  TextFormField(
                    controller: _sex,
                    decoration: InputDecoration(
                        icon:Icon(Icons.group),
                        labelText: 'Age'
                    ),
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.mail_outline_outlined),
                        labelText: 'Email'
                    ),
                    validator: (String value){
                      if (value.isEmpty){
                        return 'Please enter some text';
                      }else{
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.vpn_key),
                        labelText: 'Password'
                    ),
                    validator: (String value){
                      if (value.length<4) {
                        return 'Please enter some text';
                      }else{
                        return null;
                      }
                    },
                  ),

                  SizedBox(height: 20,),
                  RaisedButton(
                    onPressed: () async{
                      if (_formKey.currentState.validate()){
                        _firestore.collection("users:").add(
                          {
                            "name": _fullName.text,
                            "age": _sex.text,
                            "email": _emailController.text,
                            'password' : _passwordController.text
                          }
                        ).then((value) => print(value.documentID));
                      };
                      _register();
                    },
                    child: Text('Enter'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _register() async{
    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text)).user;
    if (user!=null) {
      setState(() {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>FirstScreen()));
        _success = true;
        _userEmail = user.email;
      });
    }
  }


  Future<void> addData(){

  }



  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


}
