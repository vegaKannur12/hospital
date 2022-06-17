import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // This will be displayed below the autocomplete field
  String? _selectedAnimal;

  // This list holds all the suggestions
  final List<String> _suggestions = [
    'Alligator',
    'Buffalo',
    'Chicken',
    'Dog',
    'Eagle',
    'Frog'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kindacode.com'),
      ),
      body: Column(
        children: [
          Autocomplete<String>(
            optionsBuilder: (TextEditingValue value) {
              // When the field is empty
              if (value.text.isEmpty) {
                return [];
              }

              // The logic to find out which ones should appear
              return _suggestions.where((suggestion) =>
                  suggestion.toLowerCase().contains(value.text.toLowerCase()));
            },
            onSelected: (value) {
              setState(() {
                _selectedAnimal = value;
              });
            },
          ),
          const SizedBox(
            height: 30,
          ),
          Text(_selectedAnimal ?? 'Type something (a, b, c, etc)'),
        ],
      ),
    );
  }
}
