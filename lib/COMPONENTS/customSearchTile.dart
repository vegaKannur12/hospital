import 'package:flutter/material.dart';

class SearchTile {
  void searchItem(String enteredKeyword, List<Map<String, dynamic>> products) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = products;
    } else {
      results = products
          .where((product) => product["item"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    // setState(() {
    //   _foundUsers = results;
    // });
  }
}
