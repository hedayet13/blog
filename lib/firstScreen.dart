import 'package:blog/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Its'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: (){
            FirebaseAuth.instance.signOut();
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>loginPage()), ModalRoute.withName('/'));
          },
          child: Text('LogOut'),
        ),
      ),
    );
  }
}
