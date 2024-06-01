import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:interior_application/core/consts.dart';
import 'package:interior_application/riverpod/messages_provider.dart';
import 'package:interior_application/socket/Message.dart';

import '../home/home_widget.dart';
import '../projects/projects_widget.dart';
import 'messages_tabs/chat_screen.dart';
import 'messages_widget.dart';

class MessagesScreen extends ConsumerWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapasync = ref.read(messagesProvider.notifier).initializeMessages;

    int selectedIndex = 0;
    return FutureBuilder(
        future: mapasync(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child:
                    CircularProgressIndicator()); // Show a loading indicator while waiting
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Handle errors
          } else {
            // The Future completed successfully
            final map = snapshot.data;
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
                      title: const Text(
                        "Recent Chats",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: whiteColor,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              OptionWidget(
                                title: "All chats",
                                isSelected: selectedIndex == 0 ? true : false,
                                onTap: () {
                                  selectedIndex = 0;
                                },
                              ),
                              OptionWidget(
                                title: "Groups",
                                isSelected: selectedIndex == 2 ? true : false,
                                onTap: () {
                                  selectedIndex = 2;
                                },
                              ),
                            ],
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            primary: false,
                            shrinkWrap: true,
                            itemCount: map!.length,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            itemBuilder: (BuildContext context, int index) {
                              print("map = ${map}");
                              final mapKeys = map.keys.toList();
                              final currentKey = mapKeys[index];
                              var quantity = 0;
                              if (map[currentKey] != null) {
                                quantity = map[currentKey]!
                                    .where(
                                        (element) => element.status != "read")
                                    .length;
                              }

                              return FutureBuilder(future: () async {
                                // var response = await post(
                                //     Uri.parse(
                                //         "${Config.urlAuthority}/designers/getbydiscid"),
                                //     headers: {
                                //       "Authorization": Config.jwt
                                //     },body: jsonEncode({
                                //       "disc_id" : currentKey
                                //     }));
                                // var body = jsonDecode(response.body);
                                // return body["fullname"].toString();
                                return 1;
                              }(), builder: (context, snap) {
                                return MessagesItemsWidget(
                                  disc_id: currentKey,
                                  image: "assets/app_images/person3.png",
                                  isUnread: index == 0 ? true : false,
                                  title: "designer",
                                  time: map[currentKey]![0]
                                      .time!
                                      .toIso8601String(),
                                  subTitle: map[map.keys.toList()[index]]![0]
                                      .content!,
                                  quantity: quantity,
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            ChatScreen(disc_id: currentKey),
                                      ),
                                    );
                                  },
                                );
                              });
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
        }));

    // return mapasync.when(
    //     error: (error, stackTrace) =>
    //         const Center(child: Text("shit happens !")),
    //     loading: () => const CircularProgressIndicator(),
    //     data: (map) =>
    //     Column(
    //           children: <Widget>[
    //             Container(
    //               height: 60,
    //               margin: const EdgeInsets.only(bottom: 20),
    //               padding: const EdgeInsets.fromLTRB(dp, 0, dp, 0),
    //               decoration: const BoxDecoration(
    //                 color: mainAppColorOne,
    //                 borderRadius: BorderRadius.only(
    //                   bottomLeft: Radius.circular(10),
    //                   bottomRight: Radius.circular(10),
    //                 ),
    //               ),
    //               child: Center(
    //                 child: ListTile(
    //                   minLeadingWidth: 0,
    //                   contentPadding: EdgeInsets.zero,
    //                   title: const Text(
    //                     "Recent Chats",
    //                     maxLines: 1,
    //                     overflow: TextOverflow.ellipsis,
    //                     style: TextStyle(
    //                       color: whiteColor,
    //                       fontSize: 20,
    //                       fontWeight: FontWeight.w600,
    //                     ),
    //                   ),
    //                   trailing: SvgPicture.asset(
    //                     "assets/app_icons/search.svg",
    //                     colorFilter: const ColorFilter.mode(
    //                       whiteColor,
    //                       BlendMode.srcIn,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             Expanded(
    //               child: SingleChildScrollView(
    //                 child: Padding(
    //                   padding: const EdgeInsets.symmetric(horizontal: dp),
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: <Widget>[
    //                       Row(
    //                         children: <Widget>[
    //                           OptionWidget(
    //                             title: "All chats",
    //                             isSelected: selectedIndex == 0 ? true : false,
    //                             onTap: () {
    //                               selectedIndex = 0;
    //                             },
    //                           ),
    //                           OptionWidget(
    //                             title: "Groups",
    //                             isSelected: selectedIndex == 2 ? true : false,
    //                             onTap: () {
    //                               selectedIndex = 2;
    //                             },
    //                           ),
    //                         ],
    //                       ),
    //                       ListView.builder(
    //                         physics: const NeverScrollableScrollPhysics(),
    //                         primary: false,
    //                         shrinkWrap: true,
    //                         itemCount: map.length,
    //                         padding: const EdgeInsets.symmetric(vertical: 20),
    //                         itemBuilder: (BuildContext context, int index) {
    //                           print("map = ${map}");
    //                           final mapKeys = map.keys.toList();
    //                           final currentKey = mapKeys[index];
    //                           var quantity = 0;
    //                           if (map[currentKey] != null) {
    //                             quantity = map[currentKey]!
    //                                 .where(
    //                                     (element) => element.status != "read")
    //                                 .length;
    //                           }

    //                           return MessagesItemsWidget(
    //                             disc_id: currentKey,
    //                             image: "assets/app_images/person3.png",
    //                             isUnread: index == 0 ? true : false,
    //                             title: "Johnathan ",
    //                             time:
    //                                 map[currentKey]![0].time!.toIso8601String(),
    //                             subTitle:
    //                                 map[map.keys.toList()[index]]![0].content!,
    //                             quantity: quantity,
    //                             onTap: () {
    //                               Navigator.of(context).push(
    //                                 MaterialPageRoute(
    //                                   builder: (BuildContext context) =>
    //                                       ChatScreen(disc_id: currentKey),
    //                                 ),
    //                               );
    //                             },
    //                           );
    //                         },
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ));
  }
}
