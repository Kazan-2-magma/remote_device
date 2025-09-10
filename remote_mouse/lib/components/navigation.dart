import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomNavigation {


   static void go(BuildContext context,Widget destination,{bool clearStack = false}){
     if(clearStack == true){
       Navigator.pushReplacement(
         context,
         MaterialPageRoute(
             builder: (context){
               return destination;
             }
         )
       );
     }else {
       Navigator.push(
           context,
           MaterialPageRoute(
               builder: (context) {
                 return destination;
               }
           )
       );
     }
   }

}