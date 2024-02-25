import 'package:SnapTrash/locationModule.dart';
import 'package:SnapTrash/pages/admin/adminHomePage.dart';
import 'package:SnapTrash/pages/admin/reportHistory.dart';
import 'package:SnapTrash/pages/admin/reportMap.dart';
import 'package:SnapTrash/pages/cameraScreen.dart';
import 'package:SnapTrash/pages/loginSignin/logout/logout.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:SnapTrash/pages/leaderBoard.dart';
import 'package:SnapTrash/pages/localReports.dart';
import 'package:SnapTrash/properties/colourProp.dart';

class AdminNavBar extends StatefulWidget {
  const AdminNavBar({super.key});

  @override
  State<AdminNavBar> createState() => _AdminNavBarState();
}

class _AdminNavBarState extends State<AdminNavBar> {
  int _selectedIndex = 1;

  void _navigateBottomBar(int index) {
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }

  static const List<Widget> _widgetOptions = <Widget>[
    AdminMap(),
    AdminHomePage(),
    AdminReportHistory(),
  ];

  @override
  Widget build(BuildContext context) {
    // size variable
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: rang6,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Stack(children: [
        Container(
          clipBehavior: Clip.none,
          height: screenheight * 0.12,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: rang6,
          ),
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.01),
            child: Container(
              // height: screenheight * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: rang6Light,
              ),
              child: GNav(
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(
                    () {
                      _selectedIndex = index;
                    },
                  );
                },
                rippleColor:
                    rangBackground, // tab button ripple color when pressed
                hoverColor: rang7, // tab button hover color
                haptic: true, // haptic feedback
                tabBorderRadius: 25,
                textSize: screenWidth * 0.90,
                // tabActiveBorder:
                //     Border.all(color: rang7, width: 10), // tab button border
                // tabBorder:
                //     Border.all(color: prop.rang5, width: 1), // tab button border
                // tabShadow: [
                //   BoxShadow(color: prop.rang1, blurRadius: 2)
                // ], // tab button shadow
                curve: Curves.easeInCubic, // tab animation curves
                // duration:
                //     Duration(milliseconds: 1000), // tab animation duration
                gap: 5, // the tab button gap between icon and text
                // color: prop.rang6, // unselected icon color
                // activeColor: prop.rang1, // selected icon and text color
                iconSize: screenWidth * 0.1, // tab button icon size
                tabBackgroundColor:
                    rang6Light2, // selected tab background color
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenheight * 0.02,
                ), // navigation bar padding
                tabs: [
                  GButton(
                    iconActiveColor: rang7,
                    iconColor: rang7,
                    icon: Icons.map_outlined,
                    textColor: rang7,
                    text: 'Map',
                    textSize: screenheight,
                  ),
                  const GButton(
                    iconActiveColor: rang7,
                    iconColor: rang7,
                    icon: Icons.report_gmailerrorred,
                    textColor: rang7,
                    text: 'Dashboard',
                  ),
                  const GButton(
                    iconActiveColor: rang7,
                    iconColor: rang7,
                    icon: Icons.history,
                    textColor: rang7,
                    text: 'Reports',
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
