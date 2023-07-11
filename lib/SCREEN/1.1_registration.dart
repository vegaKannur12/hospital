import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hospital/COMPONENTS/externalDir.dart';
import 'package:hospital/CONTROLLER/controller.dart';
import 'package:provider/provider.dart';
import '../../components/commoncolor.dart';
import '../COMPONENTS/waveclipper.dart';
import 'package:device_info_plus/device_info_plus.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  FocusNode? fieldFocusNode;
  ExternalDir externalDir = ExternalDir();
  String? manufacturer;
  String? model;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  TextEditingController codeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  late String uniqId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    deletemenu();
    initPlatformState();
  }

  deletemenu() async {
    print("delete");
    // await OrderAppDB.instance.deleteFromTableCommonQuery('menuTable', "");
  }

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        manufacturer = deviceData["manufacturer"];
        model = deviceData["model"];
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'manufacturer': build.manufacturer,
      'model': build.model,
    };
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
                                color: P_Settings.headingColor,
                                height: size.height * 0.3,
                                alignment: Alignment.center,
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
                            labelText: 'Company Key',
                          ),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Please Enter Company Key';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: phoneController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.phone),
                            labelText: 'Phone Number',
                          ),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Please Enter Phone Number';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Container(
                        height: size.height * 0.05,
                        width: size.width * 0.3,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: P_Settings.headingColor,
                          ),
                          onPressed: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (_formKey.currentState!.validate()) {
                              String deviceInfo =
                                  "$manufacturer" + '' + "$model";
                              print("device info-----$deviceInfo");
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => LoginPage()),
                              // );

                              // await OrderAppDB.instance
                              //     .deleteFromTableCommonQuery('menuTable', "");
                              FocusScope.of(context).requestFocus(FocusNode());
                              if (_formKey.currentState!.validate()) {
                                String tempFp1 = await externalDir.fileRead();
                                // String? tempFp1=externalDir.tempFp;

                                // if(externalDir.tempFp==null){
                                //    tempFp="";
                                // }
                                print("tempFp---${tempFp1}");
                                // textFile = await externalDir
                                //     .getPublicDirectoryPath();
                                // print("textfile........$textFile");

                                Provider.of<Controller>(context, listen: false)
                                    .postRegistration(
                                        codeController.text,
                                        tempFp1,
                                        phoneController.text,
                                        deviceInfo,
                                        context);
                              }
                            }
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: 'Montserrat'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.09,
                      ),
                      Consumer<Controller>(
                        builder: (context, value, child) {
                          if (value.isLoading) {
                            return SpinKitCircle(
                                color: P_Settings.headingColor);
                          } else {
                            return Container();
                          }
                        },
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
