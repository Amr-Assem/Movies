import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/Empty.png',
            width: 124,
            height: 124,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          Text(
            'Search Screen',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white10),
          ),
        ],
      ),
    );
  }
}
