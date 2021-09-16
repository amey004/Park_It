import 'package:flutter/material.dart';
import 'package:park_it/backend/backend.dart';
import 'package:park_it/config/theme.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:park_it/screens/admin/homepage/navbar.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  FToast fToast;
  String assetImgAddress = 'assets/images/profile';
  String selectedAddress = 'assets/images/profile1.jpg';
  String name;
  String address;
  int rows;
  int parkings;
  int rate;
  String aid;

  @override
  void initState() {
    super.initState();
    rows = 0;
    parkings = 0;
    rate = 0;
    name = "";
    address = "";
    aid = Backend().getParkingID();
  }

  @override
  Widget build(BuildContext context) {
    fToast = FToast();
    fToast.init(context);
    TextEditingController controller;
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          //resizeToAvoidBottomInset: false,
          appBar: AppBar(
            toolbarHeight: 70,
            backgroundColor: Theme2.yellow,
            iconTheme: IconThemeData(color: Theme2.black),
            title: Text(
              "Edit Profile",
              style: TextStyle(color: Theme2.black),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
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
                                                CircleAvatar(
                                                  backgroundImage: AssetImage(
                                                      selectedAddress),
                                                  radius: 30,
                                                ),
                                                Divider(
                                                  height: 20,
                                                  color: Palette.blue,
                                                  thickness: 1,
                                                ),
                                                Expanded(
                                                  child: GridView.count(
                                                    mainAxisSpacing: 5,
                                                    crossAxisSpacing: 5,
                                                    crossAxisCount: 3,
                                                    children:
                                                        List.generate(14, (i) {
                                                      String loc =
                                                          assetImgAddress +
                                                              (i + 1)
                                                                  .toString() +
                                                              '.jpg';
                                                      return generateIcons(loc);
                                                    }),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("OK"),
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
                    SizedBox(height:30),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text("Enter name", style: TextStyle(fontWeight: FontWeight.w800),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme2.grey2,
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
                              hintText: name,
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
                      child: Text("Enter address",style: TextStyle(fontWeight: FontWeight.w800)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Theme2.grey2,
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
                              hintText: address,
                              border: InputBorder.none,
                            ),
                            onChanged: (text) {
                              if (text != '') {
                                setState(() {
                                  address = text;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text("Enter number of rows",style: TextStyle(fontWeight: FontWeight.w800)),
                    ),
                    Text(
                      "(For eg: A,B,C...)",
                      style: TextStyle(fontSize: 13),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Theme2.grey2,
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
                              hintText: rows.toString(),
                              border: InputBorder.none,
                            ),
                            onChanged: (text) {
                              if (text != '') {
                                setState(() {
                                  rows = int.parse(text);
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text("Enter number of parkings in each row",style: TextStyle(fontWeight: FontWeight.w800)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Theme2.grey2,
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
                              hintText: parkings.toString(),
                              border: InputBorder.none,
                            ),
                            onChanged: (text) {
                              if (text != '') {
                                setState(() {
                                  parkings = int.parse(text);
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text("Enter rate per hour",style: TextStyle(fontWeight: FontWeight.w800)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Theme2.grey2,
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
                              hintText: rate.toString(),
                              border: InputBorder.none,
                            ),
                            onChanged: (text) {
                              if (text != '') {
                                setState(() {
                                  rate = int.parse(text);
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
                                  address == "" ||
                                  rows == 0 ||
                                  parkings == 0 ||
                                  rate == 0.0) {
                                _showToast("All field are compulsory",
                                    Colors.redAccent, Icon(Icons.cancel));
                              } else {
                                Map data = {
                                  "placeName": name,
                                  "Address": address,
                                  "Row": rows.toString(),
                                  "Columns": parkings.toString(),
                                  "Rate": rate.toString(),
                                  "image": selectedAddress,
                                };
                                print(aid);
                                Backend()
                                    .sendData(
                                        "/addParkingDetails?id=$aid", data)
                                    .whenComplete(() {
                                  _showToast("Profile Edited",
                                      Colors.greenAccent, Icon(Icons.check));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AdminNavigationBar()));
                                });
                              }
                            });
                          },
                          child: Text(
                            "OK",
                            style: TextStyle(color: Theme2.black
                            ),
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
        radius: 20,
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
