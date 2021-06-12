import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_skill_cat/Pages/LandinPage.dart';
import 'package:flutter_app_skill_cat/Pages/SignupPage.dart';
import 'package:flutter_app_skill_cat/Static/Clrs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app_skill_cat/Service/LoginService.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController conEmail = new TextEditingController();
  TextEditingController conPass = new TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool loader = false;

  LoginService obj= new LoginService();

  final GlobalKey<FormState> validatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var _height= MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: loader
              ? Container(
            child: Center(child: CircularProgressIndicator()),
          )
              : Container(
            height: _height,
            width: _width,
            child: Form(
              key: validatorKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    width: _width,
                    child: Container(
                      //height: 40,
                      margin: EdgeInsets.only(top: 12),
                      child: TextFormField(
                        style: TextStyle(
                          //fontSize: _large ? 14 : (_medium ? 12 : 10),
                            fontSize: 14,
                            color: textColourBlack,
                            fontWeight: FontWeight.bold),
                        controller: conEmail,
                        //autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please Enter Email";
                          }
                          if (!value.contains("@")) {
                            return 'Enter Proper Email Id Format';
                          }
                          return null;
                        },
                        cursorColor: Colors.black,
                        decoration: new InputDecoration(
                          labelText: "Enter Email Id",
                          labelStyle: TextStyle(
                              color: tfBorderColour,
                              // fontSize: _large ? 14 : (_medium ? 12 : 10)
                              fontSize: 14),
                          focusedBorder: new OutlineInputBorder(
                            borderSide:
                            new BorderSide(color: tfBorderColour),
                          ),
                          enabledBorder: new OutlineInputBorder(
                            borderSide:
                            new BorderSide(color: tfBorderColour),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    //margin: EdgeInsets.only(top: 12),
                    height: 50,
                    width:_width,
                    child: Container(
                      //height: 40,
                      margin: EdgeInsets.only(top: 12),
                      child: TextFormField(
                        style: TextStyle(
                          //fontSize: _large ? 14 : (_medium ? 12 : 10),
                            fontSize: 14,
                            color: textColourBlack,
                            fontWeight: FontWeight.bold),
                        controller: conPass,
                        //autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please Enter Password";
                          }
                          if (value.length < 6) {
                            return 'Must be more than 6 character';
                          }
                          return null;
                        },
                        cursorColor: Colors.black,
                        decoration: new InputDecoration(
                          labelText: "Enter  Password",
                          labelStyle: TextStyle(
                              color: tfBorderColour,
                              // fontSize: _large ? 14 : (_medium ? 12 : 10)
                              fontSize: 14),
                          focusedBorder: new OutlineInputBorder(
                            borderSide:
                            new BorderSide(color: tfBorderColour),
                          ),
                          enabledBorder: new OutlineInputBorder(
                            borderSide:
                            new BorderSide(color: tfBorderColour),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        loader = true;
                      });
                      setState(() {
                        loader = false;
                      });

                      if(validatorKey.currentState.validate()) {

                        SharedPreferences pref= await SharedPreferences.getInstance();
                        pref.setString("email", conEmail.text.toString());
                        pref.setString("pass", conPass.text.toString());
                        pref.setString("ans", "No Data");
                        obj.registerEmail(conEmail.text.toString().trim(),
                            conPass.text.toString().trim(), context);
                      }

                    },
                    child: Container(
                      height: 50,
                      width: 250,
                      color: orange.withOpacity(0.65),
                      child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                    child: Container(
                      height: 200,
                      width: _width,
                      child: Center(child: Text("Create Account")),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
