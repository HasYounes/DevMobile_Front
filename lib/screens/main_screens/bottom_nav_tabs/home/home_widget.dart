import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interior_application/core/clickable_widget.dart';
import 'package:interior_application/core/consts.dart';

//option widget...
class OptionWidget extends StatelessWidget {
  final String title;
  final double height, width;
  final bool isSelected;
  final double rightPadding, fontSize;
  final FontWeight fontWeight;
  final Function()? onTap;

  const OptionWidget({
    super.key,
    required this.title,
    this.height = 26,
    this.width = 80,
    this.onTap,
    this.isSelected = false,
    this.rightPadding = 24,
    this.fontSize = 12,
    this.fontWeight = FontWeight.w400,
  });

  @override
  Widget build(BuildContext context) {
    return InkWellWidget(
      onTap: onTap,
      child: Container(
        height: height,
        // width: width,
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        margin: EdgeInsets.only(right: rightPadding),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2F80ED) : whiteColor,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              blurRadius: 32,
              color: const Color(0xFF466087).withOpacity(.10),
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: isSelected
                ? whiteColor
                : const Color(0xFF1B1A57).withOpacity(.50),
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}

//discover items widget...
class DiscoverItemsWidget extends StatelessWidget {
  final String itemImage, profile, title, subTitle;
  final double value;
  final Function()? onTap;

  const DiscoverItemsWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.value,
    required this.itemImage,
    required this.profile,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWellWidget(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 156,
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(7),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(itemImage),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 32,
                  color: const Color(0xFF466087).withOpacity(.10),
                  offset: const Offset(0, 4),
                )
              ],
            ),
          ),
          ListTile(
            minLeadingWidth: 0,
            contentPadding: EdgeInsets.zero,
            // visualDensity: const VisualDensity(vertical: -4),
            leading: Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: whiteColor,
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(profile),
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
                      color: blackColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                RatingBar.builder(
                  initialRating: value,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 10,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 2),
                  itemBuilder: (context, _) => SvgPicture.asset(
                      height: 10, width: 10, "assets/app_icons/star.svg"),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ],
            ),
            subtitle: Text(
              subTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: blackColor,
                fontSize: 7,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
