import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interior_application/core/button_widget.dart';
import 'package:interior_application/core/clickable_widget.dart';
import 'package:interior_application/core/consts.dart';

//messages items widget...
class MessagesItemsWidget extends StatelessWidget {
  final String image, title, subTitle, time;
  final int disc_id, quantity;
  final bool isUnread;
  final Function()? onTap;

  const MessagesItemsWidget({
    super.key,
    required this.disc_id,
    required this.image,
    required this.title,
    required this.subTitle,
    this.onTap,
    required this.time,
    required this.quantity,
    required this.isUnread,
  });

  @override
  Widget build(BuildContext context) {
    return InkWellWidget(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color:
              isUnread ? const Color(0xFF2F80ED).withOpacity(.10) : whiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          minLeadingWidth: 0,
          contentPadding: EdgeInsets.zero,
          leading: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: blackColor,
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(image),
              ),
            ),
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF1B1A57),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                time,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: const Color(0xFF333333).withOpacity(.60),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          subtitle: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  subTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF4F5E7B),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              if (quantity > 0)
                Container(
                  height: 24,
                  width: 24,
                  decoration: const BoxDecoration(
                    color: mainAppColorOne,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      quantity > 10 ? "10+" : quantity.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: whiteColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
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

//message widget...
class MessageWidget extends StatelessWidget {
  final String message, time, image;
  final bool isSent,
      isShoTime,
      isShowProfileClient,
      isShowProfileSent,
      isShowProjectDraft;

  const MessageWidget({
    super.key,
    required this.message,
    required this.time,
    required this.isSent,
    this.isShoTime = true,
    this.isShowProfileClient = true,
    this.isShowProfileSent = true,
    this.isShowProjectDraft = false,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment:
            isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          if (isSent == false)
            isShowProfileClient
                ? Stack(
                    children: <Widget>[
                      Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: blackColor,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(image),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                            color: const Color(0xFF4CE417),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: whiteColor,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(width: 48),
          const SizedBox(width: 10),
          isShowProjectDraft
              ? Flexible(
                  child: Container(
                    height: 116,
                    margin: EdgeInsets.only(
                      right: isSent ? 0 : 20,
                      left: isSent ? 20 : 0,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F3F3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        const Text(
                          "Project draft",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color(0xFF1B1A57),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Container(
                          height: 1,
                          color: const Color(0xFFD7D7D7),
                        ),
                        ButtonWidget(
                          text: "See",
                          height: 36,
                          width: 100,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                )
              : Flexible(
                  child: Container(
                    margin: EdgeInsets.only(
                      right: isSent ? 0 : 20,
                      left: isSent ? 20 : 0,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSent ? mainAppColorOne : const Color(0xFFF7F7F7),
                      borderRadius: isSent
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            )
                          : const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Text(
                          message,
                          style: TextStyle(
                            color: isSent ? whiteColor : blackColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        if (isShoTime) const SizedBox(height: 10),
                        if (isShoTime)
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              time,
                              style: TextStyle(
                                color: isSent
                                    ? whiteColor
                                    : const Color(0xFFA1A1BC),
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
          if (isSent)
            if (isShowProfileSent)
              Stack(
                children: <Widget>[
                  Container(
                    height: 48,
                    width: 48,
                    margin: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: blackColor,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(image),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CE417),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: whiteColor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
        ],
      ),
    );
  }
}
