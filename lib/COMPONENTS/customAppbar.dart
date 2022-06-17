import 'package:flutter/material.dart';

class CustomAppbar extends StatefulWidget {
  String title;
  String pageName;
  CustomAppbar({required this.title,required this.pageName});
  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:Text(widget.title.toString()),
      // actions: [
      //    widget.pageName=="company details"?
      //    IconButton(
      //      onPressed: (){

      //    }, icon: Icon(Icons.done),):null
      // ],
    );
  }
}