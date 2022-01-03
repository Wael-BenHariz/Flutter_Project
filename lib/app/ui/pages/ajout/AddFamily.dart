// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestion_de_stock/app/models/famille.dart';
import 'package:gestion_de_stock/app/services/family/familyservice.dart';
import 'package:gestion_de_stock/app/services/utility/dialog.dart';
import 'package:gestion_de_stock/app/ui/componnents/componnets.dart';
import 'package:gestion_de_stock/app/ui/pages/show/family.dart';

class AddFamily extends StatefulWidget {
  const AddFamily({Key? key}) : super(key: key);
  @override
  State<AddFamily> createState() => _MyFamilyState();
}

class _MyFamilyState extends State<AddFamily> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? nomFamille;
  var comp = Componnets();
  var familyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff1089A2),
          centerTitle: true,
          title: Text("Add Family Page"),
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                          key: _formKey,
                          child:
                              //text field for adding a family
                              Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Family Name", style: comp.myTextStyle),
                              SizedBox(height: 9),
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 6,
                                          offset: Offset(0, 2))
                                    ]),
                                height: 60,
                                child: TextFormField(
                                  keyboardType: TextInputType.name,
                                  style: TextStyle(color: Colors.black87),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 14),
                                      prefixIcon: Icon(
                                        Icons.add_box,
                                        color: Color(0xff1089A2),
                                      ),
                                      hintStyle:
                                          TextStyle(color: Colors.black38),
                                      hintText: "enter family name please !!!"),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    setState(() {
                                      nomFamille = value;
                                    });
                                  },
                                ),
                              ),

                              SizedBox(height: 20),
                              //add button

                              comp.addButtonBase(
                                context,
                                "Add",
                                () async {
                                  if (_formKey.currentState!.validate()) {
                                    bool state = await Familyservice.add(
                                        Famille(familyname: nomFamille));
                                    await MyDialog.fullDialog(
                                        context,
                                        state
                                            ? "INSERT SUCCESS"
                                            : "FAMILY EXIST !!");
                                    Familyservice.getAllFamily();
                                    if (state) {
                                      Componnets()
                                          .navigateReplace(context, Family());
                                    }
                                  }
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
