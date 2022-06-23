import 'package:flutter/material.dart';
import 'package:hospital/CONTROLLER/controller.dart';
import 'package:hospital/SCREEN/dayone.dart';
import 'package:hospital/SCREEN/dayoneMultigraph.dart';
import 'package:hospital/components/commoncolor.dart';
import 'package:provider/provider.dart';

class MultiGraph extends StatefulWidget {
  String? from_date;
  String? to_date;

  MultiGraph({required this.from_date, required this.to_date});

  @override
  State<MultiGraph> createState() => _MultiGraphState();
}

class _MultiGraphState extends State<MultiGraph> {
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Consumer<Controller>(
        builder: (context, value, child) {
          print("length..czxcx.......${value.branchList.length}");
          return Column(
            children: [
              Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      DefaultTabController(
                          length: 3, // length of tabs
                          initialIndex: 0,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Container(
                                  // color: P_Settings.bodyTabColor,
                                  child: TabBar(
                                      physics: NeverScrollableScrollPhysics(),
                                      labelColor: P_Settings.wavecolor,
                                      unselectedLabelColor: Colors.black,
                                      tabs: value.branchList
                                          .map((e) => Tab(
                                                text: e['branch_code'],
                                              ))
                                          .toList()),
                                ),
                                Container(
                                    height: size.height *
                                        0.75, //height of TabBarView
                                    decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5))),
                                    child: TabBarView(children: <Widget>[
                                      Consumer<Controller>(
                                        builder: (context, value, child) {
                                          return Container(
                                            child: Center(
                                              child: MultiDayOne(
                                                // branch_id: value.branchid[0],
                                              ),
                                              //   child: Text('Display Tab 1',
                                              //       style: TextStyle(
                                              //           fontSize: 22,
                                              //           fontWeight: FontWeight.bold)),
                                            ),
                                          );
                                        },
                                      ),
                                      Container(
                                        child: Center(
                                          child: MultiDayOne(
                                            // branch_id: value.branchid[1],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Center(
                                          child: MultiDayOne(
                                            // branch_id: value.branchid[2],
                                          ),
                                        ),
                                      ),
                                    ]))
                              ])),
                    ]),
              ),
            ],
          );
        },
      ),
    );
  }
}
