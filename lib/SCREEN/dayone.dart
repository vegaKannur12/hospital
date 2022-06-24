import 'dart:io';
import 'dart:math';

import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:hospital/CONTROLLER/controller.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FirstBranch extends StatefulWidget {
  String branch_id;
  FirstBranch({required this.branch_id});
  @override
  State<FirstBranch> createState() => _FirstBranchState();
}

class _FirstBranchState extends State<FirstBranch> {
  List<String> chartType = ["DChartBar", "DChartPie", "DChartPie", "DChartBar"];

  String? daytoday;
  String? yesterday;
  String? dayafter;
  DateTime date = DateTime.now();
  String? selected;
  List<String> s = [];
  String? sid;
  var groupBarData = 1;
  Color parseColor(String color) {
    print("Colorrrrr...$color");
    String hex = color.replaceAll("#", "");
    if (hex.isEmpty) hex = "ffffff";
    if (hex.length == 3) {
      hex =
          '${hex.substring(0, 1)}${hex.substring(0, 1)}${hex.substring(1, 2)}${hex.substring(1, 2)}${hex.substring(2, 3)}${hex.substring(2, 3)}';
    }
    Color col = Color(int.parse(hex, radix: 16)).withOpacity(1.0);
    return col;
  }

  _getChart(String type, List<Map<String, dynamic>> data) {
    print("chart type$type");
    switch (type) {
      case "DChartPie":
        {
          // _tabController!.animateTo((0));
          return DChartPie(
            data: data,
            fillColor: (pieData, index) {
              switch (pieData['domain']) {
                case 'Revisit Patient':
                  return Colors.purple.shade300;
                case 'New Patient':
                  return Color.fromARGB(255, 185, 149, 125);
                case 'Lab order':
                  return Color.fromARGB(255, 45, 35, 194);
                case 'Radiology':
                  return Color.fromARGB(255, 192, 204, 21);
                case 'Bills':
                  return Color.fromARGB(255, 204, 74, 85);
                case 'CONSULTATION':
                  return Color.fromARGB(255, 8, 170, 70);
                case 'Refund Bills':
                  return Color.fromARGB(255, 138, 185, 51);
                case 'Dental':
                  return Color.fromARGB(255, 170, 73, 8);
                case 'General Physician':
                  return Color.fromARGB(255, 171, 151, 207);
                case 'Pathology':
                  return Color.fromARGB(255, 146, 19, 163);
                case 'Internal Medicine':
                  return Color.fromARGB(255, 8, 170, 89);
                default:
                  return Colors
                      .primaries[Random().nextInt(Colors.primaries.length)];
              }
            },
            // fillColor: (pieData, index) =>
            //     Colors.primaries[Random().nextInt(Colors.primaries.length)],
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
          measureLabelPaddingToAxisLine: 2,
          barColor: (barData, index, id) {
            switch (barData['domain']) {
              case 'CASH':
                return Colors.blue;
              case 'CARD':
                return Colors.red;
              case 'CREDIT':
                return Colors.yellow;

              default:
                return Colors
                    .primaries[Random().nextInt(Colors.primaries.length)];
            }
          },
          //
          verticalDirection: true,
          domainLabelPaddingToAxisLine: 16,
        );
    }
  }

  _getChartData(String type, List<Map<String, dynamic>> data) {
    print("chart type$type");
    switch (type) {
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
          measureLabelPaddingToAxisLine: 1,

          barColor: (barData, index, id) => parseColor(
              Provider.of<Controller>(context, listen: false).colorList[0]),

          // Colors.primaries[Random().nextInt(Colors.primaries.length)],
          verticalDirection: false,
          domainLabelPaddingToAxisLine: 16,
          axisLineTick: 2,
          axisLinePointTick: 2,
          axisLinePointWidth: 5,
        );
    }
  }

  @override
  void initState() {
    daytoday = DateFormat('yyyy-MM-dd').format(date);
    final yester = DateTime(date.year, date.month - 2, 1);
    // final yester = DateTime(date.year, date.month, 1);
    print("yesterday.....$yester");
    Provider.of<Controller>(context, listen: false)
        .chartDataSet(widget.branch_id, daytoday!, daytoday!,context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ScrollController _firstController = ScrollController();
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scrollbar(
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
                  value.collectData != null &&
                          value.collectData.isNotEmpty &&
                          value.countData != null &&
                          value.countData.isNotEmpty &&
                          value.departmentData != null &&
                          value.departmentData.isNotEmpty &&
                          value.servicegroupData != null &&
                          value.servicegroupData.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Column(
                            children: [
                              value.collectData != null &&
                                      value.collectData.isNotEmpty
                                  ? Visibility(
                                      visible: true,
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Text(
                                                "${value.collectData != null && value.collectData.isNotEmpty ? value.collectData[0]['rpt'] : ''}",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Color.fromARGB(
                                                        255, 179, 15, 15))),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: AspectRatio(
                                                aspectRatio: 1.5,
                                                child: _getChart("DChartBar",
                                                    value.collectData),
                                              ),
                                            ),
                                            SizedBox(
                                              height: size.height * 0.03,
                                            ),
                                            linearProgress(
                                                value.collectData, size),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Text(""),
                              //////////// collection Data ///////////////////////

                              //////////////////// count Data ///////////////////////////////
                              value.countData != null &&
                                      value.countData.isNotEmpty
                                  ? Visibility(
                                      visible: true,
                                      child: Column(
                                        children: [
                                          Text(
                                              "${value.countData != null && value.countData.isNotEmpty ? value.countData[0]['rpt'] : 'No Data Found'}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color.fromARGB(
                                                      255, 179, 15, 15))),
                                          SizedBox(
                                            height: size.height * 0.03,
                                          ),
                                          value.countData != null
                                              ? Visibility(
                                                  visible: true,
                                                  child: AspectRatio(
                                                    aspectRatio: 1.5,
                                                    child: _getChart(
                                                        "DChartPie",
                                                        value.countData),
                                                  ),
                                                )
                                              : Visibility(
                                                  child: Text("No Data Found")),
                                          SizedBox(
                                            height: size.height * 0.03,
                                          ),
                                          linearProgress(value.countData, size),
                                        ],
                                      ),
                                    )
                                  : Text(""),

                              ////////////////////// department data /////////////////////////////
                              value.departmentData != null &&
                                      value.departmentData.isNotEmpty
                                  ? Visibility(
                                      visible: true,
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Text(
                                                "${value.departmentData != null && value.departmentData.isNotEmpty ? value.departmentData[0]['rpt'] : 'No Data Found'}",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Color.fromARGB(
                                                        255, 179, 15, 15))),
                                            AspectRatio(
                                              aspectRatio: 1.5,
                                              child: _getChart("DChartPie",
                                                  value.departmentData),
                                            ),
                                            SizedBox(
                                              height: size.height * 0.03,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Text(""),

                              linearProgress(value.departmentData, size),
                              //////////////////////// service group ////////////////////////
                              value.servicegroupData != null &&
                                      value.servicegroupData.isNotEmpty
                                  ? Visibility(
                                      visible: true,
                                      child: Column(
                                        children: [
                                          Text(
                                              "${value.servicegroupData != null && value.servicegroupData.isNotEmpty ? value.servicegroupData[0]['rpt'] : 'No Data Found'}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color.fromARGB(
                                                      255, 179, 15, 15))),
                                          SizedBox(
                                            height: size.height * 0.05,
                                          ),
                                          AspectRatio(
                                            aspectRatio: 1.5,
                                            child: _getChartData("DChartBar",
                                                value.servicegroupData),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.03,
                                          ),
                                          linearProgress(
                                              value.servicegroupData, size),
                                        ],
                                      ),
                                    )
                                  : Text(""),
                            ],
                          ),
                        )
                      : Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget linearProgress(List<Map<String, dynamic>> list, Size size) {
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
                Flexible(
                  child: Container(
                      width: size.width * 0.2,
                      child: Text(
                        "${list[index]['measure'].toString()}",
                        style: TextStyle(fontSize: 12),
                      )),
                ),
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
Future<bool> _onBackPressed(BuildContext context) async {
  return await showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        // title: const Text('AlertDialog Title'),
        content: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ListBody(
            children: const <Widget>[
              Text('Do you want to exit from this app'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              exit(0);
            },
          ),
        ],
      );
    },
  );
}
