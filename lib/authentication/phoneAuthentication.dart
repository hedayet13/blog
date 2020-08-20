import 'package:blog/firstScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';

class PhonePage extends StatefulWidget {
  @override
  _PhonePageState createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  String phoneNumber;
  String phoneIsoCode;
  String phone;
  void onPhoneNumberChange(String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      phone = internationalizedPhoneNumber;
      phoneNumber = number;
      phoneIsoCode = isoCode;
      print(phone);
    });
  }

  final formKey = new GlobalKey<FormState>();
  String phoneNo,verificationID;

  final _codeController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.only(left: 25,right: 25),
            child: InternationalPhoneInput(
                decoration: InputDecoration.collapsed(hintText: 'Enter your mobile number!!'),
                onPhoneNumberChange: onPhoneNumberChange,
                initialPhoneNumber: phone,
                initialSelection: "BAN",
                showCountryCodes: true,
              enabledCountries: ['+880'],
            ),
//            TextFormField(
//              keyboardType: TextInputType.phone,
//              decoration: InputDecoration(
//                hintText: 'Enter Phone Number',
//              ),
//              onChanged: (val){
//                setState(() {
//                  this.phoneNo = val;
//                });
//              },
//            ),
            ),
            Padding(padding: EdgeInsets.only(left: 100,right: 100),
            child: RaisedButton(
              child: Center(
                child: Text('Login'),
              ),
              onPressed: (){
                verifyPhone(phone , context);
              },

            ),)
          ],
        ),

      ),
    );
  }
  
  Future<bool> verifyPhone(String phone, BuildContext context) async{

    FirebaseAuth _auth = FirebaseAuth.instance;

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId){
      this.verificationID = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential)async{
          Navigator.of(context).pop();

          AuthResult result =  await _auth.signInWithCredential(credential);
          
          FirebaseUser user = result.user;
          
          if (user!= null){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>FirstScreen()));
          }else{
            print("error");
          }
          
        },
        verificationFailed: (AuthException exception){
          print(exception);
        },
        codeSent: (String verificationId , [int forceResendinToken]){
          showDialog(context: context,
          barrierDismissible: false,
          builder: (context){
            return AlertDialog(
              title:  Text('Give the code ??'),
              content: Column(
                mainAxisSize:  MainAxisSize.min,
                children: [
                  TextField(
                    controller: _codeController,
                  ),
                ],
              ),
              actions: [
                FlatButton(
                    onPressed: ()async{
                      final code  = _codeController.text.trim();
                      AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verificationID, smsCode: code);
                      AuthResult result = await _auth.signInWithCredential(credential);
                      FirebaseUser user = result.user;
                      if (user!= null){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>FirstScreen()));
                      }else{
                        print("error");
                      }

                    },
                    child: Text("Confirm"))
              ],
            );
          });
        },
        codeAutoRetrievalTimeout: autoTimeout);
  }
  
  
}
