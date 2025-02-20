import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Home Screen',
        style: TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white10),
      ),
    );
  }
}
