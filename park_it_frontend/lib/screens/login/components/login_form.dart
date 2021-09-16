import 'package:flutter/material.dart';
import 'package:park_it/backend/backend.dart';
import 'package:park_it/components/rounded_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:park_it/config/theme.dart';
import 'package:park_it/screens/admin/homepage/navbar.dart';
import 'package:park_it/screens/homepage/navigationbar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
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
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String username = 'Username';
  String password = 'Password';
  int selectedIndex = 0;
  FToast fToast;

  @override
  Widget build(BuildContext context) {
    fToast = FToast();
    fToast.init(context);
    Size size = MediaQuery.of(context).size;
    TextEditingController controller;
    return AnimatedOpacity(
      opacity: widget.isLogin ? 1.0 : 0.0,
      duration: widget.animationDuration * 4,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: widget.size.width,
          height: widget.defaultLoginSize,
          child: Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ParkIt',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(height: 40),
                  Image.asset(
                    'assets/images/logofi.png',
                    scale: 1.5,
                  ),
                  SizedBox(height: 40),
                  DefaultTabController(
                    length: 2,
                    child: TabBar(
                        indicatorColor: Theme2.yellow,
                        automaticIndicatorColorAdjustment: true,
                        onTap: (index) {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        tabs: [
                          Tab(
                              child: Text('User'.toUpperCase(),
                                  style: TextStyle(
                                      color: Palette.blue,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold))),
                          Tab(
                              child: Text('Admin'.toUpperCase(),
                                  style: TextStyle(
                                      color: Palette.blue,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold))),
                        ]),
                  ),
                  getLogin(selectedIndex),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getLogin(int index) {
    Size size = MediaQuery.of(context).size;
    TextEditingController controller;
    switch (index) {
      case 0:
        {
          return Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Palette.blue.withAlpha(50)),
                  child: TextField(
                    style: TextStyle(
                      color: Palette.blue,
                    ),
                    controller: controller,
                    cursorColor: Palette.red,
                    decoration: InputDecoration(
                        icon: Icon(Icons.person, color: Theme2.darkgrey),
                        hintText: username,
                        border: InputBorder.none),
                    onChanged: (text) {
                      if (text != '') {
                        setState(() {
                          username = text;
                        });
                      }
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Palette.blue.withAlpha(50)),
                  child: TextField(
                    obscureText: true,
                    style: TextStyle(
                      color: Palette.blue,
                    ),
                    controller: controller,
                    cursorColor: Palette.red,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock, color: Theme2.darkgrey),
                        hintText: password,
                        border: InputBorder.none),
                    onChanged: (text) {
                      if (text != '') {
                        setState(() {
                          password = text;
                        });
                      }
                    },
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                    onTap: () {
                      //signIn();
                      Map data = {"email": username, "password": password};
                      Backend().sendData("/signin", data).whenComplete(() {
                        print(Backend().getStatusCode());
                        if (Backend().getStatusCode() == 200) {
                          print(Backend().getStatusCode());
                          print(Backend().getData());
                          uid = Backend().getID();
                          //final data = CurrentBooking(uid: uid);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NavigationBar(
                                        selectedIndex: 0,
                                        bid: "No bookings",
                                      )));
                        } else {
                          _showToast("Incorrect Username or Password");
                          print('Auth Error');
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: RoundedButton(title: 'LOGIN AS USER', factor: 0.8)),
                SizedBox(height: 10),
              ],
            ),
          );
        }
      case 1:
        {
          return Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Palette.blue.withAlpha(50)),
                  child: TextField(
                    style: TextStyle(
                      color: Palette.blue,
                    ),
                    controller: controller,
                    cursorColor: Palette.red,
                    decoration: InputDecoration(
                        icon: Icon(Icons.person, color: Theme2.darkgrey),
                        hintText: username,
                        border: InputBorder.none),
                    onChanged: (text) {
                      if (text != '') {
                        setState(() {
                          username = text;
                        });
                      }
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Palette.blue.withAlpha(50)),
                  child: TextField(
                    obscureText: true,
                    style: TextStyle(
                      color: Palette.blue,
                    ),
                    controller: controller,
                    cursorColor: Palette.red,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock, color: Theme2.darkgrey),
                        hintText: password,
                        border: InputBorder.none),
                    onChanged: (text) {
                      if (text != '') {
                        setState(() {
                          password = text;
                        });
                      }
                    },
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                    onTap: () {
                      //signIn();
                      Map data = {"email": username, "password": password};
                      Backend().sendData("/adminSignin", data).whenComplete(() {
                        print(Backend().getStatusCode());
                        if (Backend().getStatusCode() == 200) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminNavigationBar()));
                        } else {
                          _showToast("Incorrect Username or Password");
                          print('Auth Error');
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: RoundedButton(
                      title: 'LOGIN AS ADMIN',
                      factor: 0.8,
                    )),
                SizedBox(height: 10),
              ],
            ),
          );
        }
    }
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
