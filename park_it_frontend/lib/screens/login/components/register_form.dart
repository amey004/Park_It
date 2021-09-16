import 'dart:convert';

import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:flutter/material.dart';
import 'package:park_it/backend/backend.dart';
import 'package:park_it/components/rounded_button.dart';
import 'package:park_it/components/rounded_input.dart';
import 'package:park_it/components/rounded_password_input.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:park_it/config/theme.dart';
import 'package:park_it/screens/admin/homepage/navbar.dart';
import 'package:park_it/screens/homepage/navigationbar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    Key key,
    @required this.isLogin,
    @required this.animationDuration,
    @required this.size,
    @required this.defaultLoginSize,
  }) : super(key: key);

  final bool isLogin;
  final Duration animationDuration;
  final Size size;
  final double defaultLoginSize;

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String email;
  String name;
  String password;
  String userID;
  String selector;
  FToast fToast;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    fToast = FToast();
    fToast.init(context);
    TextEditingController controller;
    return AnimatedOpacity(
      opacity: widget.isLogin ? 0.0 : 1.0,
      duration: widget.animationDuration * 5,
      child: Visibility(
        visible: !widget.isLogin,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: widget.size.width,
            height: widget.defaultLoginSize,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),

                  Text(
                    'Welcome'.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),

                  SizedBox(height: 20),

                  Image.asset('assets/images/carasset.png', scale: 3,),

                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CustomRadioButton(
                        buttonTextStyle: ButtonTextStyle(
                            selectedColor: Theme2.black,
                            unSelectedColor: Theme2.white),
                        radioButtonValue: (text) {
                          if (text == 'user') {
                            print('user');
                            selector = '/register';
                          } else {
                            print('admin');
                            selector = '/registerAdmin';
                          }
                        },
                        buttonTextStyle: ButtonTextStyle(
                            selectedColor: Theme2.black,
                            unSelectedColor: Theme2.white),
                        enableShape: true,
                        radius: 500,
                        
                        width: size.width * 0.45,
                        defaultSelected: "user",
                        selectedBorderColor: Theme2.yellow,
                        unSelectedBorderColor: Theme2.darkgrey,
                        buttonLables: ['USER', 'ADMIN'],
                        buttonValues: ['user', 'admin'],
                        unSelectedColor: Theme2.darkgrey,
                        selectedColor: Theme2.yellow),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    width: widget.size.width * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Palette.blue.withAlpha(50)),
                    child: TextField(
                      cursorColor: Palette.red,
                      decoration: InputDecoration(
                        icon: Icon(Icons.mail, color: Theme2.darkgrey),
                        hintText: 'Email',
                        border: InputBorder.none,
                      ),
                      controller: controller,
                      onChanged: (text) {
                        if (text != '') {
                          setState(() {
                            email = text;
                          });
                        }
                      },
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    width: widget.size.width * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Palette.blue.withAlpha(50)),
                    child: TextField(
                      cursorColor: Palette.red,
                      controller: controller,
                      onChanged: (text) {
                        if (text != '') {
                          setState(() {
                            name = text;
                          });
                        }
                      },
                      decoration: InputDecoration(
                          icon: Icon(Icons.person, color: Theme2.darkgrey),
                          hintText: "Name",
                          border: InputBorder.none),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    width: widget.size.width * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Palette.blue.withAlpha(50)),
                    child: TextField(
                      obscureText: true,
                      cursorColor: Palette.red,
                      controller: controller,
                      onChanged: (text) {
                        if (text != '') {
                          setState(() {
                            password = text;
                          });
                        }
                      },
                      decoration: InputDecoration(
                          icon: Icon(Icons.lock, color: Theme2.darkgrey),
                          hintText: "Password",
                          border: InputBorder.none),
                    ),
                  ),


                  SizedBox(height: 10),

                  InkWell(
                    onTap: () {
                      if (selector == '/register') {
                        Map data = {
                          "email": email,
                          "fullname": name,
                          "password": password
                        };
                        setState(() {
                          print(selector);
                          Backend().sendData(selector, data);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NavigationBar(
                                        selectedIndex: 0,
                                        bid: "No bookings",
                                      )));
                        });
                      } else {
                        if (name == "" || email == "" || password == "") {
                          _showToast("Please enter all details");
                        }
                        Map data = {
                          "email": email,
                          "name": name,
                          "password": password
                        };
                        setState(() {
                          print(selector);
                          Backend().sendData(selector, data).whenComplete(() {
                            if (Backend().getStatusCode() == 200) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AdminNavigationBar()));
                            } else {
                              _showToast("Error creating Account");
                              /* String err = (Backend().getData());
                              Map errJson = jsonDecode(err);
                              _showToast(errJson["errorMessage"]); */
                            }
                          });
                        });
                      }
                    },
                    child: RoundedButton(
                      title: 'SIGN UP',
                      key: null,
                      factor: 0.8,
                    ),
                  ),

                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showToast(String errorMessage) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.redAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.cancel),
          SizedBox(
            width: 12.0,
          ),
          Text(errorMessage),
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3),
    );
  }
}
