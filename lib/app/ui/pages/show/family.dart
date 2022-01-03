// ignore_for_file: prefer_const_constructors, avoid_print, unnecessary_new, deprecated_member_use, prefer_const_constructors_in_immutables, override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestion_de_stock/app/models/famille.dart';
import 'package:gestion_de_stock/app/services/family/familyservice.dart';
import 'package:gestion_de_stock/app/ui/componnents/componnets.dart';
import 'package:gestion_de_stock/app/ui/pages/ajout/AddFamily.dart';

class Family extends StatelessWidget {
  const Family({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FamilyView(),
    );
  }
}

class FamilyView extends StatefulWidget {
  FamilyView({Key? key}) : super(key: key);

  @override
  _FamilyViewState createState() => _FamilyViewState();
}

class _FamilyViewState extends State<FamilyView> {
  @override
  var comp = Componnets();

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff1089A2),
          centerTitle: true,
          title: Text("Family Page"),
        ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: comp.myBoxDecoration,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        comp.addButton(context, AddFamily(), "ADD"),
                        FutureBuilder(
                            future: Familyservice.getAllFamily(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Famille>> projectSnap) {
                              if (projectSnap.connectionState ==
                                      ConnectionState.none ||
                                  !projectSnap.hasData) {
                                return const Text("NO DATA");
                              }
                              return SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize
                                      .min, // Use children total size
                                  children: [
                                    ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: projectSnap.data!.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              Card(
                                                elevation: 8,
                                                margin:
                                                    const EdgeInsets.all(10),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    ListTile(
                                                      leading: const Icon(
                                                        Icons.category_rounded,
                                                        size: 35,
                                                        color:
                                                            Color(0xffffa500),
                                                      ),
                                                      title: Text(
                                                          projectSnap
                                                              .data![index]
                                                              .familyname!,
                                                          style: const TextStyle(
                                                              color: Color(
                                                                  0xffffa500),
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        })
                                  ],
                                ),
                              );
                            })
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
