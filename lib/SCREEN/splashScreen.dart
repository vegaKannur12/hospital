import 'package:flutter/material.dart';
import 'package:hospital/COMPONENTS/commoncolor.dart';
import 'package:hospital/CONTROLLER/controller.dart';
import 'package:hospital/SCREEN/registration.dart';
import 'package:hospital/SCREEN/tabbarinbody.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  String? cid;
  String? st_uname;
  String? st_pwd;

  navigate() async {
    await Future.delayed(Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      cid = prefs.getString("company_id");

      // );
      Navigator.push(
        context,
        PageRouteBuilder(
          opaque: false, // set to false
          pageBuilder: (_, __, ___) =>
              cid != null ? MyHomePage() : RegistrationScreen(),
        ),
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigate();
  }

  // late final AnimationController _controller = AnimationController(
  //   duration: const Duration(seconds: 2),
  //   vsync: this,
  // )..repeat();
  // late final Animation<double> _animation = CurvedAnimation(
  //   parent: _controller,
  //   curve: Curves.bounceInOut,
  // );
  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: P_Settings.wavecolor,
      body: InkWell(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Center(
            child: Column(
          children: [
            SizedBox(
              height: size.height * 0.4,
            ),
            Container(
                height: 200,
                width: 200,
                child: Image.asset(
                  "asset/logo_black_bg.png",
                )),
          ],
        )),
      ),
    );
  }
}
