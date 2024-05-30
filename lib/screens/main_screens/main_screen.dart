import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interior_application/core/consts.dart';

import 'bottom_nav_tabs/home/home_screen.dart';
import 'bottom_nav_tabs/messages/messages_screen.dart';
import 'bottom_nav_tabs/projects/projects_screen.dart';

class MainScreen extends StatefulWidget {
  final int firstOpenedIndex;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const MainScreen({
    super.key,
    this.firstOpenedIndex = 0,
    required this.scaffoldKey,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  onItemTapped(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    selectedIndex = widget.firstOpenedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> bottomListWidget = [
      HomeScreen(
        scaffoldKey: widget.scaffoldKey,
      ),
      const ProjectsScreen(),
      const MessagesScreen(),
    ];
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: bottomListWidget[selectedIndex],
        bottomNavigationBar: SizedBox(
          height: 45,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            backgroundColor: mainAppColorOne,
            selectedLabelStyle: const TextStyle(
              color: whiteColor,
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(
              color: whiteColor,
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
            selectedItemColor: whiteColor,
            unselectedItemColor: whiteColor,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                label: "Discover",
                icon: SvgPicture.asset(
                  "assets/app_icons/discover.svg",
                ),
              ),
              BottomNavigationBarItem(
                label: "My Projects",
                icon: SvgPicture.asset(
                  "assets/app_icons/projects.svg",
                ),
              ),
              BottomNavigationBarItem(
                label: "Messages",
                icon: SvgPicture.asset(
                  "assets/app_icons/message.svg",
                ),
              ),
            ],
            currentIndex: selectedIndex,
            onTap: onItemTapped,
          ),
        ),
        floatingActionButton: selectedIndex == 1 || selectedIndex == 2
            ? FloatingActionButton(
                onPressed: () {},
                backgroundColor: mainAppColorOne,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                child: SvgPicture.asset("assets/app_icons/edit.svg"),
              )
            : const SizedBox(),
      ),
    );
  }
}
