// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestion_de_stock/app/models/materiel.dart';
import 'package:gestion_de_stock/app/models/membre.dart';
import 'package:gestion_de_stock/app/services/materiell/materilservice.dart';
import 'package:gestion_de_stock/app/services/utility/dialog.dart';
import 'package:gestion_de_stock/app/ui/componnents/componnets.dart';

class Loan extends StatelessWidget {
  const Loan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoanView(),
    );
  }
}

class LoanView extends StatefulWidget {
  LoanView({Key? key}) : super(key: key);

  @override
  _LoanViewState createState() => _LoanViewState();
}

class _LoanViewState extends State<LoanView> {
  var comp = Componnets();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff1089A2),
          centerTitle: true,
          title: Text("List of Loans"),
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
                      FutureBuilder(
                          future: Materielservice.getAllMember(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Member>> projectSnap) {
                            if (projectSnap.connectionState ==
                                    ConnectionState.none ||
                                !projectSnap.hasData) {
                              return const Text("NO DATA");
                            }

                            return Expanded(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: projectSnap.data!.length,
                                    itemBuilder: (context, index) {
                                      Widget memberType;
                                      if (projectSnap.data![index].dateReturn ==
                                              null &&
                                          projectSnap.data![index].state ==
                                              null) {
                                        memberType = Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            TextButton(
                                              child: const Text(
                                                  'Return the component'),
                                              onPressed: () async {
                                                await MyDialog
                                                    .returnMaterialForm(
                                                        context,
                                                        projectSnap
                                                            .data![index]);
                                              },
                                            ),
                                            const SizedBox(width: 8),
                                          ],
                                        );
                                      } else {
                                        memberType = Column(
                                          children: <Widget>[
                                            ListTile(
                                                leading: const Icon(
                                                  Icons.date_range,
                                                  size: 30,
                                                  color: Color.fromARGB(
                                                      255, 3, 152, 252),
                                                ),
                                                title: Text(projectSnap
                                                    .data![index].dateReturn
                                                    .toString())),
                                            ListTile(
                                                leading: const Icon(
                                                  Icons.bar_chart,
                                                  size: 30,
                                                  color: Color.fromARGB(
                                                      255, 3, 152, 252),
                                                ),
                                                title: Text(projectSnap
                                                    .data![index].state!)),
                                          ],
                                        );
                                      }
                                      return Column(
                                        children: [
                                          Card(
                                            elevation: 8,
                                            margin: const EdgeInsets.all(20),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                ListTile(
                                                  leading: const Icon(
                                                    Icons.person,
                                                    size: 30,
                                                    color: Color.fromARGB(
                                                        255, 3, 152, 252),
                                                  ),
                                                  title: Text(
                                                      projectSnap.data![index]
                                                              .firstName! +
                                                          " " +
                                                          projectSnap
                                                              .data![index]
                                                              .lastName!,
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                  subtitle: Text(projectSnap
                                                      .data![index].phoneNumber
                                                      .toString()),
                                                ),
                                                FutureBuilder<Materiel>(
                                                  future: Materielservice
                                                      .getMaterialById(
                                                          projectSnap
                                                              .data![index]
                                                              .idMaterial!),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.connectionState ==
                                                            ConnectionState
                                                                .none ||
                                                        !snapshot.hasData) {
                                                      return const Text(
                                                          "ERREUR DATA BASE");
                                                    }
                                                    return ListTile(
                                                      leading: const Icon(
                                                        Icons
                                                            .electrical_services,
                                                        size: 30,
                                                        color: Color.fromARGB(
                                                            255, 3, 152, 252),
                                                      ),
                                                      title: Text(snapshot
                                                          .data!.nomMateriel!),
                                                      subtitle: Text(
                                                          "Quantity : " +
                                                              projectSnap
                                                                  .data![index]
                                                                  .quantite
                                                                  .toString()),
                                                    );
                                                  },
                                                ),
                                                memberType,
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    }));
                          })
                    ],
                  ),
                ),
              ],
            )));
  }
}
