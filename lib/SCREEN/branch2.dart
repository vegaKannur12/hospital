import 'package:flutter/material.dart';
import 'package:hospital/COMPONENTS/commoncolor.dart';
import 'package:hospital/CONTROLLER/controller.dart';
import 'package:hospital/SCREEN/dayone.dart';
import 'package:hospital/SCREEN/daythree.dart';
import 'package:hospital/SCREEN/daytwo.dart';
import 'package:hospital/SCREEN/daytwo.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

enum WidgetMarker {
  dayone,
  daytwo,
  daythree,
}

class Branch2 extends StatefulWidget {
  const Branch2({Key? key}) : super(key: key);

  @override
  State<Branch2> createState() => _Branch2State();

  static void dispose() {}
}

class _Branch2State extends State<Branch2> {
  // Dayone todaydata = Dayone();
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
  bool colorvisible1 = false;
  bool colorvisible2 = false;
  bool colorvisible3 = false;
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
                                    // labelColor: Colors.green,
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
                                          child: FirstBranch(),
                                        //   child: Text('Display Tab 1',
                                        //       style: TextStyle(
                                        //           fontSize: 22,
                                        //           fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                      Container(
                                        child: Center(
                                          child: yesterdaydata.Daytwo2(context),
                                        ),
                                      ),
                                      Container(
                                        child: Center(
                                          child: dayafterdata.Daythree3(context),
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

