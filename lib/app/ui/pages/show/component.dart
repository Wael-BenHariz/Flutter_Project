// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestion_de_stock/app/models/famille.dart';
import 'package:gestion_de_stock/app/models/materiel.dart';
import 'package:gestion_de_stock/app/services/family/familyservice.dart';
import 'package:gestion_de_stock/app/services/materiell/materilservice.dart';
import 'package:gestion_de_stock/app/services/utility/dialog.dart';
import 'package:gestion_de_stock/app/ui/componnents/componnets.dart';
import 'package:gestion_de_stock/app/ui/pages/ajout/AddComponent.dart';

class Component extends StatelessWidget {
  const Component({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ComponentView(),
    );
  }
}

class ComponentView extends StatefulWidget {
  ComponentView({Key? key}) : super(key: key);

  @override
  _ComponentViewState createState() => _ComponentViewState();
}

class _ComponentViewState extends State<ComponentView> {
  @override
  TextEditingController textController = TextEditingController();
  String? nomF;
  var comp = Componnets();
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff1089A2),
          centerTitle: true,
          title: Text("Component Page"),
        ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: comp.myBoxDecoration,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FutureBuilder(
                                future: Familyservice.getAllFamily(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<Famille>> snapshot) {
                                  if (snapshot.hasData) {
                                    return DropdownButton<String>(
                                      value: nomF,
                                      iconSize: 24,
                                      hint: const Text("Find By family"),
                                      elevation: 16,
                                      style: comp.myTextStyle3,
                                      underline: Container(
                                        height: 2,
                                        color: Colors.blue,
                                      ),
                                      items: snapshot.data!
                                          .map<DropdownMenuItem<String>>((e) {
                                        return DropdownMenuItem<String>(
                                          alignment:
                                              AlignmentDirectional.center,
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
                                    return const Text("No Family");
                                  }
                                }),
                          ]),
                      Expanded(
                        child: FutureBuilder(
                            future: (nomF != null && nomF!.isNotEmpty)
                                ? Materielservice.getMaterialByNomF(nomF!)
                                : Materielservice.getAllMaterial(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Materiel>> projectSnap) {
                              if (projectSnap.connectionState ==
                                      ConnectionState.none ||
                                  !projectSnap.hasData) {
                                return Center(
                                    child: comp.myText(comp.myTextStyle4,
                                        "NO MATERIEL TO SHOW"));
                              }
                              return ListView.builder(
                                  itemCount: projectSnap.data!.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Card(
                                          elevation: 8,
                                          margin: const EdgeInsets.all(20),
                                          child: InkWell(
                                            onDoubleTap: () async {
                                              await MyDialog.detailMaterial(
                                                  context,
                                                  projectSnap.data![index]);
                                            },
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                ListTile(
                                                  leading: const Icon(
                                                      Icons.electrical_services,
                                                      size: 48),
                                                  title: Text(
                                                      projectSnap.data![index]
                                                          .nomMateriel!,
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                  subtitle: Text(
                                                      projectSnap
                                                          .data![index].nomF!,
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.grey)),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    TextButton(
                                                      child: Text(
                                                        'loan',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xcc1089A2),
                                                            fontSize: 20),
                                                      ),
                                                      onPressed: () async {
                                                        MyDialog
                                                            .borrowMaterialForm(
                                                                context,
                                                                projectSnap
                                                                        .data![
                                                                    index]);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  });
                            }),
                      ),
                      comp.addButton(context, AddComponent(), "add")
                    ],
                  ),
                ),
              ],
            )));
  }
}
