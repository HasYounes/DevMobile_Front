import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interior_application/core/consts.dart';
import 'package:interior_application/riverpod/messages_provider.dart';
import 'package:interior_application/riverpod/socketserviceprovider.dart';
import 'package:interior_application/riverpod/user_id_provider.dart';
import 'package:interior_application/screens/main_screens/bottom_nav_tabs/messages/messages_tabs/scroll_controller.dart';
import 'package:interior_application/socket/Message.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../messages_widget.dart';

class ChatScreen extends ConsumerWidget {
  ChatScreen({super.key, required this.disc_id});
  final TextEditingController mySearchController = TextEditingController();
  final int disc_id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var msgs = ref.watch(messagesProvider)[disc_id]!;
    var user_id_from_pref = ref.watch(UserIdNotifierProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 400),
          ScrollControllerSingleton().scrollToBottom);
    });
    return Scaffold(
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(dp, 40, dp, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
              ),
              child: ListTile(
                onTap: () {
                  Navigator.pop(context);
                },
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                visualDensity: const VisualDensity(vertical: -4),
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SvgPicture.asset(
                      "assets/app_icons/back_arrow.svg",
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF4F5E7B),
                        BlendMode.srcIn,
                      ),
                    ),
                    Container(
                      height: 48,
                      width: 48,
                      margin: const EdgeInsets.only(left: 10),
                      decoration: const BoxDecoration(
                        color: blackColor,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/app_images/person3.png"),
                        ),
                      ),
                    ),
                  ],
                ),
                title: const Text(
                  "Johnathan",
                  maxLines: 1,
                  style: TextStyle(
                    color: Color(0xFF1B1A57),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                subtitle: const Text(
                  "Online",
                  maxLines: 1,
                  style: TextStyle(
                    color: Color(0xFF4F5E7B),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                trailing: SvgPicture.asset(
                  "assets/app_icons/menu2.svg",
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF4F5E7B),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                  controller: ScrollControllerSingleton().scrollController,
                  itemCount: msgs.length,
                  itemBuilder: ((context, index) {
                    var msg = msgs[index];
                    var isShowDraft = false;
                    if (msg.projectDraft != null) {
                      isShowDraft = true;
                    }

                    return MessageWidget(
                      designer: msg.sender!,
                      isSent: msg.sender == user_id_from_pref ? true : false,
                      message: msgs[index].content!,
                      time:
                          "${msgs[index].time!.hour} : ${msgs[index].time!.minute}",
                      isShowProfileClient: true,
                      isShowProjectDraft: isShowDraft,
                      projectDraft: isShowDraft ? msg.projectDraft : null,
                      image: "assets/app_images/person1.png",
                    );
                  })),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: const BoxDecoration(
                color: whiteColor,
                border: Border(
                  top: BorderSide(
                    color: Color(0xFFDFDFDF),
                    width: 1,
                  ),
                ),
              ),
              child: Center(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 30,
                        width: double.infinity,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDFDFDF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: TextField(
                            controller: mySearchController,
                            textInputAction: TextInputAction.done,
                            style: const TextStyle(
                              color: Color(0xFF252525),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              fillColor: const Color(0xFFDFDFDF),
                              filled: true,
                              hintText: "Tapez un message...",
                              hintStyle: const TextStyle(
                                color: Color(0xFF686868),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(48),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(48),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(48),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.only(
                                left: 20,
                                right: 12,
                                top: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        () async {
                          final msg = {
                            "messages": [
                              {
                                "disc_id": disc_id,
                                "content": mySearchController.text
                              }
                            ]
                          };

                          int id = await SharedPreferences.getInstance().then(
                              (value) => int.parse(value.get("id").toString()));
                          ref.read(socketServiceProvider).send(msg);
                          ref.read(messagesProvider.notifier).addMessage(
                              TempMessage(0, mySearchController.text, 0,
                                  disc_id, id, DateTime.now(), null, null));
                          mySearchController.clear();
                        }();
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                          color: mainAppColorOne,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Image.asset(
                            height: 20,
                            width: 20,
                            "assets/app_images/sent.png",
                          ),
                        ),
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
