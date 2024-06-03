import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interior_application/core/button_widget.dart';
import 'package:interior_application/core/consts.dart';
import 'package:interior_application/riverpod/socketserviceprovider.dart';
import 'package:interior_application/screens/main_screens/bottom_nav_tabs/projects/projects_widget.dart';
import 'task_dialog.dart';

class ProjectDetailsNotifier extends StateNotifier<ProjectDetailsState> {
  ProjectDetailsNotifier() : super(ProjectDetailsState());

  void addNewTask(String title, String description, String amount) {
    state = state.copyWith(
      tasks: [
        ...state.tasks,
        {'title': title, 'amount': amount, 'subTitle': description},
      ],
      totalPrice: state.totalPrice + (double.tryParse(amount) ?? 0.0),
    );
  }

  void updateProjectName(String name) {
    state = state.copyWith(projectName: name);
  }

  void updateDescription(String description) {
    state = state.copyWith(description: description);
  }

  void removeTask(int index) {
    final removedTask = state.tasks[index];
    final updatedTasks = [...state.tasks]..removeAt(index);
    final updatedTotalPrice =
        state.totalPrice - (double.tryParse(removedTask['amount']!) ?? 0.0);
    state = state.copyWith(tasks: updatedTasks, totalPrice: updatedTotalPrice);
  }
}

class ProjectDetailsState {
  final String projectName;
  final String description;
  final List<Map<String, String>> tasks;
  final double totalPrice;

  ProjectDetailsState({
    this.projectName = '',
    this.description = '',
    this.tasks = const [],
    this.totalPrice = 0.0,
  });

  ProjectDetailsState copyWith({
    String? projectName,
    String? description,
    List<Map<String, String>>? tasks,
    double? totalPrice,
  }) {
    return ProjectDetailsState(
      projectName: projectName ?? this.projectName,
      description: description ?? this.description,
      tasks: tasks ?? this.tasks,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}

final projectDetailsProvider =
    StateNotifierProvider<ProjectDetailsNotifier, ProjectDetailsState>(
        (ref) => ProjectDetailsNotifier());
// Import the ProjectDetailsNotifier and projectDetailsProvider

class ProjectsItemDetailScreenV2 extends ConsumerWidget {
  final int disc_id;
  const ProjectsItemDetailScreenV2({super.key, required this.disc_id});

  void _showAddTaskDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TaskDialog(onAddTask: (title, description, amount) {
          ref
              .read(projectDetailsProvider.notifier)
              .addNewTask(title, description, amount);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectDetails = ref.watch(projectDetailsProvider);
    final projectDetailsNotifier = ref.read(projectDetailsProvider.notifier);

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
                      projectDetails.projectName.isEmpty
                          ? 'Enter project name'
                          : projectDetails.projectName,
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
                    initialValue: projectDetails.projectName,
                    onChanged: (value) =>
                        projectDetailsNotifier.updateProjectName(value),
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
                      initialValue: projectDetails.description,
                      onChanged: (value) =>
                          projectDetailsNotifier.updateDescription(value),
                      maxLines: null,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter project description',
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _showAddTaskDialog(context, ref),
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
                    children: projectDetails.tasks.asMap().entries.map((entry) {
                      final index = entry.key;
                      final task = entry.value;
                      return Dismissible(
                        key: Key(task['title']!),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          projectDetailsNotifier.removeTask(index);
                        },
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          color: Colors.red,
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        child: TasksItemsWidget(
                          title: task['title']!,
                          amount: task['amount']!,
                          subTitle: task['subTitle']!,
                        ),
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
                    "US\$${projectDetails.totalPrice.toStringAsFixed(2)}",
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
                  var sendMessage = ref.read(socketServiceProvider).send;
                  var projectState = ref.read(projectDetailsProvider);

                  sendMessage({
                    "messages": [
                      {
                        "disc_id": disc_id,
                        "content": jsonEncode({
                          "name": projectState.projectName,
                          "description": projectState.description,
                          "tasks": projectState.tasks
                              .map((e) => {
                                    "name": e["title"],
                                    "description": e["subTitle"],
                                    "price": double.parse(e["amount"] ?? "0"),
                                  })
                              .toList(),
                        })
                      }
                    ]
                  });
                  Navigator.of(context).pop();
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










// class ProjectsItemDetailScreenV2 extends ConsumerWidget {
//   final int disc_id;
//   const ProjectsItemDetailScreenV2({super.key, required this.disc_id});

//   void _showAddTaskDialog(BuildContext context, WidgetRef ref) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return TaskDialog(onAddTask: (title, description, amount) {
//           ref
//               .read(projectDetailsProvider.notifier)
//               .addNewTask(title, description, amount);
//         });
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final projectDetails = ref.watch(projectDetailsProvider);
//     final projectDetailsNotifier = ref.read(projectDetailsProvider.notifier);

//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: whiteColor,
//         body: Column(
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
//                 child: Theme(
//                   data: ThemeData(
//                     splashColor: Colors.transparent,
//                     highlightColor: Colors.transparent,
//                     hoverColor: Colors.transparent,
//                   ),
//                   child: ListTile(
//                     minLeadingWidth: 0,
//                     contentPadding: EdgeInsets.zero,
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     leading: SvgPicture.asset(
//                       "assets/app_icons/back_arrow.svg",
//                       colorFilter: const ColorFilter.mode(
//                         whiteColor,
//                         BlendMode.srcIn,
//                       ),
//                     ),
//                     title: Text(
//                       projectDetails.projectName.isEmpty
//                           ? 'Enter project name'
//                           : projectDetails.projectName,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                         color: whiteColor,
//                         fontSize: 20,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: dp),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   TextFormField(
//                     initialValue: projectDetails.projectName,
//                     onChanged: (value) =>
//                         projectDetailsNotifier.updateProjectName(value),
//                     style: const TextStyle(
//                       color: blackColor,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                     decoration: const InputDecoration(
//                       hintText: 'Enter project name',
//                       hintStyle: TextStyle(
//                         color: blackColor,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                       border: UnderlineInputBorder(),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   const Text(
//                     "Description",
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       color: blackColor,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   Container(
//                     width: double.infinity,
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//                     margin: const EdgeInsets.symmetric(vertical: 20),
//                     decoration: BoxDecoration(
//                       color: whiteColor,
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(
//                         color: const Color(0xFFBDBDBD),
//                         width: 1,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           blurRadius: 4,
//                           color: blackColor.withOpacity(.25),
//                           offset: const Offset(0, 4),
//                         )
//                       ],
//                     ),
//                     child: TextFormField(
//                       initialValue: projectDetails.description,
//                       onChanged: (value) =>
//                           projectDetailsNotifier.updateDescription(value),
//                       maxLines: null,
//                       decoration: const InputDecoration(
//                         border: InputBorder.none,
//                         hintText: 'Enter project description',
//                       ),
//                     ),
//                   ),
//                   Center(
//                     child: ElevatedButton(
//                       onPressed: () => _showAddTaskDialog(context, ref),
//                       child: const Text('Add New Task'),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               height: 22,
//               width: double.infinity,
//               color: const Color(0xFFD9D9D9),
//               padding: const EdgeInsets.symmetric(horizontal: dp),
//               child: const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   "Tasks",
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     color: Color(0xFF57626E),
//                     fontSize: 9,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: dp),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: projectDetails.tasks.map((task) {
//                       return TasksItemsWidget(
//                         title: task['title']!,
//                         amount: task['amount']!,
//                         subTitle: task['subTitle']!,
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               height: 1,
//               width: 180,
//               color: const Color(0xFFDFDFDF),
//               margin: const EdgeInsets.only(top: 10, bottom: 20),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: dp * 2),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   const Expanded(
//                     child: Text(
//                       "Total:",
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         color: Color(0xFF1B1A57),
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Text(
//                     "US\$${projectDetails.totalPrice.toStringAsFixed(2)}",
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       color: blackColor,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 30),
//             Padding(
//               padding: const EdgeInsets.all(dp),
//               child: ButtonWidget(
//                 onPressed: () {
//                   var sendMessage = ref.read(socketServiceProvider).send;
//                   var projectState = ref.read(projectDetailsProvider);

//                   sendMessage({
//                     "disc_id": disc_id,
//                     "content": jsonEncode({
//                       "name": projectState.projectName,
//                       "description": projectState.description,
//                       "tasks": projectState.tasks
//                           .map((e) => {
//                                 "name": e["title"],
//                                 "description": e["subTitle"],
//                                 "price": double.parse(e["amount"] ?? "0"),
//                               })
//                           .toList(),
//                     })
//                   });
//                 },
//                 text: "Send",
//                 height: 36,
//                 width: 120,
//                 fontSize: 16,
//                 elevation: 8,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
