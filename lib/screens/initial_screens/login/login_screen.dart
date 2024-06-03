import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart';
import 'package:interior_application/config.dart';
import 'package:interior_application/core/button_widget.dart';
import 'package:interior_application/core/consts.dart';
import 'package:interior_application/core/text_form_field_widget.dart';
import 'package:interior_application/screens/initial_screens/create_account/create_account_screen.dart';
import 'package:interior_application/screens/main_screens/drawer/drawer_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var myFormKey = GlobalKey<FormState>();
  TextEditingController myEmailController = TextEditingController();
  TextEditingController myPasswordController = TextEditingController();

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(
      backgroundColor: Color.fromRGBO(158, 8, 8, 1),
      content: Text(text),
      duration: Duration(seconds: 1), //default is 4s
    );
    // Find the Scaffold in the widget tree and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  onButtonPressed(BuildContext context) async {
    if (myFormKey.currentState!.validate()) {
      var uri = Uri.http(Config.urlAuthority, "/auth/login");
      var response = await post(uri,
          headers: {"Content-type": "application/json"},
          body: jsonEncode({
            "email": myEmailController.text,
            "password": myPasswordController.text,
          }));
      print(response.body);
      if (jsonDecode(response.body)["status"] == "Ok") {
        SharedPreferences shared = await SharedPreferences.getInstance();
        shared.setString('jwt', jsonDecode(response.body)['jwt']);
        shared.setString('usertype', jsonDecode(response.body)['usertype']);
        print("usertype  :${shared.getString("usertype")}");
        shared.setString('id', jsonDecode(response.body)['id'].toString());
        print("${jsonDecode(response.body)['id']} is id");
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => const DrawerScreen(),
          ),
        );
      } else {
        showSnackBar(context, "wrong login or password");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: mainAppColorOne,
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(dp, 20, dp, 0),
                    child: RichText(
                      text: const TextSpan(
                        text: "In",
                        style: TextStyle(
                          color: mainAppColorTwo,
                          fontSize: 48,
                          fontWeight: FontWeight.w800,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "terior",
                            style: TextStyle(
                              color: whiteColor,
                              fontSize: 48,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 40),
                      padding: const EdgeInsets.only(
                          top: 50, bottom: 20, left: dp, right: dp),
                      decoration: const BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(80),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            "Login",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: mainAppColorTwo,
                              fontSize: 27,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Form(
                            key: myFormKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                TextFormFieldWidget(
                                  myController: myEmailController,
                                  hintText: "Email ...",
                                  textInputType: TextInputType.emailAddress,
                                  validator:
                                      RequiredValidator(errorText: "*required")
                                          .call,
                                ),
                                TextFormFieldWidget(
                                  myController: myPasswordController,
                                  hintText: "Password ...",
                                  textInputAction: TextInputAction.done,
                                  validator:
                                      RequiredValidator(errorText: "*required")
                                          .call,
                                ),
                                const SizedBox(height: 10),
                                ButtonWidget(
                                  text: "Sign in",
                                  onPressed: () {
                                    onButtonPressed(context);
                                  },
                                ),
                                const SizedBox(height: 10),
                                RichText(
                                  text: const TextSpan(
                                    text: "Forgot Password ? ",
                                    style: TextStyle(
                                      color: Color(0xFF5C79A4),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "Click here ",
                                        style: TextStyle(
                                          color: Color(0xFF5C79A4),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const SizedBox(height: 20),
                              ButtonWidget(
                                text: "Register",
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const CreateAccountScreen(),
                                    ),
                                  );
                                },
                                btnColor: mainAppColorTwo,
                                borderColor: mainAppColorTwo,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
