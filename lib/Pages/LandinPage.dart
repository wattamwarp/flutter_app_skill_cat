import 'package:flutter/material.dart';
import 'package:flutter_app_skill_cat/Service/LandingService.dart';
import 'package:flutter_app_skill_cat/Static/Clrs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  TextEditingController conPolynomial = new TextEditingController();

  LandingService obj= new LandingService();
  String prevAns="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences pref= await SharedPreferences.getInstance();
    setState(() {
      prevAns = pref.getString("ans");
    });

  }

  @override
  Widget build(BuildContext context) {
    var _height= MediaQuery.of(context).size.height;
    var _width =MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: _height,
          width: _width,
          child: Column(
            children: [
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
                    controller: conPolynomial,
                    //autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please Enter Polynomial";
                      }
                      if (value.length < 6) {
                        return 'Must be more than 6 character';
                      }
                      return null;
                    },
                    cursorColor: Colors.black,
                    decoration: new InputDecoration(
                      labelText: "Enter Polynomial",
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
                  print("button pressed");

                  SharedPreferences pref= await SharedPreferences.getInstance();
                  String email ,pass;
                  email= pref.getString("email");
                  pass= pref.getString("pass");
               bool data=await obj.uploadRecord(email, pass, conPolynomial.text.toString());
               if(data){
                 setState(() {
                   conPolynomial.clear();
                   prevAns = pref.getString("ans");
                 });

               }
               print("the data is "+data.toString());

                },
                child: Container(
                  height: 50,
                  width: 200,
                  color: orange,
                  child: Center(child: Text("submit")),
                ),
              ),
              Container(
                width: _width -26,
                child: Center(child: Text("previous polynomia Answer/Derivative is")),
              ),
              Container(
                width: _width -26,
                child: Center(child: Text(prevAns)),
              ),

              Container(

                margin: EdgeInsets.only(top: 100),
                child: Text("in this i have not added any validations", style: TextStyle(
                  color: Colors.red
                ),),
              ),
              Container(

                child: Text("it will give only first derivative", style: TextStyle(
                    color: Colors.red
                ),),

              ),

              Container(

                child: Text("it took me 2.15 mins", style: TextStyle(
                    color: Colors.red
                ),),

              ),

            ],
          ),
        ),
      ),
    );
  }
}
