import 'dart:math';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:hospital/COMPONENTS/commoncolor.dart';
import 'package:hospital/CONTROLLER/controller.dart';
import 'package:provider/provider.dart';

class FirstBranch extends StatefulWidget {
  String branchId;
  FirstBranch({required this.branchId});

  @override
  State<FirstBranch> createState() => _FirstBranchState();
}

class _FirstBranchState extends State<FirstBranch> {
  List<Map<String, dynamic>>? colors = [
    {'color': 'red'},
    {'color': 'green'},
    {'color': 'blue'},
    {'color': 'yellow'},
    {'color': 'orange'},
  ];
  List<Map<String, dynamic>> data = [
    {
      'title': 'CASH',
      'amt': '29921.213',
      'domain': 'CREDIT',
      'measure': 290.213,
    },
    {
      'title': 'CASH',
      'domain': 'CASH',
      'measure': 290.213,
      'amt': '29921.213',
    },
    {
      'title': 'CASH',
      'amt': '29921.213',
      'domain': 'CARD',
      'measure': 400.0,
    },
  ];
  List<Map<String, dynamic>>? head = [
    {'title': 'Expence', 'total': '200'},
    {'title': 'Eran', 'total': '500'},
    {'title': 'Visit', 'total': '1000'},
  ];
  String? daytoday;
  String? yesterday;
  String? dayafter;
  DateTime date = DateTime.now();
  String? selected;
  List<String> s = [];
  String? sid;
  var groupBarData = 1;
  _getChart(String type) {
    print("chart type$type");
    switch (type) {
      case "DChartPie":
        {
          // _tabController!.animateTo((0));
          return DChartPie(
            data: data,
            fillColor:
                // (pieData, index) => Colors.purple,

                (pieData, index) {
              switch (pieData['domain']) {
                case 'CASH':
                  return Color.fromARGB(255, 243, 212, 33);
                case 'CARD':
                  return Color.fromARGB(255, 158, 68, 209);
                case 'CREDIT':
                  return Colors.pink;
                default:
                  return Colors.green;
              }
            },
            animate: true,
            donutWidth: 25,
          );
        }
      case "DChartLine":
        return DChartLine(
          data: [
            {'id': 'Line', 'data': data},
          ],
          lineColor: (lineData, index, id) => Colors.amber,
        );
      case "DChartBar":
        return DChartBar(
          data: [
            {
              'id': 'Bar',
              // 'data': data
              'data': Provider.of<Controller>(context, listen: false).collectData,
            },
          ],
          minimumPaddingBetweenLabel: 1,
          domainLabelPaddingToAxisLine: 10,
          axisLineColor: Colors.green,
          measureLabelPaddingToAxisLine: 5,
          barColor: (barData, index, id) => Colors.green,
          verticalDirection: true,
          // barValue: (barData, index) => '${barData['measure']}',
          showBarValue: true,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Consumer<Controller>(
        builder: (context, value, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Container(
                      height: size.height * 0.9,
                      child: ListView.builder(
                        itemCount: value.collectData.length,
                        itemBuilder: (context, index) {
                          return Column(children: [
                            Text(value.collectData.length!=0? value.collectData[index]['rpt'] :"",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 179, 15, 15))),
                            Column(children: [
                              Padding(
                                padding: EdgeInsets.all(16),
                                child: AspectRatio(
                                  aspectRatio: 1.5,
                                  child: Stack(
                                    children: [
                                      _getChart('DChartBar'),
                                      // Align(
                                      //     child:

                                      //     Text(
                                      //   value.collectData.length>0 ? value.collectData[index]['total']:"",
                                      //   style: TextStyle(
                                      //     fontSize: 20,
                                      //     color:
                                      //         Color.fromARGB(255, 110, 9, 94),
                                      //   ),
                                      // ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                              // AspectRatio(
                              //   aspectRatio: 16 / 9,
                              //   child: DChartBar(
                              //     measureLabelColor: P_Settings.wavecolor,
                              //     data: [
                              //       {
                              //         'id': 'Bar 1',
                              //         'data': [
                              //           {'domain': '2020', 'measure': 32},
                              //           {'domain': '2021', 'measure': 43},
                              //           {'domain': '2022', 'measure': 29},
                              //           {'domain': '2023', 'measure': 16},
                              //         ],
                              //       },
                              //       {
                              //         'id': 'Bar 2',
                              //         'data': [
                              //           {'domain': '2020', 'measure': 24},
                              //           {'domain': '2021', 'measure': 42},
                              //           {'domain': '2022', 'measure': 9},
                              //           {'domain': '2023', 'measure': 37},
                              //         ],
                              //       },
                              //       {
                              //         'id': 'Bar 3',
                              //         'data': [
                              //           {'domain': '2020', 'measure': 17},
                              //           {'domain': '2021', 'measure': 28},
                              //           {'domain': '2022', 'measure': 12},
                              //           {'domain': '2023', 'measure': 30},
                              //         ],
                              //       },
                              //     ],
                              //     minimumPaddingBetweenLabel: 1,
                              //     domainLabelPaddingToAxisLine: 16,
                              //     axisLineTick: 4,
                              //     axisLinePointTick: 4,
                              //     axisLinePointWidth: 10,
                              //     axisLineColor: Colors.green,
                              //     measureLabelPaddingToAxisLine: 40,
                              //     barColor: (barData, index, id) => id == 'Bar 1'
                              //         ? Colors.green.shade300
                              //         : id == 'Bar 2'
                              //             ? Colors.green.shade600
                              //             : Colors.green.shade900,
                              //     barValue: (barData, index) =>
                              //         '${barData['measure']}',
                              //     showBarValue: true,
                              //     barValueFontSize: 12,
                              //     barValuePosition: BarValuePosition.outside,
                              //   ),
                              // ),
                              // Padding(
                              //   padding: EdgeInsets.symmetric(vertical: 8),
                              //   child: Text(
                              //     'Year',
                              //     style: TextStyle(
                              //       fontWeight: FontWeight.bold,
                              //       color: Colors.green,
                              //     ),
                              //   ),
                              // ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  height: size.height * 0.395,
                                  child: ListView.builder(
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        // leading: Text(
                                        //     "${data[index]['measure'].toString()}%"),
                                        title: Container(
                                            // width: size.width*0.9,
                                            alignment: Alignment.topCenter,
                                            margin: EdgeInsets.all(10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Text(
                                                //   "${data[index]['domain'].toString()}",
                                                //   style: TextStyle(
                                                //       fontSize: 13,
                                                //       color: Colors.grey[500]),
                                                // ),
                                                LinearProgressIndicator(
                                                  value: data[index]['pvalue'],
                                                  // valueColor:
                                                  //     new AlwaysStoppedAnimation<
                                                  //         Color>(
                                                  //   Color.fromARGB(
                                                  //       255, 175, 48, 118),
                                                  // ),
                                                  color: Color.fromARGB(
                                                      0, 20, 255, 255),
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
                            ]),
                          ]);
                        },
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
