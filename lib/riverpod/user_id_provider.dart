import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UseridNotifier extends StateNotifier<int> {
  UseridNotifier() : super(0) {
    SharedPreferences.getInstance().then((value) {
      state = int.parse(value.getString("id")!);
    });
  }
}

final UserIdNotifierProvider =
    StateNotifierProvider<UseridNotifier, int>((ref) => UseridNotifier());
