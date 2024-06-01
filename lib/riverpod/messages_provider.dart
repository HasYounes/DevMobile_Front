import 'dart:convert';

import 'package:http/http.dart';
import 'package:interior_application/config.dart';
import 'package:interior_application/socket/Message.dart';
import 'package:riverpod/riverpod.dart';

class MessagesNotifier extends StateNotifier<Map<int, List<Message>>> {
  MessagesNotifier() : super({});

  void addMessage(Message message) {
    // Check if the state contains messages for the given disc_id
    if (state.containsKey(message.disc_id)) {
      // Get the current list of messages
      List<Message> messages = state[message.disc_id]!;

      // Check if the new message already exists in the list
      bool messageExists = messages.any((msg) => msg.id == message.id);

      // If the message does not exist, add it to the list
      if (!messageExists) {
        messages.add(message);
      } else {
        // If the message exists, replace the old message with the new one
        messages = [
          for (final msg in messages)
            if (msg.id == message.id) message else msg
        ];
      }

      // Update the state with the new list of messages
      state = {
        ...state,
        message.disc_id!: messages,
      };
    } else {
      // If the state does not contain messages for the given disc_id, create a new list with the message
      state = {
        ...state,
        message.disc_id!: [message],
      };
    }
  }

  List<Message>? getMessagesForDisc(int discId) {
    return state[discId];
  }

  void cleanTempMessages() {
    for (var key in state.keys) {
      if (state[key] == null) break;
      for (int i = 0; i < state[key]!.length; i++) {
        if (state[key]![i].runtimeType == TempMessage && state[key] != null) {
          state[key]!.remove(state[key]![i]);
        }
      }
    }
  }

  Future<Map> initializeMessages() async {
    final uri = Uri.http(Config.urlAuthority, '/messages/getAll');
    var response = await get(uri, headers: {"Authorization": Config.jwt});
    var json = jsonDecode(response.body);
    cleanTempMessages();
    for (var element in json) {
      if (element["projectRequest"] != null) {
        addMessage(Message.projectDraft(
            element["id"],
            element["content"],
            element["receiver"],
            element["disc_id"],
            element["sender"],
            DateTime.fromMillisecondsSinceEpoch(
                int.parse(element["timestamp"])),
            element["projectRequest"]));
      } else {
        addMessage(Message(
            element["id"],
            element["content"],
            element["receiver"],
            element["disc_id"],
            element["sender"],
            DateTime.fromMillisecondsSinceEpoch(
                int.parse(element["timestamp"]))));
      }

      //sort messages
      if (state[element["disc_id"]] != null) {
        state[element["disc_id"]]!.sort((a, b) => a.time!.compareTo(b.time!));
      }
    }
    print(json);
    print("init${state}");
    return state;
  }
}

final messagesProvider =
    StateNotifierProvider<MessagesNotifier, Map<int, List<Message>>>((ref) {
  return MessagesNotifier();
});
final initializeMessagesProvider = FutureProvider<Map>((ref) async {
  final notifier = ref.read(messagesProvider.notifier);
  return notifier.initializeMessages();
});
