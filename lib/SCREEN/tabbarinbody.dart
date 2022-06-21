import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospital/SCREEN/branch1.dart';
import 'package:hospital/SCREEN/branch2.dart';
import 'package:hospital/SCREEN/branch3.dart';

import '../COMPONENTS/commoncolor.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  String menu_index = "1";
  TabController? _tabController;
  String? daytoday;
  DateTime date = DateTime.now();
  List<Tab> myTabs = <Tab>[
    Tab(text: 'Today '),
    Tab(text: 'Yesterday'),
    Tab(text: '')
  ];
  @override
  void initState() {
    _tabController = TabController(
      vsync: this,
      length: myTabs.length,
      // initialIndex: 0,
    );
    _tabController!.addListener(() {
      setState(() {
        _selectedIndex = _tabController!.index;
        menu_index = _tabController!.index.toString();
      });
      print("Selected Index: " + _tabController!.index.toString());
    });
    // TODO: implement initState
    super.initState();
  }

  _getBranch(String pos) {
    switch (pos) {
      case "0":
        {
          // _tabController!.animateTo((0));
          return Branch1();
        }
      case "1":
        return Branch2();
      case "2":
        return Branch3();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        backgroundColor: P_Settings.bodyTabColor,
        elevation: 0,
        title: Text(
          'Company Name',
          style: TextStyle(color: Colors.white,fontSize: 18),
        ),
        bottom: TabBar(
          isScrollable: true,
          indicatorColor: P_Settings.wavecolor,
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
