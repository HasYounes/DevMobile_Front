// import 'package:flutter/material.dart';
// import 'package:interior_application/core/consts.dart';
// import 'package:interior_application/screens/main_screens/main_screen.dart';
//
// import 'side_menu/side_menu.dart';
//
// class DrawerHomeScreen extends StatefulWidget {
//   final int index;
//
//   const DrawerHomeScreen({super.key, required this.index});
//
//   @override
//   State<DrawerHomeScreen> createState() => _DrawerHomeScreenState();
// }
//
// class _DrawerHomeScreenState extends State<DrawerHomeScreen> {
//   final GlobalKey<ScaffoldState> _key = GlobalKey();
//
//   @override
//   Widget build(BuildContext context) {
//     final List<Map<String, Widget>> drawerPages = [
//       {
//         "Home": MainScreen(
//           scaffoldKey: _key,
//         )
//       },
//     ];
//     double width = MediaQuery.of(context).size.width;
//     return SafeArea(
//       child: Scaffold(
//         key: _key,
//         backgroundColor: whiteColor,
//         endDrawer: ConstrainedBox(
//           constraints: BoxConstraints(
//             maxWidth: width / 1.12,
//           ),
//           child: const SideMenu(),
//         ),
//         body: drawerPages[widget.index].values.first,
//       ),
//     );
//   }
// }
