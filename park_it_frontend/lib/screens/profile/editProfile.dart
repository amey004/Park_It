import 'package:flutter/material.dart';
import 'package:park_it/backend/backend.dart';
import 'package:park_it/config/theme.dart';

import 'package:park_it/screens/homepage/navigationbar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditUserProfile extends StatefulWidget {
  @override
  _EditUserProfileState createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  FToast fToast;
  String assetImgAddress = 'assets/images/profile';
  String name = "";
  String carmodel = "";
  String numberplate = "";
  String uid = Backend().getID();
  String selectedAddress = 'assets/images/profile1.png';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController controller;
    fToast = FToast();
    fToast.init(context);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme2.yellow,
            iconTheme: IconThemeData(color: Theme2.black),
            title: Text(
              "Edit Profile",
              style: TextStyle(color: Theme2.black),
            ),
            centerTitle: true,
          ),
          body: Container(
            height: size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Theme2.grey2, Theme2.grey2],
            )),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(selectedAddress),
                          radius: 50,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: ClipOval(
                            child: Container(
                              height: 40,
                              width: 40,
                              color: Theme2.lightyellow,
                              child: IconButton(
                                onPressed: () => showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          backgroundColor: Theme2.grey2,
                                          title: Text(
                                            'Edit Picture',
                                            style:
                                                TextStyle(color: Theme2.black),
                                          ),
                                          scrollable: true,
                                          content: Container(
                                            height: size.height * 0.8,
                                            width: size.width * 0.9,
                                            child: Column(
                                              children: [
                                                // CircleAvatar(
                                                //   backgroundImage: AssetImage(
                                                //       selectedAddress),
                                                //   radius: 40,
                                                // ),
                                                // Divider(
                                                //   height: 20,
                                                //   color: Palette.blue,
                                                //   thickness: 1,
                                                // ),
                                                Expanded(
                                                    child: GridView.count(
                                                        primary: false,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20),
                                                        crossAxisSpacing: 8,
                                                        mainAxisSpacing: 8,
                                                        crossAxisCount: 2,
                                                        children: List.generate(
                                                            22, (index) {
                                                          return generateIcons(
                                                              assetImgAddress +
                                                                  "${index + 1}.png");
                                                        }))),
                                                /* SingleChildScrollView(
                                                  child: GridView.count(
                                                    crossAxisCount: 3,
                                                    children: List.generate(
                                                        20,
                                                        (index) => generateIcons(
                                                            assetImgAddress +
                                                                "${index + 1}" +
                                                                ".png")),
                                                  ),
                                                ), */
                                                ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Theme2.yellow),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "Ok",
                                                    style: TextStyle(
                                                        color: Theme2.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                icon: Icon(
                                  Icons.edit,
                                  color: Theme2.black,
                                  size: 25,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text(
                        "Enter name",
                        style: TextStyle(
                            color: Theme2.darkgrey,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          color: Theme2.grey,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextField(
                            style: TextStyle(
                              color: Theme2.black,
                            ),
                            controller: controller,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  fontSize: 17, color: Theme2.darkgrey),
                              hintText: "Name",
                              border: InputBorder.none,
                            ),
                            onChanged: (text) {
                              if (text != '') {
                                setState(() {
                                  name = text;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text("Enter car model",
                          style: TextStyle(
                              color: Theme2.darkgrey,
                              fontWeight: FontWeight.w800)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          color: Theme2.grey,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextField(
                            style: TextStyle(
                              color: Palette.blue,
                            ),
                            controller: controller,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  fontSize: 17, color: Theme2.darkgrey),
                              hintText: "Car Name",
                              border: InputBorder.none,
                            ),
                            onChanged: (text) {
                              if (text != '') {
                                setState(() {
                                  carmodel = text;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "Enter number plate details",
                        style: TextStyle(
                            color: Theme2.darkgrey,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          color: Theme2.grey,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextField(
                            style: TextStyle(
                              color: Theme2.black,
                            ),
                            controller: controller,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  fontSize: 17, color: Theme2.darkgrey),
                              hintText: "Car Number Plate",
                              border: InputBorder.none,
                            ),
                            onChanged: (text) {
                              if (text != '') {
                                setState(() {
                                  numberplate = text;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Theme2.yellow)),
                          onPressed: () {
                            setState(() {
                              if (name == "" ||
                                  carmodel == "" ||
                                  numberplate == "") {
                                _showToast("All field are compulsory",
                                    Colors.redAccent, Icon(Icons.cancel));
                              } else {
                                Map data = {
                                  "fullname": name,
                                  "carName": carmodel,
                                  "carNumber": numberplate,
                                  "image": selectedAddress,
                                };

                                Backend().sendData("/addDetails?id=$uid", data);
                                _showToast("Profile Edited", Colors.greenAccent,
                                    Icon(Icons.check));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NavigationBar(
                                              selectedIndex: 0,
                                              bid: "No bookings",
                                            )));
                              }
                            });
                          },
                          child: Text(
                            "OK",
                            style: TextStyle(color: Theme2.black),
                          )),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget generateIcons(String name) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAddress = name;
          print(selectedAddress);
        });
      },
      child: CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage(name),
      ),
    );
  }

  _showToast(String msg, Color c, Icon i) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: c,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          i,
          SizedBox(
            width: 12.0,
          ),
          Text(msg),
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
