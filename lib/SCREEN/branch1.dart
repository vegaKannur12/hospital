import 'package:flutter/material.dart';
import 'package:hospital/COMPONENTS/commoncolor.dart';
import 'package:hospital/CONTROLLER/controller.dart';
import 'package:hospital/SCREEN/dayone.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// enum WidgetMarker {
//   dayone,
//   daytwo,
//   daythree,
// }

class Singlegraph extends StatefulWidget {
  String? from_date;
  String? to_date;
  
  Singlegraph({required this.from_date,required this.to_date});

  @override
  State<Singlegraph> createState() => _SinglegraphState();

  static void dispose() {}
}

class _SinglegraphState extends State<Singlegraph> {

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
   print("from Date.......${widget.from_date}--${widget.to_date}");
    // WidgetsBinding.instance.addPostFrameCallback((_) => build(context));

    // print("init");
    // daytoday = DateFormat('yyyy-MM-dd').format(date);
    // print("today....$daytoday");
    // final yester = DateTime(date.year, date.month, date.day - 1);
    // print("yester....$yester");
    // daytoday = DateFormat('dd').format(date);
    // String month1 = DateFormat('MM').format(date).toString();
    // yesterday = DateFormat('dd').format(yester);
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
                                              child: FirstBranch(
                                                branch_id: value.branchid[0],
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
                                          child:
                                               FirstBranch(
                                                branch_id: value.branchid[1],
                                              ),
                                        ),
                                      ),
                                      Container(
                                        child: Center(
                                          child:
                                               FirstBranch(
                                                branch_id: value.branchid[2],
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
  //////////////////////////////////////////////////////////////////////

