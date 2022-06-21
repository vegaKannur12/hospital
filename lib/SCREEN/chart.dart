import 'package:flutter/material.dart';
import 'package:hospital/COMPONENTS/commoncolor.dart';
import 'package:hospital/SCREEN/branch1.dart';
import 'package:hospital/SCREEN/branch2.dart';
import 'package:hospital/SCREEN/branch3.dart';
// import 'package:google_fonts/google_fonts.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  String menu_index = "1";
  TabController? _tabController;
  String? daytoday;
  DateTime date = DateTime.now();
  List<Tab> myTabs = <Tab>[
    Tab(text: 'Branch1 '),
    Tab(text: 'Branch2'),
    Tab(
      text: 'Branch3',
    )
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          bottomOpacity: 1,
          // centerTitle: true,
          title: Text(
            'Company',
            // style: GoogleFonts.actor(),
          ),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: P_Settings.wavecolor,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 2.0,
            // indicatorSize: TabBarIndicatorSize.label,
            labelColor: Color.fromARGB(255, 58, 54, 54),

            tabs: myTabs,
            controller: _tabController,
          )),
      drawer: Drawer(),
      // backgroundColor: Colors.grey[200],
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
