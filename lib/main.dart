import 'package:flutter/material.dart';
import 'package:hospital/SCREEN/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        //   buttonTheme: ButtonThemeData(
        //     buttonColor: Colors.deepPurple, //  <-- dark color
        //     textTheme:
        //         ButtonTextTheme.primary, //  <-- this auto selects the right color
        //   ),
      ),
      home: Scaffold(
        body: StaffLogin(),
      ),
    );
  }
}
