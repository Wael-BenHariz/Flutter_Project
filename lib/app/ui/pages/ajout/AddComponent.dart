// ignore_for_file: file_names, prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestion_de_stock/app/models/famille.dart';
import 'package:gestion_de_stock/app/models/materiel.dart';
import 'package:gestion_de_stock/app/services/family/familyservice.dart';
import 'package:gestion_de_stock/app/services/materiell/materilservice.dart';
import 'package:gestion_de_stock/app/services/utility/dialog.dart';
import 'package:gestion_de_stock/app/ui/componnents/componnets.dart';
import 'package:get_storage/get_storage.dart';

class AddComponent extends StatefulWidget {
  AddComponent({Key? key}) : super(key: key);

  @override
  _AddComponentState createState() => _AddComponentState();
}

final box = GetStorage();
final nameInput = TextEditingController();
final famInput = TextEditingController();
final quantInput = TextEditingController();
final datInput = TextEditingController();

class _AddComponentState extends State<AddComponent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? nomComp;
  int? qnt;
  DateTime? dateA;
  String? nomF;
  List<Famille>? allFamily;

  @override
  void initState() {
    super.initState();
  }

  var comp = Componnets();

  Widget compName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Componant name',
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
                hintStyle: TextStyle(color: Colors.black38),
                hintText: 'Enter the name of the component'),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter text';
              }
              setState(() {
                nomComp = value;
              });
            },
          ),
        )
      ],
    );
  }

  Widget quantity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Quantity',
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
                hintStyle: TextStyle(color: Colors.black38),
                hintText: 'Enter the quantity of the component'),
            validator: (String? value) {
              if (value == null) {
                return 'Please enter text';
              }
              setState(() {
                qnt = int.parse(value);
              });
            },
          ),
        )
      ],
    );
  }

  Widget addBtn() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 25),
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            overlayColor: MaterialStateProperty.all(Color(0xffffa500)),
            elevation: MaterialStateProperty.all(15),
            minimumSize: MaterialStateProperty.all(const Size(200, 67)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              bool state = await Materielservice.add(
                  Materiel.create(nomComp, qnt, dateA, nomF));
              state
                  ? MyDialog.fullDialog(context, "MATERIAL ADDED")
                  : MyDialog.fullDialog(context, "ERROR");
            }
          },
          child: Text(
            "Add",
            style: TextStyle(
                color: Color(0xff1089A2),
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff1089A2),
          centerTitle: true,
          title: Text("Add Component Page"),
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
                      child: Form(
                          key: _formKey,
                          child: FutureBuilder<List<Famille>>(
                            future: Familyservice.getAllFamily(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Famille>> snapshot) {
                              Widget children;
                              if (snapshot.hasData) {
                                children = DropdownButton<String>(
                                  value: nomF,
                                  icon: const Icon(
                                    Icons.arrow_circle_down_sharp,
                                    color: Colors.white,
                                  ),
                                  iconSize: 24,
                                  hint: const Text("CHOOSE FAMILY"),
                                  elevation: 16,
                                  style: comp.myTextStyle3,
                                  isExpanded: true,
                                  underline: Container(
                                    height: 2,
                                    color: Colors.white,
                                  ),
                                  items: snapshot.data!
                                      .map<DropdownMenuItem<String>>((e) {
                                    return DropdownMenuItem<String>(
                                      alignment: AlignmentDirectional.center,
                                      value: e.familyname,
                                      child: Text(e.familyname!),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      nomF = value;
                                    });
                                  },
                                );
                              } else {
                                children = const Text('No FAMILY');
                              }
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  compName(),
                                  SizedBox(height: 20),
                                  quantity(),
                                  SizedBox(height: 20),
                                  children,
                                  SizedBox(height: 20),
                                  ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white),
                                        overlayColor: MaterialStateProperty.all(
                                            Color(0xffffa500)),
                                        elevation:
                                            MaterialStateProperty.all(15),
                                        minimumSize: MaterialStateProperty.all(
                                            const Size(200, 70)),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                      ),
                                      onPressed: () async {
                                        DateTime? date =
                                            await MyDialog.dateDialog(context);
                                        setState(() {
                                          dateA = date;
                                        });
                                      },
                                      child: const Text(
                                        "Date of Purchase",
                                        style: TextStyle(
                                            color: Color(0xff1089A2),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  SizedBox(height: 20),
                                  addBtn(),
                                ],
                              );
                            },
                          ))),
                )
              ],
            )));
  }
}
