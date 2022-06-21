// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:hospital/SCREEN/chart.dart';
// import 'package:hospital/components/commoncolor.dart';
// import 'package:hospital/db_helper.dart';
// import 'package:intl/intl.dart';
// import 'package:orderapp/components/commoncolor.dart';
// import 'package:orderapp/components/customPopup.dart';
// import 'package:orderapp/controller/controller.dart';
// import 'package:orderapp/db_helper.dart';
// import 'package:orderapp/screen/ORDER/5_dashboard.dart';
// import 'package:orderapp/service/tableList.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '6_downloadedPage.dart';

// class StaffLogin extends StatelessWidget {
//   DateTime now = DateTime.now();

//   String? date;
//   ValueNotifier<bool> _isObscure = ValueNotifier(true);

//   final _formKey = GlobalKey<FormState>();
//   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   TextEditingController controller1 = TextEditingController();
//   TextEditingController controller2 = TextEditingController();
//   CustomPopup popup = CustomPopup();
//   List result = [];
//   // GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   ValueNotifier<bool> visible = ValueNotifier(false);

//   toggle() {
//     visible.value = !visible.value;
//   }

//   @override
//   Widget build(BuildContext context) {
//     double topInsets = MediaQuery.of(context).viewInsets.top;

//     date = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
//     print("staff log date $date");
//     print("now date $now");
//     Size size = MediaQuery.of(context).size;
//     return WillPopScope(
//       onWillPop: () => _onBackPressed(context),
//       child: Scaffold(
//         resizeToAvoidBottomInset: true,
//         // backgroundColor: Colors.transparent,
//         key: _scaffoldKey,
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           elevation: 0,
//           backgroundColor: P_Settings.wavecolor,
//           actions: [
//             // IconButton(
//             //     onPressed: () {
//             //       controller.add(true);
//             //     },
//             //     icon: Icon(Icons.refresh)),
//             IconButton(
//               onPressed: () async {
//                 List<Map<String, dynamic>> list =
//                     await OrderAppDB.instance.getListOfTables();
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => TableList(list: list)),
//                 );
//               },
//               icon: Icon(Icons.table_bar),
//             ),
//             // IconButton(
//             //   onPressed: () async {
//             //     await OrderAppDB.instance.deleteStaffdetails();
//             //   },
//             //   icon: Icon(Icons.delete),
//             // ),
//           ],
//         ),
//         body: InkWell(
//           onTap: () {
//             FocusScope.of(context).requestFocus(FocusNode());
//           },
//           child: Form(
//             key: _formKey,
//             child: Container(
//               child: LayoutBuilder(
//                 builder: (context, BoxConstraints viewportConstraints) {
//                   return SingleChildScrollView(
//                     child: ConstrainedBox(
//                       constraints: BoxConstraints(
//                           minHeight: viewportConstraints.maxHeight),
//                       child: Container(
//                         child: IntrinsicHeight(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: P_Settings.wavecolor,
//                                   borderRadius: BorderRadius.only(
//                                     bottomLeft: Radius.circular(50),
//                                     bottomRight: Radius.circular(50),
//                                   ),
//                                 ),
//                                 width: MediaQuery.of(context).size.width,
//                                 height:
//                                     MediaQuery.of(context).size.height * 0.30,
//                                 child: Center(
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: <Widget>[
//                                       CircleAvatar(
//                                         backgroundColor: Colors.grey,
//                                         radius: 40,
//                                         child: Icon(
//                                           Icons.person,
//                                           color: Colors.white,
//                                           size: 50,
//                                         ),
//                                       ),
//                                       SizedBox(height: size.height * 0.03),
//                                       Text(
//                                         'Login',
//                                         style: TextStyle(
//                                           fontSize: 30,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Container(
//                                   padding: EdgeInsets.all(30),
//                                   child: Column(
//                                     children: <Widget>[
//                                       customTextField("Username", controller1,
//                                           "staff", context),

//                                       customTextField("Password", controller2,
//                                           "password", context),
//                                       SizedBox(
//                                         height: size.height * 0.01,
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                             left: 17.0, right: 17),
//                                         child: Container(
//                                           height: size.height * 0.06,
//                                           child: ElevatedButton(
//                                             style: ElevatedButton.styleFrom(
//                                               primary: P_Settings.wavecolor,
//                                               shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                         20), // <-- Radius
//                                               ),
//                                             ),
//                                             onPressed: () async {
//                                               result.clear();
                                             
//                                                   Navigator.push(
//                                                     context,
//                                                     MaterialPageRoute(
//                                                         builder: (context) =>
//                                                             Dashboard()),
//                                                   );
//                                                 }
//                                               }
//                                             },
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: <Widget>[
//                                                 Text(
//                                                   'LOGIN',
//                                                   style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize: 20,
//                                                   ),
//                                                 ),
//                                                 Icon(
//                                                   Icons.arrow_forward,
//                                                   size: 25,
//                                                   color: Colors.white,
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                             left: 15, right: 15, top: 25),
//                                         child: Container(
//                                           height: size.height * 0.07,
//                                           child: Row(
//                                             children: [
//                                               SizedBox(
//                                                 width: 20,
//                                               ),

//                                               MaterialButton(
//                                                 onPressed: () {
//                                                   Navigator.push(
//                                                     context,
//                                                     MaterialPageRoute(
//                                                         builder: (context) =>
//                                                             MyWidget(
                                                              
//                                                             )),
//                                                   );
//                                                 },
//                                                 color: P_Settings
//                                                     .wavecolor,
//                                                 textColor: Colors.white,
//                                                 child: Icon(
//                                                   Icons.download,
//                                                   size: 24,
//                                                   color: P_Settings.wavecolor,
//                                                 ),
//                                                 padding: EdgeInsets.all(16),
//                                                 shape: CircleBorder(),
//                                               ),
//                                               //////////////////////////////

//                                               MaterialButton(
//                                                 onPressed: () async {
//                                                   await OrderAppDB.instance
//                                                       .deleteFromTableCommonQuery(
//                                                           "staffDetailsTable",
//                                                           "");
//                                                   SharedPreferences prefs =
//                                                       await SharedPreferences
//                                                           .getInstance();
//                                                   String? cid =
//                                                       prefs.getString("cid");
//                                                   print("staff cid----${cid}");
//                                                   Provider.of<Controller>(
//                                                           context,
//                                                           listen: false)
//                                                       .getStaffDetails(cid!);
//                                                   showDialog(
//                                                     context: context,
//                                                     builder: (BuildContext
//                                                             context) =>
//                                                         popup.buildPopupDialog(
//                                                             context,
//                                                             "Details Saved"),
//                                                   );
//                                                 },
//                                                 color: P_Settings
//                                                     .roundedButtonColor,
//                                                 textColor: Colors.white,
//                                                 child: Icon(
//                                                   Icons.refresh,
//                                                   size: 24,
//                                                   color: P_Settings.wavecolor,
//                                                 ),
//                                                 padding: EdgeInsets.all(16),
//                                                 shape: CircleBorder(),
//                                               ),
//                                               MaterialButton(
//                                                 onPressed: () {
//                                                   CustomPopup popu =
//                                                       CustomPopup();
//                                                   popup.buildPopupDialog(
//                                                       context, "Exit ap?");
//                                                   exit(0);
//                                                 },
//                                                 color: P_Settings
//                                                     .roundedButtonColor,
//                                                 textColor: Colors.white,
//                                                 child: Icon(
//                                                   Icons.close,
//                                                   size: 24,
//                                                   color: P_Settings.wavecolor,
//                                                 ),
//                                                 padding: EdgeInsets.all(16),
//                                                 shape: CircleBorder(),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: size.height * 0.02,
//                                       ),
//                                       ValueListenableBuilder(
//                                           valueListenable: visible,
//                                           builder: (BuildContext context,
//                                               bool v, Widget? child) {
//                                             print("value===${visible.value}");
//                                             return Visibility(
//                                               visible: v,
//                                               child: Text(
//                                                 "Incorrect Username or Password!!!",
//                                                 style: TextStyle(
//                                                     color: Colors.red),
//                                               ),
//                                             );
//                                           })
//                                       // ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

// /////////////////////////////////////////////////////////////////////////
//   Widget customTextField(String hinttext, TextEditingController controllerValue,
//       String type, BuildContext context) {
//     double topInsets = MediaQuery.of(context).viewInsets.top;
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ValueListenableBuilder(
//           valueListenable: _isObscure,
//           builder: (context, value, child) {
//             return TextFormField(
//               textCapitalization: TextCapitalization.characters,
//               obscureText: type == "password" ? _isObscure.value : false,
//               scrollPadding:
//                   EdgeInsets.only(bottom: topInsets + size.height * 0.34),
//               controller: controllerValue,
//               decoration: InputDecoration(
//                   prefixIcon: type == "password"
//                       ? Icon(Icons.password)
//                       : Icon(Icons.person),
//                   suffixIcon: type == "password"
//                       ? IconButton(
//                           icon: Icon(
//                             _isObscure.value
//                                 ? Icons.visibility_off
//                                 : Icons.visibility,
//                           ),
//                           onPressed: () {
//                             _isObscure.value = !_isObscure.value;
//                             print("_isObscure $_isObscure");
//                           },
//                         )
//                       : null,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                     borderSide: BorderSide(
//                       color: Colors.black,
//                       width: 3,
//                     ),
//                   ),
//                   hintText: hinttext.toString()),
//               validator: (text) {
//                 if (text == null || text.isEmpty) {
//                   return 'Please Enter ${hinttext}';
//                 }
//                 return null;
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// //////////////////////////////
// Future<bool> _onBackPressed(BuildContext context) async {
//   return await showDialog(
//     context: context,
//     barrierDismissible: false, // user must tap button!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         // title: const Text('AlertDialog Title'),
//         content: SingleChildScrollView(
//           child: ListBody(
//             children: const <Widget>[
//               Text('Do you want to exit from this app'),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: const Text('cancel'),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           TextButton(
//             child: const Text('Ok'),
//             onPressed: () {
//               exit(0);
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
