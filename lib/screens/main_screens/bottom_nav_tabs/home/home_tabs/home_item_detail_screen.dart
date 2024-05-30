import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interior_application/core/clickable_widget.dart';
import 'package:interior_application/core/consts.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'designer_profile_screen.dart';

class HomeItemDetailScreen extends StatefulWidget {
  const HomeItemDetailScreen({super.key});

  @override
  State<HomeItemDetailScreen> createState() => _HomeItemDetailScreenState();
}

class _HomeItemDetailScreenState extends State<HomeItemDetailScreen> {
  @override
  Widget build(BuildContext context) {
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
                child: ListTile(
                  minLeadingWidth: 0,
                  contentPadding: EdgeInsets.zero,
                  leading: InkWellWidget(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      "assets/app_icons/back_arrow.svg",
                      colorFilter: const ColorFilter.mode(
                        whiteColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  title: InkWellWidget(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Project name",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  trailing: SvgPicture.asset(
                    "assets/app_icons/menu2.svg",
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
                                image:
                                    AssetImage("assets/app_images/person1.png"),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 18,
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 15, bottom: 26),
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
                          percent: 0.6,
                          center: const Text(
                            "60%",
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
                      const Text(
                        "Photos",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 26),
                      Row(
                        children: <Widget>[
                          IconButtonWidget(
                            padding: const EdgeInsets.only(right: 2),
                            icon: Image.asset(
                              height: 30,
                              width: 40,
                              "assets/app_images/left_side.png",
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 140,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                      "assets/app_images/items1.jpg"),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color: blackColor.withOpacity(.25),
                                    offset: const Offset(0, 4),
                                  )
                                ],
                              ),
                            ),
                          ),
                          IconButtonWidget(
                            padding: const EdgeInsets.only(left: 2),
                            icon: Image.asset(
                              height: 30,
                              width: 40,
                              "assets/app_images/right_side.png",
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 26),
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
                        margin: const EdgeInsets.symmetric(vertical: 26),
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
                        child: const Text(
                          "Ce salon est un espace chaleureux et accueillant, parfait pour se détendre et passer du temps avec ses proches. Il est meublé avec des pièces confortables et élégantes, et décoré avec des touches de couleur et de texture.",
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
