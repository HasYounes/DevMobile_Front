import 'dart:io';

import 'package:flutter/material.dart';
import 'package:interior_application/core/consts.dart';

//profile widget...
class ProfileWidget extends StatelessWidget {
  final String name, email;


  const ProfileWidget({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 45,
          width: 45,
          margin: const EdgeInsets.only(right: 10),
          decoration: const BoxDecoration(
            color: whiteColor,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(
                "assets/app_images/person1.png",
              ),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  color: whiteColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                email,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  color: whiteColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
