import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interior_application/core/button_widget.dart';
import 'package:interior_application/core/consts.dart';
import 'package:interior_application/screens/main_screens/bottom_nav_tabs/projects/projects_widget.dart';
import 'task_dialog.dart'; // Import the new TaskDialog widget

class ProjectsItemDetailScreenV2 extends StatefulWidget {
  const ProjectsItemDetailScreenV2({super.key});

  @override
  State<ProjectsItemDetailScreenV2> createState() =>
      _ProjectsItemDetailScreenV2State();
}

class _ProjectsItemDetailScreenV2State
    extends State<ProjectsItemDetailScreenV2> {
  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<Map<String, String>> _tasks = [];
  double _totalPrice = 0.0;

  void _addNewTask(String title, String description, String amount) {
    setState(() {
      _tasks.add({
        'title': title,
        'amount': amount,
        'subTitle': description,
      });
      _totalPrice += double.tryParse(amount) ?? 0.0;
    });
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TaskDialog(onAddTask: _addNewTask);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _projectNameController.addListener(() {
      setState(() {});
    });
  }

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
                      _projectNameController.text.isEmpty
                          ? 'Enter project name'
                          : _projectNameController.text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: whiteColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: dp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _projectNameController,
                    style: const TextStyle(
                      color: blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Enter project name',
                      hintStyle: TextStyle(
                        color: blackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
                    child: TextFormField(
                      controller: _descriptionController,
                      maxLines: null,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter project description',
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: _showAddTaskDialog,
                      child: const Text('Add New Task'),
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
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: dp),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _tasks.map((task) {
                      return TasksItemsWidget(
                        title: task['title']!,
                        amount: task['amount']!,
                        subTitle: task['subTitle']!,
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            Container(
              height: 1,
              width: 180,
              color: const Color(0xFFDFDFDF),
              margin: const EdgeInsets.only(top: 10, bottom: 20),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: dp * 2),
              child: Row(
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
                    "US\$${_totalPrice.toStringAsFixed(2)}",
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
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(dp),
              child: ButtonWidget(
                onPressed: () {
                  // Implement the functionality for the send button
                },
                text: "Send",
                height: 36,
                width: 120,
                fontSize: 16,
                elevation: 8,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
