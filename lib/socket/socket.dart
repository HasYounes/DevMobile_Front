import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interior_application/config.dart';
import 'package:interior_application/riverpod/messages_provider.dart';
import 'package:interior_application/socket/Message.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  IO.Socket? socket;
  final Ref ref;

  SocketService({required Ref reference}) : ref = reference;
  void init() {
    if (socket != null) {
      print("caught here");
      return;
    }
    socket = IO.io(
        "http://${Config.urlAuthority}",
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .enableAutoConnect() // automatically connect
            .setExtraHeaders({'Authorization': Config.jwt})
            .build());
    socket!.on('connect', (_) {
      print('Socket connected');
    });

    socket!.on('connect_error', (error) {
      print('Connection error: $error');
    });

    socket!.on('disconnect', (reason) {
      print('Socket disconnected, reason: $reason');
      // Handle specific disconnection reasons if necessary
    });

    socket!.on('messages', (msgs) {
      print("Received messages: $msgs");
      var addMsg = ref.read(messagesProvider.notifier).addMessage;
      for (var element in msgs) {
        var epoch;
        try {
          epoch = int.parse(element['timestamp']);
        } catch (e) {
          epoch = element['timestamp'];
        }
        if (element['projectRequest'] != null) {
          addMsg(Message.projectDraft(
              element['id'],
              element['content'],
              element['receiver'],
              element['disc_id'],
              element['sender'],
              DateTime.fromMillisecondsSinceEpoch(epoch),
              element['projectRequest']));
        } else {
          addMsg(Message(
              element['id'],
              element['content'],
              element['receiver'],
              element['disc_id'],
              element['sender'],
              DateTime.fromMillisecondsSinceEpoch(epoch)));
        }

        socket!.emit("msg_status", {
          "messages": [
            {"id": element["id"], "status": "received"}
          ]
        });
      }
      print("Messages processed and added to state");
    });
  }

  void send(Map msg) {
    socket!.emit("messages", msg);
  }
}
