import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hospital/COMPONENTS/commoncolor.dart';


class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List colors = [Colors.red, Colors.green, Colors.yellow];
  Random random = new Random();

  List data = ["text1", "text1", "text1"];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: P_Settings.wavecolor,
        title: Text("Hospital"),
      ),
      drawer: Drawer(),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: size.height * 0.3,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: P_Settings.wavecolor,
                elevation: 10,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      leading: Icon(Icons.album, size: 45),
                      // title: BarChart([]),
                      subtitle: Text('Best of Sonu Nigam Song'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
