import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:hospital/COMPONENTS/commoncolor.dart';
import 'package:intl/intl.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> with TickerProviderStateMixin {
  TabController? _tabController;
  String? daytoday;
  DateTime date = DateTime.now();

  List<Tab> myTabs = <Tab>[
    Tab(text: 'Branch1 '),
    // Tab(text: 'Branch2 '),
    // Tab(text: 'Branch3'),
    // Tab(text: 'Todays Order'),
    // Tab(text: 'Todays Collection'),
    // Tab(text: 'Todays Sale'),
    // Tab(text: 'CList'),
  ];
  @override
  void initState() {
    daytoday = DateFormat('dd').format(date);
    print(daytoday);
    _tabController = TabController(
      vsync: this,
      length: myTabs.length,
      // initialIndex: 0,
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Map<String, dynamic>>? data = [
      {'type': 'DChartPie', 'domain': 'Flutter', 'measure': 28, 'pvalue': 0.4},
      {
        'type': 'DChartBar',
        'domain': 'React Native',
        'measure': 27,
        'pvalue': 0.3
      },
      {'type': 'DChartLine', 'domain': 'Ionic', 'measure': 20, 'pvalue': 0.2},
      {'type': 'DChartPie', 'domain': 'Cordova', 'measure': 15, 'pvalue': 0.1},
    ];
    List<Map<String, dynamic>>? head = [
      {'title': 'Expence', 'total': '3000'},
      {'title': 'Eran', 'total': '2500'},
      {'title': 'Visit', 'total': '4000'},
    ];
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          bottomOpacity: 1,
          centerTitle: true,
          title: Text(
            'Company',
            style: TextStyle(color: P_Settings.wavecolor),
          ),
          bottom: TabBar(
            isScrollable: true,
            // indicator: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //     color:Colors.grey),
            indicatorColor: P_Settings.wavecolor,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 2.0,
            // indicatorSize: TabBarIndicatorSize.label,
            labelColor: Color.fromARGB(255, 58, 54, 54),

            tabs: myTabs,
            controller: _tabController,
          )),
      drawer: Drawer(
          // backgroundColor: P_Settings.wavecolor,
          ),
      // backgroundColor: Colors.grey[200],
      body: TabBarView(
        controller: _tabController,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Container(
                    height: size.height * 0.9,
                    child: ListView.builder(
                      itemCount: head.length,
                      itemBuilder: (context, index) {
                        return Column(children: [
                          ListTile(
                            title: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: P_Settings.headingColor,
                                    child: Text(
                                      daytoday!,
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),

                                  // Text(
                                  //   'Branch1',
                                  //   style: TextStyle(
                                  //       fontSize: 18,
                                  //       fontWeight: FontWeight.bold),
                                  // ),
                                ],
                              ),
                            ),
                            // tileColor: Colors.purple[200],
                          ),
                          Text(head[index]['title'],
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 179, 15, 15))),
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: AspectRatio(
                              aspectRatio: 1.2,
                              child: Stack(
                                children: [
                                  DChartPie(
                                    data: data,
                                    fillColor: (pieData, index) {
                                      switch (pieData['domain']) {
                                        case 'Flutter':
                                          return Color.fromARGB(
                                              255, 243, 212, 33);
                                        case 'React Native':
                                          return Color.fromARGB(
                                              255, 158, 68, 209);
                                        case 'Ionic':
                                          return Colors.lightBlue;
                                        default:
                                          return Colors.orange;
                                      }
                                    },
                                    donutWidth: 40,
                                    labelColor: Colors.white,
                                  ),
                                  Align(
                                      child: Text(
                                    head[index]['total'],
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 110, 9, 94),
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              height: size.height * 0.395,
                              child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: Text(
                                        "${data[index]['measure'].toString()}%"),
                                    title: Container(
                                        // width: size.width*0.9,
                                        alignment: Alignment.topCenter,
                                        margin: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${data[index]['domain'].toString()}",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey[500]),
                                            ),
                                            LinearProgressIndicator(
                                              value: data[index]['pvalue'],
                                              valueColor:
                                                  new AlwaysStoppedAnimation<
                                                          Color>(
                                                      Color.fromARGB(
                                                          255, 175, 48, 118)),
                                            ),
                                          ],
                                        )),
                                    // subtitle: Text("${data[index]['domain'].toString()}%"),
                                    // trailing:
                                    //     Text("${data[index]['measure'].toString()}%"),
                                  );
                                },
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 2,
                          ),
                        ]);
                      },

                      //     // Padding(
                      //     //   padding: EdgeInsets.all(16),
                      //     //   child: AspectRatio(
                      //     //     aspectRatio: 16 / 9,
                      //     //     child: DChartPie(
                      //     //       data: [
                      //     //         {'domain': 'Flutter', 'measure': 28},
                      //     //         {'domain': 'React Native', 'measure': 27},
                      //     //         {'domain': 'Ionic', 'measure': 20},
                      //     //         {'domain': 'Cordova', 'measure': 15},
                      //     //       ],
                      //     //       fillColor: (pieData, index) {
                      //     //         switch (pieData['domain']) {
                      //     //           case 'Flutter':
                      //     //             return Colors.blue;
                      //     //           case 'React Native':
                      //     //             return Colors.blueAccent;
                      //     //           case 'Ionic':
                      //     //             return Colors.lightBlue;
                      //     //           default:
                      //     //             return Colors.orange;
                      //     //         }
                      //     //       },
                      //     //       pieLabel: (pieData, index) {
                      //     //         return "${pieData['domain']}:\n${pieData['measure']}%";
                      //     //       },
                      //     //       labelPosition: PieLabelPosition.outside,
                      //     //       donutWidth: 20,
                      //     //     ),
                      //     //   ),
                      //     // ),
                      //   ],
                      // ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
