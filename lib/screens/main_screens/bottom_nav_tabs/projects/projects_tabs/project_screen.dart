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

class ProjectDetails extends StatefulWidget {
  const ProjectDetails({super.key, required this.project});
  final dynamic project;

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  double total = 0;
  List<TasksItemsWidget> selected = [];
  List<bool> taskSelections = [];
  bool isAnyTaskSelected = false;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.project["tasks"].length; i++) {
      total += double.parse(widget.project["tasks"][i]["price"]);
      taskSelections.add(false);
    }
  }

  void _updateTaskSelection(int index, bool? value) {
    setState(() {
      taskSelections[index] = value ?? false;
      isAnyTaskSelected = taskSelections.contains(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.project == null ||
        widget.project["name"] == null ||
        widget.project["description"] == null ||
        widget.project["tasks"] == null ||
        widget.project["id"] == null) {
      return const Center(child: Text("Invalid project draft"));
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
                      widget.project["name"].toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //     builder: (BuildContext context) =>
                                //         DesignerProfileScreen(),
                                //   ),
                                // );
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
                              percent:
                                  double.parse(widget.project["progress"]) /
                                      100,
                              center: Text(
                                "${double.parse(widget.project['progress'])}%",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: blackColor,
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
                                text: widget.project["description"],
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
                            itemCount: widget.project["tasks"].length,
                            itemBuilder: (itemBuilder, index) {
                              return Row(
                                children: <Widget>[
                                  if (Config.usertype == "designer")
                                    Checkbox(
                                        value: taskSelections[index],
                                        onChanged: (value) {
                                          _updateTaskSelection(index, value);
                                          setState(() {
                                            selected.add(TasksItemsWidget(
                                              id: widget.project["tasks"][index]
                                                  ["id"],
                                              title: widget.project["tasks"]
                                                  [index]["name"],
                                              subTitle: widget.project["tasks"]
                                                  [index]["description"],
                                              amount:
                                                  "US\$${widget.project["tasks"][index]["price"]}",
                                            ));
                                          });
                                        }),
                                  Expanded(
                                    child: TasksItemsWidget(
                                      title: widget.project["tasks"][index]
                                          ["name"],
                                      subTitle: widget.project["tasks"][index]
                                          ["description"],
                                      amount:
                                          "US\$${widget.project["tasks"][index]["price"]}",
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
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
                          if (Config.usertype == "designer")
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: ElevatedButton(
                                onPressed: isAnyTaskSelected
                                    ? () async {
                                        var payload = {
                                          "project": widget.project["id"],
                                          "tasks": selected
                                              .map((e) => {"id": e.id})
                                              .toList()
                                        };
                                        post(
                                                Uri.http(Config.urlAuthority,
                                                    '/tasks/update'),
                                                headers: {
                                                  "Content-type":
                                                      "application/json",
                                                  "Authorization": Config.jwt
                                                },
                                                body: jsonEncode(payload))
                                            .then((value) {
                                          print(value.body);
                                          if (jsonDecode(
                                                  value.body)["status"] ==
                                              true) {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MainScreen(
                                                          scaffoldKey:
                                                              GlobalKey(),
                                                          firstOpenedIndex: 1,
                                                        )));
                                          }
                                        });
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  // primary: mainAppColorOne,
                                  // onPrimary: whiteColor,
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                child: const Text("Update"),
                              ),
                            ),
                        ],
                      ),
                    ),
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
