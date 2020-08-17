
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class SignUpPage extends StatelessWidget {
  final String fullname;
  final String email;
  final String age;
  final String password;

  SignUpPage(this.fullname,this.email,this.age,this.password);

  @override
  Widget build(BuildContext context) {

    Firestore.instance.collection('users').document()
    .setData({'full_name':'full_name','email':'email','age':'age','password':'password'});

    CollectionReference users =Firestore.instance.collection('users');
    Future<void> addUser(){

      return users.add({
        'full_name':fullname,
        'email':email,
        'age': age,
        'password':password
      })
      .then((value) => print("user Added"))
      .catchError((e)=>print("Failed"));

    }

//    return StreamBuilder<QuerySnapshot>(
//        stream: Firestore.instance.collection('users').snapshots(),
//        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
//          if (snapshot.hasError)
//            return new Text('Error: ${snapshot.error}');
//          switch(snapshot.connectionState){
//            case ConnectionState.waiting:return new Text('Loading');
//            default:
//              return new ListView(
//                children: snapshot.data.documents.map((DocumentSnapshot document){
//                  return new ListTile(
//                    title: new,
//                  )
//                })
//              );
//          }
//        });


    return Scaffold(
      appBar: AppBar(
        title: Text('Give us valid Information'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_box),
                    labelText: 'Full Name'
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      icon: Icon(Icons.recent_actors),
                      labelText: 'Age'
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      icon: Icon(Icons.mail_outline_outlined),
                      labelText: 'Email'
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      icon: Icon(Icons.vpn_key),
                      labelText: 'Password'
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      icon: Icon(Icons.vpn_key_sharp),
                      labelText: 'Confirm Password'
                  ),
                ),
                SizedBox(height: 20,),
                RaisedButton(
                    onPressed: (){},
                  child: Text('Enter'),
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
