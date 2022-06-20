// ///////////////////////////////////////////
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:horizontal_data_table/horizontal_data_table.dart';

// class SampleDataTable extends StatefulWidget {
//   const SampleDataTable({Key? key}) : super(key: key);

//   @override
//   State<SampleDataTable> createState() => _SampleDataTableState();
// }

// class _SampleDataTableState extends State<SampleDataTable> {
//   final jsondata = [
//     {
//       "rank": "0",
//       "a": "TLN1_BillNo",
//       "b": "TLN1_MRNo",
//       "c": "TLN5_Patient Name",
//       "d": "CRI1_Amt",
//       "e": "CRY1_Paid",
//       "f": "CRY1_Bal",
//       "g": "TLN1_Name",
//       "h": "CRY1_Bal",
//       "i": "TLN1_cgh",
//       "j": "TLN1_kjdsj",
//       "k": "TLD1_date",
//     },
//     {
//       "rank": "1",
//       "a": "G202204027",
//       "b": "TJAA2",
//       "c": "PRATHY",
//       "d": "472.5",
//       "e": "372.5",
//       "f": "100",
//       "g": "Anu",
//       "h": "6859",
//       "i": "CRcgh",
//       "j": "jkkjsdsa",
//       "k": "11/10/2020"

//       // "h": "6859"
//     },
//     {
//       "rank": "1",
//       "a": "G202204026",
//       "b": "TJAA2",
//       "c": "PRATHYEESH ",
//       "d": "1697.5",
//       "e": "1397.5",
//       "f": "300",
//       "g": "Graha",
//       "h": "900",
//       "i": "cgh",
//       "j": "bsdjhdd",
//       "k": "11/10/2020"
//     }
//   ];
//   List val = [100, 50, 20, 70, 150];
//   Map<String, dynamic> total = {};
//   List<Map<String, dynamic>> newJson = [];
//   final rows = <DataRow>[];
//   String? behv;

//   List<String>? colName;
//   List<String> tableColumn = [];
//   List<String> behvr = [];
//   Map<String, dynamic> mainHeader = {};
//   int col = 0;
//   @override
//   void initState() {
//     String colsName;
//     super.initState();
//     col = jsondata[0].length;

//     mainHeader = jsondata[0];
//     // print("main header from init state---$mainHeader");
//     var list = jsondata[0].values.toList();
//     list.removeAt(0);
//     for (var item in list) {
//       tableColumn.add(item);
//     }
//     jsondata.removeAt(0);
//     for (var item in jsondata) {
//       newJson.add(item);
//     }
//     newJson.forEach((item) => item..remove("rank"));
//   }

// //////////////////////////////////////////////////////////////////////////////

//   @override
//   Widget build(BuildContext context) {
//     final double width = MediaQuery.of(context).size.width;
//     final double height = MediaQuery.of(context).size.height;
//     if (col <= 5) {
//       width / col;
//     }
//     return Scaffold(
//       appBar: AppBar(title: Text("Dynamic datatable")),
//       body: InteractiveViewer(
//         minScale: .4,
//         maxScale: 5,
//         child: SingleChildScrollView(
//           // width: double.infinity,
//           scrollDirection: Axis.horizontal,
//           child: DataTable(
//             horizontalMargin: 0,
//             headingRowHeight: 30,
//             dataRowHeight: 35,
//             // dataRowColor:
//             //     MaterialStateColor.resolveWith((states) => Colors.yellow),
//             columnSpacing: 0,
//             border: TableBorder.all(width: 1, color: Colors.black),
//             columns: getColumns(tableColumn, width),
//             rows: getRowss(newJson),
//           ),
//         ),
//       ),
//     );
//   }

// ////////////////////////////////////////////////////////////
//   List<DataColumn> getColumns(List<String> columns, double width) {
//     // print("columns---${columns}");
//     String behv;
//     String colsName;
//     return columns.map((String column) {
//       colName = column.split('_');
//       colsName = colName![1];
//       behv = colName![0];
//       behvr.add(behv);
//       // print('Behave --- $behvr');
//       // print(behvr);

//       // print(behv[3]);
//       double strwidth = double.parse(behv[3]);
//       strwidth = strwidth * 10; //
//       return DataColumn(
//         label: Container(
//           width: 60,
//           child: Text(
//             colsName,
//             style: TextStyle(fontSize: 12),
//             textAlign: behv[1] == "L" ? TextAlign.left : TextAlign.right,
//           ),
//           // ),
//         ),
//       );
//     }).toList();
//   }

//   ////////////////////////////////////////////
//   List<DataRow> getRowss(List<Map<String, dynamic>> rows) {
//     List<String> newBehavr = [];
//     // print("rows---$rows");
//     return newJson.map((row) {
//       return DataRow(
//         // color: MaterialStateProperty.all(Colors.green),
//         cells: getCelle(row),
//       );
//     }).toList();
//   }
// /////////////////////////////////////////////

//   List<DataCell> getCelle(Map<String, dynamic> data) {
//     print("data--$data");
//     //  double  sum=0;
//     List<DataCell> datacell = [];
//     mainHeader.remove('rank');
//     // print("main header---$mainHeader");

//     data.forEach(
//       (key, value) {
//         mainHeader.forEach(
//           (k, val) {
//             if (key == k) {
//               datacell.add(
//                 DataCell(
//                   Container(
//                     child: Text(
//                       value.toString(),
//                       textAlign: mainHeader[k][1] == "L"
//                           ? TextAlign.left
//                           : TextAlign.right,
//                       style: TextStyle(
//                         fontSize: 10,
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }
//             // print("val${val}");
//           },
//         );
//         // print("value---$value");
//       },
//     );
//     // print(datacell.length);
//     return datacell;
//   }
// }
