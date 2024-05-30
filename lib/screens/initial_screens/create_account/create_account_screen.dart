import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart';
import 'package:interior_application/core/button_widget.dart';
import 'package:interior_application/core/consts.dart';
import 'package:interior_application/core/text_form_field_widget.dart';
import 'package:interior_application/screens/main_screens/drawer/drawer_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  var myFormKey = GlobalKey<FormState>();
  TextEditingController myFullNameController = TextEditingController();
  TextEditingController myEmailController = TextEditingController();
  TextEditingController myPasswordController = TextEditingController();
  String selectedCountry = "";

  final List<String> countryItems = [
    "I am a designer",
    "I am  looking for a designer",
  ];

  @override
  void initState() {
    selectedCountry = countryItems[0];
    super.initState();
  }

  onButtonPressed() async {
    if (myFormKey.currentState!.validate()) {
      var uri = Uri.http("192.168.1.4:8080", "/auth/register");
      var response = await post(uri,
          headers: {"Content-type": "application/json"},
          body: jsonEncode({
            "fullname": myFullNameController.text,
            "email": myEmailController.text,
            "password": myPasswordController.text,
            "usertype":
                selectedCountry == "I am a designer" ? "designer" : "client"
          }));
      print(response.body);
      if (jsonDecode(response.body)["affected_rows"] > 0) {
        SharedPreferences shared = await SharedPreferences.getInstance();
        shared.setString('jwt', jsonDecode(response.body)['jwt']);
        showSnackBar(context, "success");
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => const DrawerScreen(),
          ),
        );
      } else {
        showSnackBar(context, "bad request");
      }
    }
  }

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(
      backgroundColor: Color.fromRGBO(158, 8, 8, 1),
      content: Text(text),
      duration: Duration(seconds: 1), //default is 4s
    );
    // Find the Scaffold in the widget tree and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                      child: Form(
                        key: myFormKey,
                        child: Column(
                          children: <Widget>[
                            const Text(
                              "Create a new account",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: mainAppColorTwo,
                                fontSize: 27,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 50),
                            TextFormFieldWidget(
                              myController: myFullNameController,
                              hintText: "Full name ...",
                              textInputType: TextInputType.name,
                              validator:
                                  RequiredValidator(errorText: "*required")
                                      .call,
                            ),
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
                            Container(
                              height: 46,
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 30),
                              decoration: BoxDecoration(
                                color: const Color(0xFFCFD9E8),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Theme(
                                data: ThemeData(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: const Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        "Select Type",
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: mainAppColorTwo,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    iconStyleData: IconStyleData(
                                      icon: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: SvgPicture.asset(
                                          "assets/app_icons/down_side.svg",
                                        ),
                                      ),
                                    ),
                                    selectedItemBuilder:
                                        (BuildContext context) {
                                      return countryItems
                                          .map<Widget>((String item) {
                                        return Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                color: mainAppColorTwo,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList();
                                    },
                                    items: countryItems
                                        .map(
                                          (item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: item == selectedCountry
                                                ? Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8),
                                                    child: Text(
                                                      item,
                                                      style: const TextStyle(
                                                        color: mainAppColorTwo,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  )
                                                : Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8),
                                                    child: Text(
                                                      item,
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFF5C79A4),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        )
                                        .toList(),
                                    value: selectedCountry,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedCountry = value as String;
                                      });
                                    },
                                    buttonStyleData: const ButtonStyleData(
                                      height: 50,
                                      width: double.infinity,
                                      padding: EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                      ),
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 100,
                                      width: 300,
                                      elevation: 1,
                                      offset: const Offset(0, -2),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFCFD9E8),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                      ),
                                      scrollbarTheme: ScrollbarThemeData(
                                        radius: const Radius.circular(40),
                                        thickness: MaterialStateProperty.all(2),
                                        thumbVisibility:
                                            MaterialStateProperty.all(true),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            ButtonWidget(
                              text: "Sign up",
                              onPressed: onButtonPressed,
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
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
