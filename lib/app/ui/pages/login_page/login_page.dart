// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestion_de_stock/app/ui/componnents/componnets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginPageView(),
    );
  }
}

class LoginPageView extends StatefulWidget {
  const LoginPageView({Key? key}) : super(key: key);

  @override
  _LoginPageViewState createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  GetStorage box = GetStorage();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwardController = TextEditingController();
  var comp = Componnets();
  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: comp.myTextStyle2,
        ),
        SizedBox(height: 10),
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
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.email,
                  color: Color(0xff1089A2),
                ),
                hintStyle: TextStyle(color: Colors.black38),
                hintText: 'Enter your Email Adress'),
          ),
        )
      ],
    );
  }

  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: comp.myTextStyle2,
        ),
        SizedBox(height: 10),
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
          child: TextField(
            obscureText: true,
            obscuringCharacter: "*",
            controller: passwardController,
            enabled: true,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Color(0xff1089A2),
                ),
                hintStyle: TextStyle(color: Colors.black38),
                hintText: 'Enter your Password'),
          ),
        )
      ],
    );
  }

  Widget buildLoginBtn() {
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
          onPressed: () => validform(),
          child: Text(
            "LOGIN",
            style: TextStyle(
                color: Color(0xff1089A2),
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    box.writeIfNull("mail", "mail");
    box.writeIfNull("password", "123456");
    box.writeIfNull("logged", false);
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: comp.myBoxDecoration,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        comp.myText(comp.myTextStyle, "sign in"),
                        SizedBox(height: 50),
                        buildEmail(),
                        SizedBox(height: 20),
                        buildPassword(),
                        SizedBox(height: 20),
                        buildLoginBtn(),
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }

  validform() {
    String mail = emailController.text;
    String passowrd = passwardController.text;
    String mailBox = box.read("mail");
    String passowrdBox = box.read("password");
    return (mail == mailBox && passowrd == passowrdBox)
        ? {Get.offAndToNamed("/"), box.write("logged", true)}
        : Get.snackbar("erorr", "mail or passorwd wrong ",
            backgroundColor: Colors.red[600], snackPosition: SnackPosition.TOP);
  }
}
