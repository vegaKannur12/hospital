import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hospital/COMPONENTS/selectDate.dart';
import 'package:hospital/CONTROLLER/controller.dart';
import 'package:hospital/SCREEN/3_todaychart.dart';
import 'package:hospital/SCREEN/3.3_moth_graph.dart';
import 'package:hospital/SCREEN/3.2_day_muldata.dart';
import 'package:hospital/db_helper.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../COMPONENTS/commoncolor.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List cname = [];
  int _selectedIndex = 0;
  CustomDate datedata = CustomDate();
  String menu_index = "0";
  TabController? _tabController;
  String? daytoday;
  String? cid;
  DateTime date = DateTime.now();
  List<Tab> myTabs = <Tab>[
    Tab(text: 'Today '),
    Tab(text: 'Last 3 Days'),
    Tab(text: 'Last 3 Months'),
  ];
  @override
  void initState() {
    _tabController = TabController(
      vsync: this,
      length: myTabs.length,
      initialIndex: 0,
    );
    _tabController!.addListener(() {
      setState(() {
        _selectedIndex = _tabController!.index;
        menu_index = _tabController!.index.toString();
      });
      print("Selected Index: " + _tabController!.index.toString());
    });

    daytoday = DateFormat('yyyy-MM-dd').format(date);
    _tabController!.animateTo((0));
    print("date $daytoday");
    getCid();
    // TODO: implement initState
    super.initState();
  }

  getCid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cid = prefs.getString("cid");
    // cname = await OrderAppDB.instance.selectCompany(cid!);
    print("cis$cname");
  }

  _getBranch(String pos) {
    print("post----$pos");

    switch (pos) {
      case "0":
        {
          // _tabController!.animateTo((0));
          datedata.getDate(0);
          print("to day-----${datedata.fromdt}---${datedata.todt}");

          return Singlegraph(
              from_date: datedata.fromdt, to_date: datedata.todt);
        }
      case "1":
        datedata.getDate(1);
        print("last 2 days-----${datedata.fromdt}---${datedata.todt}");
        return MultiGraph(from_date: datedata.fromdt, to_date: datedata.todt);
      case "2":
        datedata.getDate(2);
        print("last month-----${datedata.fromdt}---${datedata.todt}");

        return MonthwiseGraph(
            from_date: datedata.fromdt, to_date: datedata.todt);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: P_Settings.headingColor,
        elevation: 0,
        title: Consumer<Controller>(
          builder: (context, value, child) {
            if (value.cn == null) {
              return SpinKitThreeBounce(
                color: Colors.white,
              );
            } else {
             return  Text(value.cn.toString());
            }
          },
        ),

        //  cname == null
        //     ? SpinKitThreeBounce()
        //     : Text(
        //         '',
        //         // cname[0]["cnme"].toString(),
        //         style: TextStyle(color: Colors.white, fontSize: 18),
        //       ),
        bottom: TabBar(
          isScrollable: true,
          indicatorColor: P_Settings.headingColor,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 2.0,
          // indicatorSize: TabBarIndicatorSize.label,
          labelColor: Colors.white,

          tabs: myTabs,
          controller: _tabController,
        ),
      ),
      // drawer: Drawer(),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: myTabs.map((Tab tab) {
          final String label = tab.text!.toLowerCase();
          return Center(
            child: SingleChildScrollView(
              child: Container(
                child: _getBranch(
                  menu_index,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
