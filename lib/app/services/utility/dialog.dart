// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestion_de_stock/app/models/materiel.dart';
import 'package:gestion_de_stock/app/models/membre.dart';
import 'package:gestion_de_stock/app/services/materiell/materilservice.dart';
import 'package:gestion_de_stock/app/ui/componnents/componnets.dart';

var comp = Componnets();

class MyDialog {
  static Future<void> fullDialog(BuildContext context, String message) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("MESSAGE"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              elevation: 16,
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[Text(message)],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('OK'),
                ),
              ]);
        });
  }

  static Future<DateTime?> dateDialog(BuildContext context) {
    return showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
          confirmText: "Procced",
        );
      },
    );
  }

  static Future<void> detailMaterial(BuildContext context, Materiel mat) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Color(0x8c1089A2),
              title: Center(
                  child: Text(
                mat.nomMateriel!,
                style: comp.myTextStyle4,
              )),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              elevation: 16,
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text("family : " + mat.nomF!, style: comp.myTextStyle2),
                    Text("Quantity : " + mat.quantite.toString(),
                        style: comp.myTextStyle2),
                    Text("Date of Purchase : " + mat.dateAcqui.toString(),
                        style: comp.myTextStyle2)
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('OK'),
                ),
              ]);
        });
  }

  static Future<void> borrowMaterialForm(BuildContext context, Materiel mat) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String? firstName;
    String? lastName;
    String? phoneNumber;
    String? quantite;
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          if (mat.quantite! < 1) {
            return const AlertDialog(
              content: Text("No Quatity left"),
            );
          }
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Center(
                  child: Text(mat.nomMateriel!, style: comp.myTextStyle4)),
              backgroundColor: Color(0x8c1089A2),
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.name,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.add_box,
                              color: Color(0xff1089A2),
                            ),
                            hintStyle: TextStyle(color: Colors.white),
                            hintText: 'First name'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'you must enter your first name';
                          }
                          setState(() {
                            firstName = value;
                          });
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.add_box,
                              color: Color(0xff1089A2),
                            ),
                            hintStyle: TextStyle(color: Colors.white),
                            hintText: 'Last name'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'you must enter your last name';
                          }
                          setState(() {
                            lastName = value;
                          });
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.add_box,
                              color: Color(0xff1089A2),
                            ),
                            hintStyle: TextStyle(color: Colors.white),
                            hintText: 'Phone Number'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'you must enter your phone number';
                          }
                          setState(() {
                            phoneNumber = value;
                          });
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.add_box,
                              color: Color(0xff1089A2),
                            ),
                            hintStyle: TextStyle(color: Colors.white),
                            hintText: 'quantity'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'you must enter meterial quantity';
                          }

                          if (int.parse(value) > mat.quantite!) {
                            return 'max quantity is ' + mat.quantite.toString();
                          }
                          setState(() {
                            quantite = value;
                          });
                        },
                      ),
                    ],
                  )),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      bool state = await Materielservice.borrowMaterial(
                          Member(
                              id: null,
                              firstName: firstName,
                              lastName: lastName,
                              phoneNumber: int.parse(phoneNumber!),
                              idMaterial: mat.id,
                              quantite: int.parse(quantite!),
                              state: null,
                              dateReturn: null),
                          mat);
                      if (state) {
                        Navigator.pop(context, 'Cancel');
                      }
                    }
                  },
                  child: const Text('Borrow'),
                ),
              ],
            );
          });
        });
  }

  static Future<void> returnMaterialForm(BuildContext context, Member mem) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    DateTime? dateR;
    String? etat;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              scrollable: false,
              backgroundColor: Color(0x8c1089A2),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 16,
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      DropdownButton<String>(
                        value: etat,
                        iconSize: 24,
                        hint: Text("Enter State", style: comp.myTextStyle3),
                        style: comp.myTextStyle3,
                        underline: Container(
                          height: 2,
                          color: Colors.blue,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            etat = newValue!;
                          });
                        },
                        items: <String>[
                          'endommagé',
                          'gravement endomagé',
                          'intact'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            DateTime? date = await MyDialog.dateDialog(context);
                            setState(() {
                              dateR = date;
                            });
                          },
                          child: const Text("Return Date")),
                    ],
                  )),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      mem.state = etat;
                      mem.dateReturn = dateR;
                      bool state = await Materielservice.returnBorrow(mem);
                      if (state) {
                        Navigator.pop(context, 'Cancel');
                      }
                    }
                  },
                  child: const Text('confirm'),
                ),
              ],
            );
          });
        });
  }
}
