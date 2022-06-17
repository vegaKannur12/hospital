// import 'package:flutter/material.dart';

// class CustomDataTable extends StatefulWidget {
//   const CustomDataTable({ Key? key }) : super(key: key);

//   @override
//   State<CustomDataTable> createState() => _CustomDataTableState();
// }

// class _CustomDataTableState extends State<CustomDataTable> {
//   @override
//   Widget build(BuildContext context) {
//        return SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       child: FittedBox(
//         child: DataTable(
//           columnSpacing: 0,
//           headingRowHeight: 35,
//           dataRowHeight: 35,
//           decoration: BoxDecoration(color: P_Settings.datatableColor),
//           border: TableBorder.all(
//             color: P_Settings.datatableColor,
//           ),
//           dataRowColor:
//               MaterialStateColor.resolveWith((states) => widget.level == "level1"
//                   ? P_Settings.l1datatablecolor
//                   : widget.level == "level2"
//                       ? P_Settings.l2datatablecolor
//                       : widget.level == "level3"
//                           ? P_Settings.l3datatablecolor
//                           : P_Settings.color4),
//           columns: getColumns(tableColumn),
//           rows: getRowss(newMp),
//         ),
//       ),
//     );
//   }

//   ///////////////////////////////////////////////////////
//     List<DataColumn> getColumns(List<String> columns) {
//     String behv;
//     String colsName;
//     return columns.map((String column) {
//       // final isAge = column == columns[2];
//       colName = column.split('_');
//       colsName = colName![1];
//       behv = colName![0];
//       // print("column---${column}");
//       return DataColumn(
//         tooltip: colsName,
//         label: Container(
//           width: 50,
//           child: Padding(
//             padding: behv[1] == "L"? EdgeInsets.only(left:0.2):EdgeInsets.only(right:0.2),
//             child: Text(
//               colsName,
//               style: TextStyle(fontSize: 12),
//               textAlign: behv[1] == "L" ? TextAlign.left : TextAlign.right,
//             ),
//           ),
//         ),
//       );
//     }).toList();
//   }
// }