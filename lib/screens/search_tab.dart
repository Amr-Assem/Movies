import 'package:flutter/material.dart';
import 'package:movies_app/core/app_assets.dart';

class SearchTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 370,
              height: 50,
              decoration: BoxDecoration(
                color: AppAssets.gray,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(Icons.search, color: AppAssets.white),
                  ),
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: AppAssets.white),
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(color: AppAssets.gray),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Image.asset(
            AppAssets.emptySearch,
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
