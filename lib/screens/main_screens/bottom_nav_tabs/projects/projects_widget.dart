import 'package:flutter/material.dart';
import 'package:interior_application/core/clickable_widget.dart';
import 'package:interior_application/core/consts.dart';
import 'package:percent_indicator/percent_indicator.dart';

//projects items widget...
class ProjectItemsWidget extends StatelessWidget {
  final String image, title, subTitle;
  final double value;
  final Function()? onTap;

  const ProjectItemsWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWellWidget(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: const BoxDecoration(
          color: whiteColor,
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFDFDFDF),
              width: 1,
            ),
          ),
        ),
        child: ListTile(
          minLeadingWidth: 0,
          contentPadding: EdgeInsets.zero,
          // visualDensity: const VisualDensity(vertical: -4),
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
              boxShadow: [
                BoxShadow(
                  blurRadius: 32,
                  color: const Color(0xFF466087).withOpacity(.10),
                  offset: const Offset(0, 4),
                )
              ],
            ),
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF1B1A57),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 16),
              LinearWidget(
                value: value,
              ),
            ],
          ),
          subtitle: Text(
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
      ),
    );
  }
}

//linear widget...
class LinearWidget extends StatelessWidget {
  final double value;

  const LinearWidget({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF9B9B9B),
          width: 0.5,
        ),
      ),
      child: LinearPercentIndicator(
        width: 80,
        padding: EdgeInsets.zero,
        lineHeight: 7.0,
        barRadius: const Radius.circular(10),
        percent: value,
        center: value == 1
            ? const Icon(
                Icons.done,
                size: 6,
                color: whiteColor,
              )
            : const SizedBox(),
        backgroundColor: whiteColor,
        progressColor: greenColor,
      ),
    );
  }
}

//tasks items widget...
class TasksItemsWidget extends StatelessWidget {
  final String title, subTitle, amount;

  const TasksItemsWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 0,
      contentPadding: EdgeInsets.zero,
      leading: Image.asset(
        height: 31,
        width: 31,
        "assets/app_images/task.png",
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
            amount,
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
      subtitle: Text(
        subTitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Color(0xFF4F5E7B),
          fontSize: 10,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

//designer items widget...
class DesignerItemsWidget extends StatelessWidget {
  final String icon, title, subTitle;

  const DesignerItemsWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: whiteColor,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFDFDFDF),
            width: 1,
          ),
        ),
      ),
      child: ListTile(
        minLeadingWidth: 0,
        contentPadding: EdgeInsets.zero,
        leading: Image.asset(
          icon,
          height: 27,
          width: 32,
        ),
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: blackColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          subTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: blackColor,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
