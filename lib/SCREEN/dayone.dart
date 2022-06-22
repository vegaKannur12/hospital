import 'dart:math';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:hospital/COMPONENTS/commoncolor.dart';
import 'package:hospital/CONTROLLER/controller.dart';
import 'package:provider/provider.dart';

class FirstBranch extends StatefulWidget {
  const FirstBranch({Key? key}) : super(key: key);

  @override
  State<FirstBranch> createState() => _FirstBranchState();
}

class _FirstBranchState extends State<FirstBranch> {
  List<String> chartType = ["DChartBar", "DChartPie", "DChartPie", "DChartBar"];
  List<Map<String, dynamic>>? colors = [
    {'color': 'red'},
    {'color': 'green'},
    {'color': 'blue'},
    {'color': 'yellow'},
    {'color': 'orange'},
  ];
  List<Map<String, dynamic>> data = [
    {
      'domain': 'Flutter',
      'measure': 50,
      'pvalue': 0.3,
      'color': 0xffb74093,
    },
    {
      'domain': 'React Native',
      'measure': 81,
      'pvalue': 0.3,
      'color': 0xffb74093
    },
    {'domain': 'Ionic', 'measure': 27, 'pvalue': 0.1, 'color': 0xffb74093},
    {'domain': 'Cordova', 'measure': 17, 'pvalue': 0.4, 'color': 0xffb74093},
  ];
  List<Map<String, dynamic>>? head = [
    {'title': 'COLLECTION', 'total': '200'},
    {'title': 'COUNT', 'total': '500'},
    {'title': 'DEPARTEMENT', 'total': '1000'},
    {'title': 'SERVICE GROUP', 'total': '1000'},
  ];
  String? daytoday;
  String? yesterday;
  String? dayafter;
  DateTime date = DateTime.now();
  String? selected;
  List<String> s = [];
  String? sid;
  var groupBarData = 1;
  _getChart(
    String type,List<Map<String, dynamic>> data
  ) {
    print("chart type$type");
    switch (type) {
      case "DChartPie":
        {
          // _tabController!.animateTo((0));
          return DChartPie(
            data: data,
            fillColor: (pieData, index) => Colors.purple,
            animate: true,
            donutWidth: 20,
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
              'data': data,
            },
          ],
          axisLineColor: Colors.green,
          measureLabelPaddingToAxisLine: 16,
          barColor: (barData, index, id) => Colors.green,
          verticalDirection: true,
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
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  children: [
                    Text("COLLECTION",
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 179, 15, 15))),
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: _getChart("DChartBar",value.collectData),
                    ),
                    linearProgress(data, size),
                    Text("COUNT",
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 179, 15, 15))),

                    AspectRatio(
                      aspectRatio: 1.5,
                      child: _getChart("DChartPie",value.collectData),
                    ),
                    linearProgress(data, size),
                    Text("DEPARTEMENT",
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 179, 15, 15))),

                    AspectRatio(
                      aspectRatio: 1.5,
                      child: _getChart("DChartPie",value.collectData),
                    ),
                    linearProgress(data, size),
                    Text("SERVICE GROUP",
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 179, 15, 15))),

                    AspectRatio(
                      aspectRatio: 1.5,
                      child: _getChart("DChartBar",value.collectData),
                    ),
                    linearProgress(data, size),
                    
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget linearProgress(List<Map<String, dynamic>> list, Size size) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        height: size.height * 0.36,
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Text("${data[index]['measure'].toString()}%"),
              title: Container(
                  // width: size.width*0.9,
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${data[index]['domain'].toString()}",
                        style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                      ),
                      LinearProgressIndicator(
                        value: data[index]['pvalue'],
                        // valueColor:
                        //     new AlwaysStoppedAnimation<
                        //         Color>(
                        //   Color.fromARGB(
                        //       255, 175, 48, 118),
                        // ),
                        color: Color.fromARGB(0, 20, 255, 255),
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
    );
  }
}

//////////////////////////////////////////////////////////////////////
