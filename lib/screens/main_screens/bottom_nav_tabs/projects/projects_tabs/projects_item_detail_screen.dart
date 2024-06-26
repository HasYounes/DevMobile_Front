import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:interior_application/config.dart';
import 'package:interior_application/core/button_widget.dart';
import 'package:interior_application/core/clickable_widget.dart';
import 'package:interior_application/core/consts.dart';
import 'package:interior_application/screens/main_screens/main_screen.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../home/home_tabs/designer_profile_screen.dart';
import '../projects_widget.dart';

class ProjectsItemDetailScreen extends StatefulWidget {
  const ProjectsItemDetailScreen(
      {super.key, required this.designer, required this.projectDraft});
  final dynamic projectDraft;
  final int designer;

  @override
  State<ProjectsItemDetailScreen> createState() =>
      _ProjectsItemDetailScreenState();
}

class _ProjectsItemDetailScreenState extends State<ProjectsItemDetailScreen> {
  double total = 0;
  @override
  Widget build(BuildContext context) {
    if (widget.projectDraft == null ||
        widget.projectDraft["name"] == null ||
        widget.projectDraft["description"] == null ||
        widget.projectDraft["tasks"] == null) {
      return const Center(child: Text("Invalid project draft"));
    }
    for (var i = 0; i < widget.projectDraft["tasks"].length; i++) {
      var price = widget.projectDraft["tasks"][i]["price"];
      total += price.runtimeType == double ? price : double.parse(price);
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Column(
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
                child: Theme(
                  data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                  ),
                  child: ListTile(
                    minLeadingWidth: 0,
                    contentPadding: EdgeInsets.zero,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    leading: SvgPicture.asset(
                      "assets/app_icons/back_arrow.svg",
                      colorFilter: const ColorFilter.mode(
                        whiteColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    title: Text(
                      widget.projectDraft["name"].toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // trailing: SvgPicture.asset(
                    //   "assets/app_icons/menu2.svg",
                    //   colorFilter: const ColorFilter.mode(
                    //     whiteColor,
                    //     BlendMode.srcIn,
                    //   ),
                    // ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: dp),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListTile(
                            minLeadingWidth: 0,
                            contentPadding: EdgeInsets.zero,
                            title: const Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    "Progress",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: blackColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Johnathan",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: blackColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Row(
                              children: <Widget>[
                                const Expanded(
                                  child: Text(
                                    "Online",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      color: blackColor,
                                      fontSize: 8,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                SvgPicture.asset("assets/app_icons/online.svg"),
                              ],
                            ),
                            trailing: InkWellWidget(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        DesignerProfileScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                height: 42,
                                width: 42,
                                decoration: const BoxDecoration(
                                  color: whiteColor,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                        "assets/app_images/person3.png"),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 18,
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 15, bottom: 20),
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xFF686868),
                                width: 0.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4.6,
                                  offset: const Offset(0, 0),
                                  color: blackColor.withOpacity(.25),
                                )
                              ],
                            ),
                            child: LinearPercentIndicator(
                              padding: EdgeInsets.zero,
                              lineHeight: 18,
                              barRadius: const Radius.circular(10),
                              percent: 1,
                              center: const Text(
                                "pending ..",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              backgroundColor: whiteColor,
                              progressColor: greenColor,
                            ),
                          ),
                          Center(
                            child: Container(
                              height: 1,
                              width: 180,
                              color: const Color(0xFFDFDFDF),
                              margin: const EdgeInsets.only(bottom: 10),
                            ),
                          ),
                          const Text(
                            "Description",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFFBDBDBD),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: blackColor.withOpacity(.25),
                                  offset: const Offset(0, 4),
                                )
                              ],
                            ),
                            child: RichText(
                              text: TextSpan(
                                text: widget.projectDraft["description"],
                                style: const TextStyle(
                                  height: 2,
                                  color: blackColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                ),
                                children: const <TextSpan>[
                                  TextSpan(
                                    text: 'Plus',
                                    style: TextStyle(
                                      height: 2,
                                      color: mainAppColorOne,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 22,
                      width: double.infinity,
                      color: const Color(0xFFD9D9D9),
                      padding: const EdgeInsets.symmetric(horizontal: dp),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Tasks",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color(0xFF57626E),
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(dp, 0, dp, dp),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: widget.projectDraft["tasks"].length,
                              itemBuilder: (itemBuilder, index) {
                                return TasksItemsWidget(
                                    title: widget.projectDraft["tasks"][index]
                                        ["name"],
                                    subTitle: widget.projectDraft["tasks"]
                                        [index]["description"],
                                    amount:
                                        "US\$${widget.projectDraft["tasks"][index]["price"]}");
                              }),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Expanded(
                                child: Text(
                                  "Total:",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Color(0xFF1B1A57),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                "US\$$total",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: blackColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          ButtonWidget(
                            text: "Validate",
                            height: 36,
                            width: 120,
                            fontSize: 16,
                            elevation: 8,
                            fontWeight: FontWeight.w600,
                            onPressed: () {
                              () async {
                                var response = await post(
                                    Uri.parse(
                                        'http://${Config.urlAuthority}/projects/create'),
                                    headers: {
                                      "Content-type": "application/json",
                                      "Authorization": Config.jwt
                                    },
                                    body: jsonEncode({
                                      "name": widget.projectDraft["name"],
                                      "description":
                                          widget.projectDraft["description"],
                                      "designer": widget.designer,
                                      "tasks": widget.projectDraft["tasks"]
                                    }));
                                if (jsonDecode(response.body)["status"] ==
                                    true) {
                                  //Navigator.pop(context);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => MainScreen(
                                            scaffoldKey: GlobalKey(),
                                            firstOpenedIndex: 1,
                                          )));
                                }
                                print(jsonDecode(response.body)["status"]);
                              }();
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
