
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingService{

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

   uploadRecord(String email , pass, polynomial) async {

     String str=polynomial;// "1x^0+2x^1+3x^2+5";
     String newstr="";

     bool flag;

     var parts = str.split('+');

     for(int i=0;i<parts.length;i++) {
       if (parts[i].contains("x^") || parts[i].contains("x")){
         var spl = parts[i].split("x^");
         print(parts[i]);
         print(spl[0] + "  " + spl[1]);

         int pow, mul, firstnum;

         firstnum = int.parse(spl[0].toString()) *
             int.parse(spl[1].toString());
         pow = int.parse(spl[1].toString()) - 1;
         if (pow < 0) {
           pow = 0;
         } else {
           newstr =
               newstr + firstnum.toString() + "x^" + pow.toString();
         }

         if (i < parts.length - 1) {
           if(newstr.isNotEmpty)
             newstr = newstr + "+";
         }

       }
     }
     if(newstr.contains("+", newstr.length-1)){
       newstr=newstr.substring(0,newstr.length-1);
       print("new string is abc" + newstr.substring(0,newstr.length-1));
     }
     else
       print("new string is" + newstr);

     SharedPreferences pref= await SharedPreferences.getInstance();
     pref.setString("ans", newstr);

    Map<String, String> map = new HashMap();
    map = {
      "Email": email,
      "Passwrod" :pass,
      "Polynomial":polynomial,
      "Derivative":newstr
    };


    await firestore
        .collection("PolynomialRecords")
        .doc()
        .set(map)
        .whenComplete(() => {
      print("data is uploaded"),
      flag=true,

    })
        .onError((error, stackTrace) => {
      print("we got some error"),
      print("data is not updates"),
      flag =false,
    });
     return flag;
  }


}