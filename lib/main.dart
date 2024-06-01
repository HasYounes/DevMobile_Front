import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interior_application/riverpod/messages_provider.dart';
import 'package:interior_application/riverpod/socketserviceprovider.dart';
import 'package:interior_application/screens/initial_screens/login/login_screen.dart';
import 'package:interior_application/screens/main_screens/bottom_nav_tabs/home/home_screen.dart';
import 'package:interior_application/screens/main_screens/drawer/drawer_screen.dart';
import 'package:interior_application/socket/socket.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/consts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: mainAppColorOne,
    ),
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SocketService socket = ref.watch(socketServiceProvider);
    MessagesNotifier message_provider = ref.read(messagesProvider.notifier);
    message_provider.initializeMessages();
    socket.init();
    return FutureBuilder(
        future: SharedPreferences.getInstance().then((value) {
          //value.remove("jwt");
          return value.get("jwt");
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: mainAppColorOne,
                  ),
                  fontFamily: 'Fellix',
                ),
                home: const LoginScreen(),
              );
            } else {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: mainAppColorOne,
                  ),
                  fontFamily: 'Fellix',
                ),
                home: const DrawerScreen(),
              );
            }
          } else {
            return Center(child: Text("Error"));
          }
        });
  }
}
