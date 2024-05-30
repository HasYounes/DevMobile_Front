// import 'package:flutter/material.dart';
// import 'package:interior_application/core/consts.dart';
// import 'package:interior_application/screens/initial_screens/login/login_screen.dart';
//
// import 'side_menu_widget.dart';
//
// class SideMenu extends StatefulWidget {
//   const SideMenu({
//     super.key,
//   });
//
//   @override
//   State<SideMenu> createState() => _SideMenuState();
// }
//
//
// class _SideMenuState extends State<SideMenu> {
//
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     return Container(
//       height: double.infinity,
//       width: width / 1.12,
//       color: whiteColor,
//       child: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Container(
//                 height: 170,
//                 color: mainAppColorOne,
//                 padding: const EdgeInsets.fromLTRB(dp, 0, dp, 20),
//                 margin: const EdgeInsets.only(bottom: 30),
//                 child: const Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     ProfileWidget(
//                       name: "Soufiane Harzane",
//                       email: "soufianeharzane@gmail.com",
//                     ),
//                   ],
//                 ),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   const SizedBox(height: 10),
//                   slideMenuItem(
//                     title: "My Projects",
//                     id: 0,
//                   ),
//                   slideMenuItem(
//                     title: "Inbox",
//                     id: 1,
//                   ),
//                   slideMenuItem(
//                     title: "Privacy Policy",
//                     id: 2,
//                   ),
//                   slideMenuItem(
//                     title: "Logout",
//                     id: 3,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget slideMenuItem({
//     required int id,
//     int? itemCount,
//     String? title,
//   }) {
//     return InkWell(
//       onTap: () {
//         if (id == 0) {
//           // context.read<HomeBloc>().add(const DoSelectDrawerEvent(0));
//           Navigator.maybePop(context);
//         } else if (id == 1) {
//           // context.read<HomeBloc>().add(const DoSelectDrawerEvent(1));
//           Navigator.maybePop(context);
//         } else if (id == 2) {
//           // context.read<HomeBloc>().add(const DoSelectDrawerEvent(2));
//           Navigator.maybePop(context);
//         } else if (id == 3) {
//           // context.read<HomeBloc>().add(const DoSelectDrawerEvent(3));
//           Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(
//                 builder: (BuildContext context) => const LoginScreen(),
//               ),
//               (route) => false);
//         }
//         // else if (id == 4) {
//         //   context.read<HomeBloc>().add(const DoSelectDrawerEvent(4));
//         //   Navigator.maybePop(context);
//         // } else if (id == 5) {
//         //   context.read<HomeBloc>().add(const DoSelectDrawerEvent(5));
//         //   Navigator.maybePop(context);
//         // } else if (id == 6) {
//         //   context.read<HomeBloc>().add(const DoSelectDrawerEvent(6));
//         //   Navigator.maybePop(context);
//         // } else if (id == 7) {
//         //   context.read<HomeBloc>().add(const DoSelectDrawerEvent(7));
//         //   Navigator.maybePop(context);
//         // } else if (id == 8) {
//         //   context.read<HomeBloc>().add(const DoSelectDrawerEvent(8));
//         //   Navigator.maybePop(context);
//         // } else if (id == 9) {
//         //   context.read<HomeBloc>().add(const DoSelectDrawerEvent(9));
//         //   Navigator.maybePop(context);
//         // }
//       },
//       child: Container(
//         height: 40,
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         decoration: BoxDecoration(
//           color: id == 0 ? mainAppColorOne : whiteColor,
//         ),
//         child: Align(
//           alignment: Alignment.centerLeft,
//           child: Text(
//             title!,
//             style: TextStyle(
//               color: id == 0
//                   ? whiteColor
//                   : id == 3
//                       ? alertColor
//                       : blackColor,
//               fontSize: 14,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//       ),
//       // BlocBuilder<HomeBloc, HomeState>(
//       //   builder: (context, state) {
//       //     bool isActive;
//       //     if (state.index == id) {
//       //       isActive = true;
//       //     } else {
//       //       isActive = false;
//       //     }
//       //     return Container(
//       //       height: 40,
//       //       padding: const EdgeInsets.symmetric(horizontal: 20),
//       //       decoration: BoxDecoration(
//       //         color: isActive ? listItemsColor : mainAppColor,
//       //       ),
//       //       child: Row(
//       //         mainAxisSize: MainAxisSize.max,
//       //         children: <Widget>[
//       //           SvgPicture.asset(
//       //             iconSrc!,
//       //             height: 18,
//       //             width: 18,
//       //             colorFilter: const ColorFilter.mode(
//       //               whiteColor,
//       //               BlendMode.srcIn,
//       //             ),
//       //           ),
//       //           const SizedBox(width: 22),
//       //           Expanded(
//       //             child: Text(
//       //               title!,
//       //               style: const TextStyle(
//       //                 color: whiteColor,
//       //                 fontSize: 14,
//       //                 fontWeight: FontWeight.w600,
//       //               ),
//       //             ),
//       //           )
//       //         ],
//       //       ),
//       //     );
//       //   },
//       // ),
//     );
//   }
// }
