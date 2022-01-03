// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Componnets {
  var myBoxDecoration = BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          // ignore: prefer_const_literals_to_create_immutables
          colors: [
        Color(0x4d1089A2),
        Color(0x8c1089A2),
        Color(0xcc1089A2),
        Color(0xff1089A2),
      ]));
  var myTextStyle =
      TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold);

  var myTextStyle2 =
      TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);

  var myTextStyle3 = TextStyle(
      color: Colors.blueAccent[400], fontSize: 16, fontWeight: FontWeight.bold);
  var myTextStyle4 = TextStyle(
      color: Colors.blueAccent[400], fontSize: 22, fontWeight: FontWeight.bold);

  //button ajout simple

  Widget addButton(context, Widget Addwidg, String title) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 25),
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            overlayColor: MaterialStateProperty.all(Color(0xffffa500)),
            elevation: MaterialStateProperty.all(15),
            minimumSize: MaterialStateProperty.all(const Size(200, 70)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          onPressed: () {
            Componnets().navigate(context, Addwidg);
          },
          child: Text(
            title,
            style: TextStyle(
                color: Color(0xff1089A2),
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ));
  }

  // ajout btn avec base

  Widget addButtonBase(context, String title, Function base) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 25),
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            overlayColor: MaterialStateProperty.all(Color(0xffffa500)),
            elevation: MaterialStateProperty.all(15),
            minimumSize: MaterialStateProperty.all(const Size(200, 70)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          onPressed: () {
            base();
          },
          child: Text(
            title,
            style: TextStyle(
                color: Color(0xff1089A2),
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ));
  }

  myText(TextStyle textStyle, String? text) {
    return Text(text!, style: textStyle);
  }

  //create widget with same style

  Widget addTextIn(
      String name, textStyle, String hint, TextEditingController cont) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(name, style: textStyle),
        SizedBox(height: 9),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextFormField(
            controller: cont,
            keyboardType: TextInputType.name,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.add_box,
                  color: Color(0xff1089A2),
                ),
                hintStyle: TextStyle(color: Colors.black38),
                hintText: hint),
          ),
        )
      ],
    );
  }

  navigate(context, Widget goTo) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => goTo));
  }

  navigateReplace(context, Widget goTo) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => goTo));
  }
}
