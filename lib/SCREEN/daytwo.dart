import 'dart:math';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospital/COMPONENTS/commoncolor.dart';
import 'package:hospital/CONTROLLER/controller.dart';
import 'package:provider/provider.dart';

class SecondBranch extends StatefulWidget {
  String branchid;
  String from_date;
  String till_date;
  SecondBranch(
      {required this.branchid,
      required this.from_date,
      required this.till_date});

  @override
  State<SecondBranch> createState() => _SecondBranchState();
}

class _SecondBranchState extends State<SecondBranch> {
  List<String> chartType = ["DChartBar", "DChartPie", "DChartPie", "DChartBar"];

  String? daytoday;
  String? yesterday;
  String? dayafter;
  DateTime date = DateTime.now();
  String? selected;
  List<String> s = [];
  String? sid;
  var groupBarData = 1;
  _getChart(String type, List<Map<String, dynamic>> data) {
    print("chart type$type");
    switch (type) {
      case "DChartPie":
        {
          // _tabController!.animateTo((0));
          return DChartPie(
            data: data,
            fillColor: (pieData, index) => Colors.purple,
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
              'data': data,
            },
          ],
          axisLineColor: Colors.green,
          measureLabelPaddingToAxisLine: 5,
          barColor: (barData, index, id) => Colors.green,
          verticalDirection: true,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ScrollController _firstController = ScrollController();
    return Scrollbar(
      thumbVisibility: true,
      thickness: 10,
      radius: Radius.circular(20),
      controller: _firstController,
      child: SingleChildScrollView(
        controller: _firstController,
        scrollDirection: Axis.vertical,
        child: Consumer<Controller>(
          builder: (context, value, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Column(
                    children: [
                      Text(
                          "${value.collectData != null && value.collectData.isNotEmpty ? value.collectData[0]['rpt'] : ''}",
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 179, 15, 15))),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AspectRatio(
                          aspectRatio: 1.5,
                          child: _getChart("DChartBar", value.collectData),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      linearProgress(value.collectData, size),
                      Text(
                          "${value.countData != null && value.countData.isNotEmpty ? value.countData[0]['rpt'] : ''}",
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 179, 15, 15))),
                      AspectRatio(
                        aspectRatio: 1.5,
                        child: _getChart("DChartPie", value.countData),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      linearProgress(value.countData, size),
                      Text(
                          "${value.departmentData != null && value.departmentData.isNotEmpty ? value.departmentData[0]['rpt'] : ''}",
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 179, 15, 15))),
                      AspectRatio(
                        aspectRatio: 1.5,
                        child: _getChart("DChartPie", value.departmentData),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      linearProgress(value.collectData, size),
                      Text("SERVICE GROUP",
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 179, 15, 15))),
                      AspectRatio(
                        aspectRatio: 1.5,
                        child: _getChart("DChartPie", value.servicegroupData),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      linearProgress(value.servicegroupData, size),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget linearProgress(List<Map<String, dynamic>> list, Size size) {
    ;
    print("cjxzj-----$list");
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        height: size.height * 0.36,
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return ListTile(
                // leading: Text("${list[index]['measure'].toString()}%"),
                title: Row(
              children: [
                Container(
                    width: size.width * 0.2,
                    child: Text(
                      "${list[index]['measure'].toString()}",
                      style: TextStyle(fontSize: 12),
                    )),
                SizedBox(
                  width: size.width * 0.03,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${list[index]['domain'].toString()}",
                      style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                    ),
                    Container(
                      width: size.width * 0.6,
                      child: LinearProgressIndicator(
                        value: list[index]['per'],
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Color.fromARGB(255, 131, 7, 7)),
                        color: Color.fromARGB(0, 20, 255, 255),
                      ),
                    ),
                  ],
                ),
              ],
            ));
          },
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////
