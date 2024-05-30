import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:interior_application/core/clickable_widget.dart';
import 'package:interior_application/core/consts.dart';
import 'package:interior_application/screens/main_screens/bottom_nav_tabs/home/home_tabs/designer_profile_screen.dart';
import 'package:interior_application/screens/main_screens/bottom_nav_tabs/home/home_tabs/home_item_detail_screen.dart';

import 'home_widget.dart';

class HomeScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const HomeScreen({super.key, required this.scaffoldKey});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController mySearchController = TextEditingController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.fromLTRB(dp, 0, dp, dp),
          decoration: const BoxDecoration(
            color: mainAppColorOne,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                minLeadingWidth: 0,
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  height: 42,
                  width: 42,
                  decoration: const BoxDecoration(
                    color: whiteColor,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/app_images/person1.png"),
                    ),
                  ),
                ),
                title: const Text(
                  "Soufiane Harzane",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: whiteColor,
                    // color: Color(0xFFE0E5ED),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Row(
                  children: <Widget>[
                    SvgPicture.asset("assets/app_icons/online.svg"),
                    const SizedBox(width: 4),
                    const Expanded(
                      child: Text(
                        "Online",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: whiteColor,

                          // color: Color(0xFFE0E5ED),
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                trailing: InkWellWidget(
                  onTap: () {
                    widget.scaffoldKey.currentState!.openEndDrawer();
                  },
                  child: SvgPicture.asset(
                    "assets/app_icons/menu1.svg",
                    colorFilter: const ColorFilter.mode(
                      whiteColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              //search...
              Container(
                height: 36,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF0848A7),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: TextField(
                    controller: mySearchController,
                    textInputAction: TextInputAction.done,
                    style: const TextStyle(
                      color: Color(0xFFE0E5ED),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: InputDecoration(
                      fillColor: const Color(0xFF0848A7),
                      filled: true,
                      hintText: "Search ...",
                      hintStyle: const TextStyle(
                        color: Color(0xFFE0E5ED),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      prefixIcon:
                          SvgPicture.asset("assets/app_icons/search.svg"),
                      prefixIconConstraints: const BoxConstraints(
                        minHeight: 10,
                        minWidth: 55,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.only(
                        left: 20,
                        right: 12,
                        top: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: dp),
              child: Column(
                children: <Widget>[
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        OptionWidget(
                          title: "All projects",
                          isSelected: selectedIndex == 0 ? true : false,
                          onTap: () {
                            setState(() {
                              selectedIndex = 0;
                            });
                          },
                        ),
                        OptionWidget(
                          title: "By date",
                          isSelected: selectedIndex == 2 ? true : false,
                          onTap: () {
                            setState(() {
                              selectedIndex = 2;
                            });
                          },
                        ),
                        OptionWidget(
                          title: "By name",
                          isSelected: selectedIndex == 3 ? true : false,
                          onTap: () {
                            setState(() {
                              selectedIndex = 3;
                            });
                          },
                        ),
                        OptionWidget(
                          title: "by something else",
                          isSelected: selectedIndex == 4 ? true : false,
                          onTap: () {
                            setState(() {
                              selectedIndex = 4;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder(
                    future: get(Uri.parse("http://192.168.1.4/designers/getAll")),
                    builder: (context,snap) {
                      if (snap.connectionState == ConnectionState.done) {
                         return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        primary: false,
                        shrinkWrap: true,
                        itemCount: 3,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        itemBuilder: (BuildContext context, int index) {
                          return DiscoverItemsWidget(
                            itemImage: "assets/app_images/items1.jpg",
                            profile: "assets/app_images/person1.png",
                            title: "Soufiane Harzane",
                            subTitle:
                                "I will make the best design your eyes have ever witnessed, while also giving you the best advice on the market.",
                            value: 3,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      DesignerProfileScreen(
                                          name: "Jonathan",
                                          description: "Lorem ipsum"),
                                ),
                              );
                            },
                          );
                        },
                      );
                    
                      } else {
                        return const Center(child: CircularProgressIndicator(),);
                      }
                     }
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
