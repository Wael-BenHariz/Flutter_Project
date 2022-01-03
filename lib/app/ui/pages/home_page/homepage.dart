// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestion_de_stock/app/ui/componnents/componnets.dart';
import 'package:gestion_de_stock/app/ui/pages/login_page/login_page.dart';
import 'package:gestion_de_stock/app/ui/pages/show/component.dart';
import 'package:gestion_de_stock/app/ui/pages/show/family.dart';
import 'package:gestion_de_stock/app/ui/pages/show/loan.dart';

import 'package:get_storage/get_storage.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePageView(),
    );
  }
}

class HomePageView extends StatefulWidget {
  HomePageView({Key? key}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final box = GetStorage();
  var comp = Componnets();

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff1089A2),
          centerTitle: true,
          title: Text("Home Page"),
        ),
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
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            child: Image.asset(
                          'lib/images/logo.png',
                          height: 100.0,
                        )),
                        comp.addButton(context, Family(), "Family"),
                        comp.addButton(context, Component(), "Component"),
                        comp.addButton(context, Loan(), "Loans"),
                        comp.addButton(context, LoginPage(), "logout")
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
