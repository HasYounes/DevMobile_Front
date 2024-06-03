import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:interior_application/config.dart';
import 'package:interior_application/core/button_widget.dart';
import 'package:interior_application/core/consts.dart';
import 'package:interior_application/riverpod/messages_provider.dart';
import 'package:interior_application/riverpod/socketserviceprovider.dart';
import 'package:interior_application/screens/main_screens/bottom_nav_tabs/home/home_screen.dart';
import 'package:interior_application/screens/main_screens/bottom_nav_tabs/messages/messages_screen.dart';
import 'package:interior_application/screens/main_screens/bottom_nav_tabs/messages/messages_tabs/chat_screen.dart';
import 'package:interior_application/screens/main_screens/drawer/drawer_screen.dart';
import 'package:interior_application/screens/main_screens/main_screen.dart';
import 'package:interior_application/socket/Message.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../projects/projects_widget.dart';

class DesignerProfileScreen extends ConsumerWidget {
  DesignerProfileScreen(
      {super.key,
      this.id = 21,
      this.name = "jhon",
      this.description =
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum... '});
  String name;
  String description;
  int id;

  @override
  Widget build(context, ref) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: ButtonWidget(
            text: "hire me !",
            height: 40,
            width: 150,
            fontSize: 16,
            elevation: 8,
            fontWeight: FontWeight.w600,
            borderColor: const Color(0xFFDFDFDF),
            onPressed: () {
              () async {
                var response = await post(
                    Uri.parse(
                        "http://${Config.urlAuthority}/discussions/create"),
                    headers: {
                      "Authorization": Config.jwt,
                      "Content-type": "application/json"
                    },
                    body: jsonEncode({"receiver": id, "auth": Config.jwt}));
                var n = ref.read(messagesProvider.notifier);
                var myId = await SharedPreferences.getInstance()
                    .then((insatnce) => int.parse(insatnce.getString("id")!));
                var responseBody = jsonDecode(response.body);
                var map = ref.read(messagesProvider);
                if (!map.containsKey(responseBody["id"])) {
                  map[responseBody["id"]] = [];
                }

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ChatScreen(disc_id: responseBody["id"])));
              }();
            },
          ),
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
                    title: const Text(
                      "Designer Profile",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
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
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                height: 45,
                                width: 45,
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
                              Text(
                                name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: blackColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Image.asset(
                                    height: 15,
                                    width: 15,
                                    "assets/app_images/star1.png",
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    "4.9",
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
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                        const TabBar(
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelStyle: TextStyle(
                            color: mainAppColorOne,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          unselectedLabelStyle: TextStyle(
                            color: Color(0xFF9B9B9B),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          tabs: <Widget>[
                            Tab(
                              text: "À propos",
                            ),
                            Tab(
                              text: "Services",
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Informations sur le designer",
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
                          margin: const EdgeInsets.symmetric(vertical: 10),
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
                              text: description,
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
                        const DesignerItemsWidget(
                          icon: "assets/app_images/location.png",
                          title: "De",
                          subTitle: "Canada",
                        ),
                        const DesignerItemsWidget(
                          icon: "assets/app_images/language.png",
                          title: "Language",
                          subTitle: "Anglais , Francais",
                        ),
                        const DesignerItemsWidget(
                          icon: "assets/app_images/chat.png",
                          title: "Temps de réponse moy.",
                          subTitle: "Anglais , Francais",
                        ),
                        const DesignerItemsWidget(
                          icon: "assets/app_images/eye.png",
                          title: "Dernière activité",
                          subTitle: "Il y a une heure",
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Compétences",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: ButtonWidget(
                                text: "Adobe Photoshop",
                                height: 22,
                                fontSize: 12,
                                elevation: 8,
                                fontWeight: FontWeight.w600,
                                borderColor: const Color(0xFFDFDFDF),
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ButtonWidget(
                                text: "Adobe Illustrator",
                                height: 22,
                                fontSize: 12,
                                elevation: 8,
                                fontWeight: FontWeight.w600,
                                borderColor: const Color(0xFFDFDFDF),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: ButtonWidget(
                                text: "Figma",
                                height: 22,
                                fontSize: 12,
                                elevation: 8,
                                fontWeight: FontWeight.w600,
                                borderColor: const Color(0xFFDFDFDF),
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ButtonWidget(
                                text: "Canva",
                                height: 22,
                                fontSize: 12,
                                elevation: 8,
                                fontWeight: FontWeight.w600,
                                borderColor: const Color(0xFFDFDFDF),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          "154 Avis",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Stack(
                          children: <Widget>[
                            Container(
                              height: 150,
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 20),
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(0xFFF0F0F0),
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
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Image.asset(
                                          height: 27,
                                          width: 32,
                                          "assets/app_images/profile.png",
                                        ),
                                        const SizedBox(width: 5),
                                        const Expanded(
                                          child: Text(
                                            "client name",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: blackColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      "Lorem ipsum dolor sit aidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum... Lorem ipsum dolor sit aidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum...",
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: blackColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: <Widget>[
                                        Image.asset(
                                          height: 16,
                                          width: 20,
                                          "assets/app_images/star1.png",
                                        ),
                                        const SizedBox(width: 5),
                                        const Expanded(
                                          child: Text(
                                            "4.9",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: blackColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
