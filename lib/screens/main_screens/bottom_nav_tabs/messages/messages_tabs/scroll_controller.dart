import 'package:flutter/material.dart';

class ScrollControllerSingleton {
  static final ScrollControllerSingleton _instance =
      ScrollControllerSingleton._internal();
  final ScrollController scrollController = ScrollController();

  factory ScrollControllerSingleton() {
    return _instance;
  }
  void scrollToBottom() {
    final scrollController = ScrollControllerSingleton().scrollController;
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent + 1000,
        duration: const Duration(milliseconds: 2000),
        curve: Curves.easeOut,
      );
    }
  }

  ScrollControllerSingleton._internal();
}
