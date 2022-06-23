import 'package:flutter/material.dart';
import 'package:hospital/COMPONENTS/commoncolor.dart';
import 'package:hospital/CONTROLLER/controller.dart';
import 'package:hospital/SCREEN/dayone.dart';
import 'package:hospital/SCREEN/daythree.dart';
import 'package:hospital/SCREEN/daytwo.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// enum WidgetMarker {
//   dayone,
//   daytwo,
//   daythree,
// }

class Branch2 extends StatefulWidget {
  @override
  State<Branch2> createState() => _Branch2State();

  static void dispose() {}
}

class _Branch2State extends State<Branch2> {
  // FirstBranch todaydata = FirstBranch();

  Daythree dayafterdata = Daythree();
  // WidgetMarker selectedWidgetMarker = WidgetMarker.dayone;
  String? _month;
  String? daytoday;
  String? yesterday;
  String? dayafter;
  DateTime date = DateTime.now();
  String? selected;
  List<String> s = [];
  String? sid;
  bool colorvisible1 = false;
  bool colorvisible2 = false;
  bool colorvisible3 = false;
  var groupBarData = 1;
  List months = [
    'jan',
    'feb',
    'mar',
    'april',
    'may',
    'jun',
    'july',
    'aug',
    'sep',
    'oct',
    'nov',
    'dec'
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final today = DateTime(date.year, date.month, date.day);
    final yester = DateTime(date.year, date.month, date.day - 1);
    final dayaf = DateTime(date.year, date.month, date.day - 2);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Consumer<Controller>(
        builder: (context, value, child) {
          print("length.........${value.branchList.length}");
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
                                      labelColor: P_Settings.wavecolor,
                                      unselectedLabelColor: Colors.black,
                                      tabs: value.branchList
                                          .map((e) => Tab(
                                                text: e['branch_code'],
                                              ))
                                          .toList()

                                      //     [
                                      //   Tab(text: 'Branch 2'),
                                      //   Tab(text: 'Branch 2'),
                                      //   Tab(text: 'Branch 3'),
                                      // ],
                                      ),
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
                                              child: dayafterdata.Daythree3(context),
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
                                          child: dayafterdata.Daythree3(context),
                                        ),
                                      ),
                                      Container(
                                        child: Center(
                                          child:
                                              dayafterdata.Daythree3(context),
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
  //////////////////////////////////////////////////////////////////////

