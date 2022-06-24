import 'dart:convert';
import 'dart:io';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:math';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospital/COMPONENTS/commoncolor.dart';
import 'package:hospital/COMPONENTS/globalurl.dart';
import 'package:hospital/CONTROLLER/controller.dart';
import 'package:hospital/MODEL/multichart_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MultiDayOne extends StatefulWidget {
  const MultiDayOne({Key? key}) : super(key: key);

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

  getapi() async {
    try {
      Uri url = Uri.parse("http://146.190.8.166/API/multi_graph.php");
      // isloading=true;
      http.Response response = await http.get(
        url,
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
    // Provider.of<Controller>(context, listen: false).multiChartDataSet();
    getapi();
    daytoday = DateFormat('yyyy-MM-dd').format(date);
    final yester = DateTime(date.year, date.month - 2, 1);
    // final yester = DateTime(date.year, date.month, 1);
    print("yesterday.....$yester");
    // Provider.of<Controller>(context, listen: false)
    //     .chartDataSet(
    //       // widget.branch_id, daytoday!, daytoday!
    //       );
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
          child: collectionJson == null
              ? CircularProgressIndicator()
              : Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //////////// collection Data ///////////////////////

                        AspectRatio(
                          aspectRatio: 1.5,
                          child: DChartBar(
                            data: collectionJson["collection"],
                            minimumPaddingBetweenLabel: 1,
                            domainLabelPaddingToAxisLine: 16,
                            axisLineTick: 2,
                            axisLinePointTick: 2,
                            axisLinePointWidth: 10,
                            axisLineColor: Colors.green,
                            measureLabelPaddingToAxisLine: 16,
                            barColor: (barData, index, id) => Colors.primaries[
                                Random().nextInt(Colors.primaries.length)],

                            showBarValue: true,
                            barValueFontSize: 12,
                            // barValuePosition: BarValuePosition.outside,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        // linearProgress(, size),
                        //////////////////// count Data ///////////////////////////////
                      ],
                    ),
                  ],
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
