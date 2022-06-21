import 'package:flutter/material.dart';
import 'package:hospital/COMPONENTS/commoncolor.dart';
import 'package:hospital/CONTROLLER/controller.dart';
import 'package:hospital/SCREEN/dayone.dart';
import 'package:hospital/SCREEN/daythree.dart';
import 'package:hospital/SCREEN/daytwo.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'branch3.dart';

enum WidgetMarker {
  dayone,
  daytwo,
  daythree,
}

class Branch3 extends StatefulWidget {
  const Branch3({Key? key}) : super(key: key);

  @override
  State<Branch3> createState() => _Branch3State();

  static void dispose() {}
}

class _Branch3State extends State<Branch3> {
  Dayone todaydata = Dayone();
  Daytwo yesterdaydata = Daytwo();
  Daythree dayafterdata = Daythree();
  WidgetMarker selectedWidgetMarker = WidgetMarker.dayone;

  String? daytoday;
  String? yesterday;
  String? dayafter;
  DateTime date = DateTime.now();
  String? selected;
  List<String> s = [];
  String? sid;
  var groupBarData = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) => build(context));

    print("init");
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yester = DateTime(now.year, now.month, now.day - 1);
    final dayaf = DateTime(now.year, now.month, now.day - 2);

    daytoday = DateFormat('dd').format(date);
    yesterday = DateFormat('dd').format(yester);
    dayafter = DateFormat('dd').format(dayaf);
    // print("dayafter yesterday $dayafter $yesterday ");
    // print("daytotoday$daytoday");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Consumer<Controller>(
        builder: (context, value, child) {
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
                                    tabs: [
                                      Tab(text: 'Branch 1'),
                                      Tab(text: 'Branch 2'),
                                      Tab(text: 'Branch 3'),
                                    ],
                                  ),
                                ),
                                Container(
                                    height: size.height*0.75, //height of TabBarView
                                    decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5))),
                                    child: TabBarView(children: <Widget>[
                                      Container(
                                        child: Center(
                                          child: todaydata.Dayone1(context),
                                        ),
                                      ),
                                      Container(
                                        child: Center(
                                          child: yesterdaydata.Daytwo2(context),
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

