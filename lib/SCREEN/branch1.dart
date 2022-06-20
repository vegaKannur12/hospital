import 'package:flutter/material.dart';
import 'package:hospital/COMPONENTS/commoncolor.dart';
import 'package:hospital/SCREEN/dayone.dart';
import 'package:hospital/SCREEN/daythree.dart';
import 'package:hospital/SCREEN/daytwo.dart';
import 'package:intl/intl.dart';

enum WidgetMarker {
  dayone,
  daytwo,
  daythree,
}

class Branch1 extends StatefulWidget {
  const Branch1({Key? key}) : super(key: key);

  @override
  State<Branch1> createState() => _Branch1State();

  static void dispose() {}
}

class _Branch1State extends State<Branch1> {
  Dayone todaydata = Dayone();
  Daytwo yesterdaydata = Daytwo();
  Daythree dayafterdata = Daythree();
  WidgetMarker selectedWidgetMarker = WidgetMarker.dayone;
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
    // WidgetsBinding.instance.addPostFrameCallback((_) => build(context));

    // print("init");
    final today = DateTime(date.year, date.month, date.day);
    final yester = DateTime(date.year, date.month, date.day - 1);
    final dayaf = DateTime(date.year, date.month, date.day - 2);

    daytoday = DateFormat('dd').format(date);
    String month = DateFormat('MM').format(date).toString();
    yesterday = DateFormat('dd').format(yester);
    dayafter = DateFormat('dd').format(dayaf);
    // print("dayafter yesterday $dayafter $yesterday ");

    /////////// month name ////////////////////
    var someDateTime = new DateTime.now();
    var mon = someDateTime.month;
    _month = months[mon - 1];
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
      child: Column(
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
                          colorvisible2=false;
                          colorvisible1=!colorvisible1;
                          selectedWidgetMarker = WidgetMarker.daythree;
                          print("selectedWidgetMarker $selectedWidgetMarker");
                          
                        });
                      },
                      child: Column(
                        children: [
                          Text(_month!,
                              style: TextStyle(color: Colors.grey[200])),
                          CircleAvatar(
                            backgroundColor: colorvisible1? P_Settings.headingColor:Colors.grey[200],
                            child: Text(
                              dayafter!,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          colorvisible1=false;
                          colorvisible2=!colorvisible2;
                          selectedWidgetMarker = WidgetMarker.daytwo;
                          print("selectedWidgetMarker $selectedWidgetMarker");
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            _month!,
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                          CircleAvatar(
                            backgroundColor: colorvisible2? P_Settings.headingColor:Colors.grey[400],
                            child: Text(
                              yesterday!,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          colorvisible1=false;
                          colorvisible2=false;
                          colorvisible3=!colorvisible3;
                          selectedWidgetMarker = WidgetMarker.dayone;
                          print("selectedWidgetMarker $selectedWidgetMarker");
                        });
                      },
                      child: Column(
                        children: [
                          Text(_month!),
                          CircleAvatar(
                            backgroundColor:colorvisible3||colorvisible1==true||colorvisible2==true? Colors.grey[200]: P_Settings.headingColor,
                            child: Text(
                              daytoday!,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ],
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
      ),
    );
  }
}
  //////////////////////////////////////////////////////////////////////

