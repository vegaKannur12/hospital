import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hospital/SCREEN/chart.dart';
import 'package:provider/provider.dart';

import '../../components/commoncolor.dart';
import '../COMPONENTS/waveclipper.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  FocusNode? fieldFocusNode;
  TextEditingController codeController = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late String uniqId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    deletemenu();
  }

  deletemenu() async {
    print("delete");
    // await OrderAppDB.instance.deleteFromTableCommonQuery('menuTable', "");
  }

  @override
  Widget build(BuildContext context) {
    double topInsets = MediaQuery.of(context).viewInsets.top;
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        body: InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        child: Stack(
                          children: <Widget>[
                            ClipPath(
                              clipper:
                                  WaveClipper(), //set our custom wave clipper.
                              child: Container(
                                padding: EdgeInsets.only(bottom: 50),
                                color: P_Settings.wavecolor,
                                height: size.height * 0.3,
                                alignment: Alignment.center,
                                //   child: Text(
                                //   "Company Registration",
                                //   style: TextStyle(
                                //     fontSize: 20,
                                //     // fontWeight: FontWeight.bold,
                                //     color: Colors.white,
                                //   ),
                                // ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.13,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          controller: codeController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.business),
                            // contentPadding: EdgeInsets.all(15.0),
                            // hintText: 'What do people call you?',
                            labelText: 'Company Key',
                          ),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Please Enter Company Key';
                            }
                            return null;
                          },
                          // scrollPadding: EdgeInsets.only(
                          //     top:100),
                          // focusNode: fieldFocusNode,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Container(
                        height: size.height * 0.05,
                        width: size.width * 0.3,
                        child: ElevatedButton(
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyWidget()),
                              );
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(fontSize: 20),
                            )),
                      ),
                      SizedBox(
                        height: size.height * 0.09,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> _onBackPressed(BuildContext context) async {
  return await showDialog(context: context, builder: (context) => exit(0));
}
