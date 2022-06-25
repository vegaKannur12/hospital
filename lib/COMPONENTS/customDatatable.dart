// import 'package:flutter/material.dart';
// import 'package:hospital/CONTROLLER/controller.dart';
// import 'package:provider/provider.dart';

// import 'package:flutter/material.dart';

// class ChartTable extends StatefulWidget {
//    List<Map<String, dynamic>> charttab;
//   ChartTable({required this.charttab});
//   @override
//   State<ChartTable> createState() => _ChartTableState();
// }

// class _ChartTableState extends State<ChartTable> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<Controller>(
//       builder: (context, value, child) {
//        return SingleChildScrollView(
//           child: Container(
//             child: DataTable(
//               horizontalMargin: 0,
//               headingRowHeight: 25,
//               dataRowHeight: 30,
//               headingRowColor: MaterialStateColor.resolveWith(
//                   (states) => Color.fromARGB(255, 240, 235, 235)),
//               columnSpacing: 0,
//               showCheckboxColumn: false,
//               dataRowColor:
//                   MaterialStateColor.resolveWith((states) => Colors.white),
//               border: TableBorder.all(width: 1, color: Colors.grey),
//               columns: getColumns(value.coldata),
//               rows: getRowss(value.multiDta),
//             ),
//           ),
//         );
//       },
//     );
//   }


// List<DataColumn> getColumns(List<String> columns) {
//     // print("columns---${columns}");
//     String behv;
//     String colsName;
//     return columns.map((String column) {
//       // double strwidth = double.parse(behv[3]);
//       // strwidth = strwidth * 10; //
//       return DataColumn(
//         label: Container(
//           width: 70,
//           child: Text(
//             column,
//             style: TextStyle(fontSize: 12),
//             textAlign: TextAlign.center,
//             // textAlign: behv[1] == "L" ? TextAlign.left : TextAlign.right,
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
//     return rows.map((row) {
//       return DataRow(
//         // color: MaterialStateProperty.all(Colors.green),
//         cells: getCelle(row),
//       );
//     }).toList();
//   }
// /////////////////////////////////////////////

//   List<DataCell> getCelle(Map<String, dynamic> data) {
//     // print("data--$data");
//     //  double  sum=0;
//     List<DataCell> datacell = [];

//     // print("main header---$mainHeader");

//     data.forEach((key, value) {
//       datacell.add(
//         DataCell(
//           Container(
//              width:70,
//             // width: mainHeader[k][3] == "1" ? 70 : 30,
//             alignment: Alignment.center,
//             //     ? Alignment.centerLeft
//             //     : Alignment.centerRight,
//             child: Text(
//               value.toString(),
//               // textAlign:
//               //     mainHeader[k][1] == "L" ? TextAlign.left : TextAlign.right,
//               style: TextStyle(
//                 fontSize: 10,
//               ),
//             ),
//           ),
//         ),
//       );
//     });

//     // print(datacell.length);
//     return datacell;
//   }

// }