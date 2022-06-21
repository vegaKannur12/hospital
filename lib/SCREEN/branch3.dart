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
    Widget dayone() {
      return todaydata.Dayone1(context);
    }

    Widget daytwo() {
      return yesterdaydata.Daytwo2(context);
    }

    Widget daythree() {
      return dayafterdata.Daythree3(context);
    }

    Widget getCustomContainer() {
      print("inside switch case");
      switch (selectedWidgetMarker) {
        case WidgetMarker.dayone:
          return dayone();
        case WidgetMarker.daytwo:
          return daytwo();
        case WidgetMarker.daythree:
          return daythree();
      }
    }

    return SingleChildScrollView(
      child: Consumer<Controller>(
        builder: (context, value, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedWidgetMarker = WidgetMarker.daythree;
                              print(
                                  "selectedWidgetMarker $selectedWidgetMarker");
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            child: Text(
                              dayafter!,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedWidgetMarker = WidgetMarker.daytwo;
                              print(
                                  "selectedWidgetMarker $selectedWidgetMarker");
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[400],
                            child: Text(
                              yesterday!,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedWidgetMarker = WidgetMarker.dayone;
                              print(
                                  "selectedWidgetMarker $selectedWidgetMarker");
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: P_Settings.headingColor,
                            child: Text(
                              daytoday!,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          getCustomContainer();
                        });
                      },
                      child: Container(
                        height: size.height * 0.9,
                        child: getCustomContainer(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
  //////////////////////////////////////////////////////////////////////

