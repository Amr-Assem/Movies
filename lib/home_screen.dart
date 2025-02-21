import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/core/app_assets.dart';
import 'package:movies_app/screens/home_tab.dart';
import 'screens/browse_tab.dart';
import 'screens/search_tab.dart';
import 'screens/profile_tab.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = "Home";

  @override
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
    );
  }
}
