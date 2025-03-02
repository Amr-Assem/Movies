<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/app_assets.dart';
import 'package:movies_app/screens/home_tab.dart';
import 'screens/browse_tab.dart';
import 'screens/search_tab.dart';
import 'screens/profile_tab.dart';
=======

import 'package:flutter/material.dart';

import 'screens/brawse.dart';
import 'screens/home.dart';
import 'screens/profile.dart';
import 'screens/search.dart';


>>>>>>> feature-branch

class MainScreen extends StatefulWidget {
  static const String routeName = "Home";

  @override
<<<<<<< HEAD
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeTab(),
    SearchTab(),
    BrowseTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(child: _screens[_selectedIndex]),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(12),
              child: Container(
                decoration: BoxDecoration(
                  color: AppAssets.gray,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: BottomNavigationBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.grey,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  currentIndex: _selectedIndex,
                  onTap: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  items: [
                    _buildNavItem(AppAssets.home, 'Home'),
                    _buildNavItem(AppAssets.search, 'Search'),
                    _buildNavItem(AppAssets.browse, 'Browse'),
                    _buildNavItem(AppAssets.profile, 'Profile'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(String iconPath, String label) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        iconPath,
        colorFilter: ColorFilter.mode(
          AppAssets.white,
          BlendMode.srcIn,
        ),
      ),
      activeIcon: SvgPicture.asset(
        iconPath,
        colorFilter: ColorFilter.mode(
          AppAssets.primary,
          BlendMode.srcIn,
        ),
      ),
      label: '',
=======
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Start with Home selected (index 0)
  bool _showSearch = false; // Track whether to show the search bar

  // قائمة الشاشات بعد الفصل
  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    SearchScreen(),
    BrowseScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _showSearch = index == 1; // Show search bar only when Search is selected
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: _showSearch
            ? Center(
          child: Container(
            width: 370,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF282828),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(Icons.search, color: Colors.white),
                ),
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
            : const Text(
          "Movie App",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(top: 10, right: 10, left: 10),
        color: Color(0xFF282828), // اللون الخلفي للسماوي
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // تثبيت اللون
          backgroundColor: Color(0xFF282828), // اللون الخلفي
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Browse',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.yellow,
          unselectedItemColor: Colors.white,
          onTap: _onItemTapped,
        ),
      ),
>>>>>>> feature-branch
    );
  }
}
