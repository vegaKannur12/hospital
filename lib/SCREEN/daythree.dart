import 'dart:math';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';

class Daythree {
  List<Map<String, dynamic>> colors = [
    {'color': 'Color.fromRGBO(75, 135, 185, 1)'},
    {'color': 'Color.fromRGBO(192, 108, 132, 1)'},
    // {'color': 'Color.fromRGBO(246, 114, 128, 1)'},
    // {'color': 'Color.fromRGBO(248, 177, 149, 1)'},
    // {'color': 'Color.fromRGBO(116, 180, 155, 1)'}
  ];
  List<Map<String, dynamic>> data = [
    {
      'type': 'DChartPie',
      'domain': 'Flutter',
      'measure': 20,
      'pvalue': 0.2,
    },
    {
      'type': 'DChartBar',
      'domain': 'React Native',
      'measure': 84,
      'pvalue': 0.3,
    },
    {
      'type': 'DChartLine',
      'domain': 'Ionic',
      'measure': 27,
      'pvalue': 0.7,
    },
    {'type': 'DChartBar', 'domain': 'Cordova', 'measure': 17, 'pvalue': 0.4},
  ];
  List<Map<String, dynamic>>? head = [
    {'title': 'Expence', 'total': '5000'},
    {'title': 'Eran', 'total': '500'},
    {'title': 'Visit', 'total': '100'},
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
            fillColor: (pieData, index) {
              switch (pieData['domain']) {
                case 'Flutter':
                  return Color.fromARGB(255, 243, 212, 33);
                case 'React Native':
                  return Color.fromARGB(255, 158, 68, 209);
                case 'Ionic':
                  return Colors.pink;
                default:
                  return Colors.green;
              }
            },
            animate: true,
            donutWidth: 40,
          );
        }
      // case "DChartLine":
      //   return DChartLine(
      //       data: data, lineColor: (lineData, index, id) => Colors.amber);
      // case "DChartBar":
      //   return DChartBar(
      //       barColor: (barData, index, id) => Colors.green, data: data);
    }
  }

  @override
  @override
  Widget Daythree3(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Container(
                  height: size.height * 0.9,
                  child: ListView.builder(
                    itemCount: head!.length,
                    itemBuilder: (context, index) {
                      return Column(children: [
                        Text(head![index]['title'],
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 179, 15, 15))),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: AspectRatio(
                            aspectRatio: 1.2,
                            child: Stack(
                              children: [
                                _getChart('DChartPie'),
                                Align(
                                    child: Text(
                                  head![index]['total'],
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

