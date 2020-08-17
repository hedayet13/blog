import 'package:blog/main.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: RaisedButton(
          onPressed: (){

            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>loginPage()), ModalRoute.withName('/'));
          },
          child: Text('LogOut'),
        ),
      ),
    );
  }
}
