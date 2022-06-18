// import 'package:flutter/material.dart';
// import 'package:hospital/COMPONENTS/commoncolor.dart';
// import 'package:hospital/SCREEN/branch1.dart';
// import 'package:hospital/SCREEN/branch2.dart';
// import 'package:hospital/SCREEN/branch3.dart';
// import 'package:intl/intl.dart';

// enum WidgetMarker {
//   dayone,
//   daytwo,
//   daythree,
// }

// class FilterReport extends StatefulWidget {
//   const FilterReport({Key? key}) : super(key: key);

//   @override
//   State<FilterReport> createState() => _FilterReportState();
// }

// class _FilterReportState extends State<FilterReport> {
//   WidgetMarker selectedWidgetMarker = WidgetMarker.dayone;
//   List<Map<String, dynamic>> data = [
//     {
//       'type': 'DChartPie',
//       'domain': 'Flutter',
//       'measure': 28,
//       'pvalue': 0.4,
//     },
//     {
//       'type': 'DChartBar',
//       'domain': 'React Native',
//       'measure': 27,
//       'pvalue': 0.3,
//     },
//     {
//       'type': 'DChartLine',
//       'domain': 'Ionic',
//       'measure': 20,
//       'pvalue': 0.2,
//     },
//     {'type': 'DChartBar', 'domain': 'Cordova', 'measure': 15, 'pvalue': 0.1},
//   ];
//   List<Map<String, dynamic>>? head = [
//     {'title': 'Expence', 'total': '3000'},
//     {'title': 'Eran', 'total': '2500'},
//     {'title': 'Visit', 'total': '4000'},
//   ];
//   String? daytoday;
//   String? yesterday;
//   String? dayafter;
//   DateTime date = DateTime.now();
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // WidgetsBinding.instance.addPostFrameCallback((_) => build(context));

//     print("init");
//     final now = DateTime.now();
//     final today = DateTime(now.year, now.month, now.day);
//     final yester = DateTime(now.year, now.month, now.day - 1);
//     final dayaf = DateTime(now.year, now.month, now.day - 2);

//     daytoday = DateFormat('dd').format(date);
//     yesterday = DateFormat('dd').format(yester);
//     dayafter = DateFormat('dd').format(dayaf);
//     print("dayafter yesterday $dayafter $yesterday ");
//     print("daytotoday$daytoday");
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     Widget dayone() {
//       return Branch1();
//     }

//     Widget daytwo() {
//       return Branch2();
//     }

//     Widget daythree() {
//       return Branch3();
//     }

//     Widget getCustomContainer() {
//       print("inside switch case");
//       switch (selectedWidgetMarker) {
//         case WidgetMarker.dayone:
//           return dayone();
//         case WidgetMarker.daytwo:
//           return daytwo();
//         case WidgetMarker.daythree:
//           return daythree();
//       }
//     }

//     return Scaffold(
//       appBar: AppBar(),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedWidgetMarker = WidgetMarker.daythree;
//                       print("selectedWidgetMarker $selectedWidgetMarker");
//                     });
//                   },
//                   child: CircleAvatar(
//                     backgroundColor: P_Settings.headingColor,
//                     child: Text(
//                       dayafter!,
//                       style: TextStyle(
//                           fontSize: 17,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: size.width * 0.03,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedWidgetMarker = WidgetMarker.daytwo;
//                       print("selectedWidgetMarker $selectedWidgetMarker");
//                     });
//                   },
//                   child: CircleAvatar(
//                     backgroundColor: P_Settings.headingColor,
//                     child: Text(
//                       yesterday!,
//                       style: TextStyle(
//                           fontSize: 17,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: size.width * 0.03,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedWidgetMarker = WidgetMarker.dayone;
//                       print("selectedWidgetMarker $selectedWidgetMarker");
//                     });
//                   },
//                   child: CircleAvatar(
//                     backgroundColor: P_Settings.headingColor,
//                     child: Text(
//                       daytoday!,
//                       style: TextStyle(
//                           fontSize: 17,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   getCustomContainer();
//                 });
//               },
//               child: Container(
//                 height: size.height * 0.9,
//                 child: getCustomContainer(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
