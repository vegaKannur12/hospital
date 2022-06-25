import 'dart:convert';
import 'dart:io';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:math';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospital/COMPONENTS/commoncolor.dart';
import 'package:hospital/COMPONENTS/customDatatable.dart';
import 'package:hospital/COMPONENTS/globalurl.dart';
import 'package:hospital/CONTROLLER/controller.dart';
import 'package:hospital/MODEL/multichart_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MultiDayOne extends StatefulWidget {
  String branch_id;
  String fromDate;
  String todate;
  String period;

  MultiDayOne(
      {required this.branch_id,
      required this.fromDate,
      required this.todate,
      required this.period});

  @override
  State<MultiDayOne> createState() => _MultiDayOneState();
}

class _MultiDayOneState extends State<MultiDayOne> {
  String urlgolabl = Globaldata.apiglobal;
  List<String> chartType = ["DChartBar", "DChartPie", "DChartPie", "DChartBar"];
  var collectionJson;
  String? daytoday;
  String? yesterday;
  String? dayafter;
  DateTime date = DateTime.now();
  String? selected;
  List<String> s = [];
  String? sid;
  var groupBarData = 1;
  var client = http.Client();

  ////////////////////////////////////////////////////////
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

  //////////////////////////////////////////////////////
  getapi(String from_date, String till_date, String branch_id,
      String period) async {
    print("dateeee..$from_date---$till_date---$branch_id----$period");

    try {
      Uri url = Uri.parse("$urlgolabl/multi_graph.php");
      // isloading=true;
      Map body = {
        'from_date': from_date,
        'till_date': till_date,
        'branch_id': branch_id,
        'period': period,
      };

      http.Response response = await http.post(
        url,
        body: body,
      );

      print("response..${response.body}");
      setState(() {
        collectionJson =
            MultiChart.fromJson(json.decode(response.body)).toJson();
        print("collectionJson....${collectionJson}");
      });
    } catch (e) {
      print("error...$e");
    }
  }

  @override
  void initState() {
    getapi(widget.fromDate, widget.todate, widget.branch_id, widget.period);
    // TODO: implement initState
    Provider.of<Controller>(context, listen: false).multiChartDataSet(
        widget.fromDate, widget.todate, widget.branch_id, widget.period);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ScrollController _firstController = ScrollController();
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Consumer<Controller>(
        builder: (context, value, child) {
          // var consultation = CONSULTATION;
          return SingleChildScrollView(
            controller: _firstController,
            scrollDirection: Axis.vertical,
            child: collectionJson == null
                ? Container(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height * 0.3,
                        ),
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      collectionJson["collection"] != null
                          ? Visibility(
                              visible: true,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //////////// collection Data ///////////////////////
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text("Collection at Glance",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                                255, 179, 15, 15))),
                                  ),

                                  collectionJson["collection"].length < 5
                                      ? AspectRatio(
                                          aspectRatio: 1,
                                          child: DChartBar(
                                            data: collectionJson["collection"],
                                            minimumPaddingBetweenLabel: 1,
                                            domainLabelPaddingToAxisLine: 16,
                                            axisLineTick: 2,
                                            axisLinePointTick: 2,
                                            axisLinePointWidth: 10,
                                            axisLineColor: Colors.green,
                                            measureLabelPaddingToAxisLine: 16,
                                            barColor: (barData, index, id) =>
                                                id == 'CASH'
                                                    ? parseColor(
                                                        Provider.of<Controller>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .multiid !=
                                                                    null &&
                                                                Provider.of<Controller>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .multiid
                                                                    .isNotEmpty
                                                            ? Provider.of<Controller>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .multiid[0]
                                                                ['color_code']
                                                            : '#1db345',
                                                      )
                                                    : id == 'CARD'
                                                        ? parseColor(
                                                            Provider.of<Controller>(context, listen: false)
                                                                            .multiid !=
                                                                        null &&
                                                                    Provider.of<Controller>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .multiid
                                                                        .isNotEmpty
                                                                ? Provider.of<
                                                                            Controller>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .multiid[1]['color_code']
                                                                : "#1b86de",
                                                          )
                                                        : parseColor(
                                                            Provider.of<Controller>(context, listen: false)
                                                                            .multiid !=
                                                                        null &&
                                                                    Provider.of<Controller>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .multiid
                                                                        .isNotEmpty
                                                                ? Provider.of<
                                                                            Controller>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .multiid[2]['color_code']
                                                                : '#e31e3b',
                                                          ),
                                            // barColor: (barData, index, id) => Colors.primaries[
                                            //     Random().nextInt(Colors.primaries.length)],

                                            showBarValue: true,
                                            barValueFontSize: 12,
                                            // barValuePosition: BarValuePosition.outside,
                                          ),
                                        )
                                      : Container(
                                          height: size.height * 0.4,
                                          child: ListView.builder(
                                            itemCount:
                                                collectionJson["collection"]
                                                    .length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                title: Text(
                                                    collectionJson["collection"]
                                                                ['data'][index]
                                                            ['domain']
                                                        .toString()),
                                                leading: Text(
                                                    collectionJson["collection"]
                                                                ['data'][index]
                                                            ['measure']
                                                        .toString()),
                                              );
                                            },
                                          ),
                                        ),
                                  SizedBox(
                                    height: size.height * 0.03,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                            radius: 8,
                                            backgroundColor: parseColor(
                                              Provider.of<Controller>(context,
                                                                  listen: false)
                                                              .multiid !=
                                                          null &&
                                                      Provider.of<Controller>(
                                                              context,
                                                              listen: false)
                                                          .multiid
                                                          .isNotEmpty
                                                  ? Provider.of<Controller>(
                                                          context,
                                                          listen: false)
                                                      .multiid[0]['color_code']
                                                  : '#1db345',
                                            )),
                                        SizedBox(
                                          width: size.width * 0.03,
                                        ),
                                        Text("CASH"),
                                        SizedBox(
                                          width: size.width * 0.05,
                                        ),
                                        CircleAvatar(
                                            radius: 8,
                                            backgroundColor: parseColor(
                                              Provider.of<Controller>(context,
                                                                  listen: false)
                                                              .multiid !=
                                                          null &&
                                                      Provider.of<Controller>(
                                                              context,
                                                              listen: false)
                                                          .multiid
                                                          .isNotEmpty
                                                  ? Provider.of<Controller>(
                                                          context,
                                                          listen: false)
                                                      .multiid[1]['color_code']
                                                  : "#1b86de",
                                            )),
                                        SizedBox(
                                          width: size.width * 0.03,
                                        ),
                                        Text("CARD"),
                                        SizedBox(
                                          width: size.width * 0.05,
                                        ),
                                        CircleAvatar(
                                          radius: 8,
                                          backgroundColor: parseColor(
                                            Provider.of<Controller>(context,
                                                                listen: false)
                                                            .multiid !=
                                                        null &&
                                                    Provider.of<Controller>(
                                                            context,
                                                            listen: false)
                                                        .multiid
                                                        .isNotEmpty
                                                ? Provider.of<Controller>(
                                                        context,
                                                        listen: false)
                                                    .multiid[2]['color_code']
                                                : '#e31e3b',
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.03,
                                        ),
                                        Text("CREDIT"),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: AspectRatio(
                                      aspectRatio: 1.5,
                                      child: DChartBar(
                                        data: collectionJson["collection"],
                                        showMeasureLine: false,
                                        minimumPaddingBetweenLabel: 1,
                                        domainLabelPaddingToAxisLine: 16,
                                        axisLineTick: 1,
                                        measureLabelColor: Colors.white,
                                        xAxisTitleColor: Colors.white,
                                        axisLinePointTick: 0,
                                        axisLinePointWidth: 10,
                                        axisLineColor: Colors.white,
                                        measureLabelPaddingToAxisLine: 16,
                                        barColor: (barData, index, id) => id ==
                                                'CASH'
                                            ? parseColor(
                                                Provider.of<Controller>(context,
                                                                    listen:
                                                                        false)
                                                                .multiid !=
                                                            null &&
                                                        Provider.of<Controller>(
                                                                context,
                                                                listen: false)
                                                            .multiid
                                                            .isNotEmpty
                                                    ? Provider.of<Controller>(
                                                                context,
                                                                listen: false)
                                                            .multiid[0]
                                                        ['color_code']
                                                    : '#1db345',
                                              )
                                            : id == 'CARD'
                                                ? parseColor(
                                                    Provider.of<Controller>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .multiid !=
                                                                null &&
                                                            Provider.of<Controller>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .multiid
                                                                .isNotEmpty
                                                        ? Provider.of<Controller>(
                                                                    context,
                                                                    listen: false)
                                                                .multiid[1]
                                                            ['color_code']
                                                        : "#1b86de",
                                                  )
                                                : parseColor(
                                                    Provider.of<Controller>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .multiid !=
                                                                null &&
                                                            Provider.of<Controller>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .multiid
                                                                .isNotEmpty
                                                        ? Provider.of<Controller>(
                                                                    context,
                                                                    listen: false)
                                                                .multiid[2]
                                                            ['color_code']
                                                        : '#e31e3b',
                                                  ),
                                        // barColor: (barData, index, id) => Colors.primaries[
                                        //     Random().nextInt(Colors.primaries.length)],
                                        verticalDirection: false,
                                        barValue: (barData, index) =>
                                            '${barData['measure']}',
                                        showBarValue: true,
                                        barValueFontSize: 12,
                                        barValuePosition: BarValuePosition.auto,
                                      ),
                                    ),
                                  ),
                                  //////////////////// count Data ///////////////////////////////
                                ],
                              ),
                            )
                          : Text(''),
                      collectionJson["visit_data"] != null
                          ? Visibility(
                              visible: true,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //////////// collection Data ///////////////////////
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text("VisitTypeWise Collection",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                                255, 179, 15, 15))),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          collectionJson["visit_data"][0]['id'],
                                          style: TextStyle(
                                              color: parseColor(
                                                '#1db345',
                                              ),
                                              fontSize: 20),
                                        ),
                                      ),
                                      Container(
                                        height: size.height * 0.4,
                                        child: ListView.builder(
                                          itemCount:
                                              collectionJson["visit_data"][0]
                                                  .length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              title: Text(
                                                  collectionJson["visit_data"][0]
                                                          ['data'][index]
                                                      ['measure'].toString()),
                                              leading: Text(
                                                  collectionJson["visit_data"][0]
                                                          ['data'][index]
                                                      ['domain'].toString()),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  // AspectRatio(
                                  //   aspectRatio: 1.5,
                                  //   child: DChartBar(
                                  //     data: collectionJson["visit_data"],
                                  //     minimumPaddingBetweenLabel: 1,
                                  //     domainLabelPaddingToAxisLine: 16,
                                  //     axisLineTick: 2,
                                  //     axisLinePointTick: 2,
                                  //     axisLinePointWidth: 10,
                                  //     axisLineColor: Colors.green,
                                  //     measureLabelPaddingToAxisLine: 16,
                                  //     // barColor: (barData, index, id) =>
                                  //     barColor: (barData, index, id) =>
                                  //         Colors.primaries[Random().nextInt(
                                  //             Colors.primaries.length)],

                                  //     showBarValue: true,
                                  //     barValueFontSize: 12,
                                  //     // barValuePosition: BarValuePosition.outside,
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: size.height * 0.03,
                                  // ),

                                  //////////////////// count Data ///////////////////////////////
                                ],
                              ),
                            )
                          : Text(""),
                      //  ChartTable(charttab: [value.multiCollection[0]],)
                      Column(
                        children: [],
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}

////////////////////////////////////////////
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
