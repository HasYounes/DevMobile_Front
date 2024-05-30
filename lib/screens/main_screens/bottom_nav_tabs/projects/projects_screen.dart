import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interior_application/core/consts.dart';

import '../home/home_widget.dart';
import 'projects_tabs/projects_item_detail_screen.dart';
import 'projects_widget.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 60,
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.fromLTRB(dp, 0, dp, 0),
          decoration: const BoxDecoration(
            color: mainAppColorOne,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Center(
            child: ListTile(
              minLeadingWidth: 0,
              contentPadding: EdgeInsets.zero,
              // visualDensity: const VisualDensity(vertical: -4),
              title: const Text(
                "My Projects",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: whiteColor,

                  // color: Color(0xFFE0E5ED),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: SvgPicture.asset(
                "assets/app_icons/search.svg",
                colorFilter: const ColorFilter.mode(
                  whiteColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
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
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    primary: false,
                    shrinkWrap: true,
                    itemCount: 10,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    itemBuilder: (BuildContext context, int index) {
                      return ProjectItemsWidget(
                        image: "assets/app_images/items2.jpg",
                        title: "Project 1",
                        subTitle: "Designer 2",
                        value: index == 2 ? 1 : 0.7,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const ProjectsItemDetailScreen(),
                            ),
                          );
                        },
                      );
                    },
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
