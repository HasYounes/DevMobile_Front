import 'package:flutter/material.dart';

import 'consts.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: whiteColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          height: 200,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 30),
          decoration: const BoxDecoration(
            color: mainAppColorOne,
            image: DecorationImage(
              image: AssetImage("assets/trade_clan_icons/trade1.png"),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }
}
