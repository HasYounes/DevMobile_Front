import 'dart:convert';

import 'package:http/http.dart';
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

  Future<Map> initializeMessages() async {
    final uri = Uri.http('192.168.1.4:8080', '/messages/getAll');
    var response = await get(uri, headers: {
      "Authorization":
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjAsImZ1bGxuYW1lIjoidGV4dCIsImVtYWlsIjoidGV4dEBrc2pmLmV4dCIsInVzZXJ0eXBlIjoiY2xpZW50IiwiaWF0IjoxNzE3MDA1MTc0LCJleHAiOjE3MTcwOTE1NzR9.32ywF7aPbAdz40KDuUSYigduAXEJJM5G7l-wzacrT_I"
    });
    var json = jsonDecode(response.body);
    for (var element in json) {
      if (element["projectRequest"] != null) {
        print("state before insert ${state}");

        addMessage(Message.projectDraft(
            element["id"],
            element["content"],
            element["receiver"],
            element["disc_id"],
            element["sender"],
            DateTime.fromMillisecondsSinceEpoch(
                int.parse(element["timestamp"])),
            element["projectRequest"]));
        print("state after insert ${state}");
      } else {
        print("state before insert ${state}");

        addMessage(Message(
            element["id"],
            element["content"],
            element["receiver"],
            element["disc_id"],
            element["sender"],
            DateTime.fromMillisecondsSinceEpoch(
                int.parse(element["timestamp"]))));
        print("state after insert ${state}");
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
