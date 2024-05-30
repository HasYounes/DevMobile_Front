import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:interior_application/core/consts.dart';
import 'package:interior_application/screens/initial_screens/login/login_screen.dart';
import '../main_screen.dart';
import 'side_menu/side_menu_widget.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  int selectedDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    final List<Map<String, Widget>> drawerPages = [
      {
        "Projects": MainScreen(
          scaffoldKey: _key,
        )
      },
      //add more drawer screens here...
    ];
    return SafeArea(
      child: Scaffold(
        key: _key,
        resizeToAvoidBottomInset: true,
        endDrawer: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: width / 1.12,
          ),
          child: Container(
            height: double.infinity,
            width: width / 1.12,
            color: whiteColor,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 170,
                      color: mainAppColorOne,
                      padding: const EdgeInsets.fromLTRB(dp, 0, dp, 20),
                      margin: const EdgeInsets.only(bottom: 30),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ProfileWidget(
                            name: "Soufiane Harzane",
                            email: "soufianeharzane@gmail.com",
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 10),
                        slideMenuItem(
                          title: "My Projects",
                          id: 0,
                        ),
                        slideMenuItem(
                          title: "Inbox",
                          id: 1,
                        ),
                        slideMenuItem(
                          title: "Privacy Policy",
                          id: 2,
                        ),
                        slideMenuItem(
                          title: "Logout",
                          id: 3,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text('Tap back again to leave'),
          ),
          child: drawerPages[selectedDrawerIndex].values.first,
        ),
      ),
    );
  }

  Widget slideMenuItem({
    required int id,
    int? itemCount,
    String? title,
  }) {
    return InkWell(
      onTap: () {
        if (id == 0) {
          setState(() {
            selectedDrawerIndex = 0;
          });
          Navigator.maybePop(context);
        } else if (id == 1) {
          Navigator.maybePop(context);
        } else if (id == 2) {
          Navigator.maybePop(context);
        } else if (id == 3) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const LoginScreen(),
              ),
              (route) => false);
        }
      },
      child: Container(
        height: 40,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: id == 0 ? mainAppColorOne : whiteColor,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title!,
            style: TextStyle(
              color: id == 0
                  ? whiteColor
                  : id == 3
                      ? alertColor
                      : blackColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
