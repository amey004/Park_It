import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:park_it/backend/backend.dart';
import 'package:park_it/components/rounded_button.dart';
import 'package:park_it/config/theme.dart';
import 'package:park_it/screens/booking/history.dart';
import 'package:park_it/screens/login/login.dart';
import 'package:park_it/screens/profile/editProfile.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String assetImgAddress = 'assets/images/profile';
  static String name = "";

  String selectedAddress = 'assets/images/profile1.png';
  String carmodel = "";
  String numberplate = "";
  String uid = Backend().getID();

  String data;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController controller;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Theme2.yellow,
        centerTitle: true,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Theme2.black),
        title: Text(
          'Profile',
          style: TextStyle(
            color: Theme2.black,
            fontSize: 23,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditUserProfile()));
              },
              icon: Icon(Icons.edit_outlined))
        ],
      ),
      body: FutureBuilder(
          future: Backend().fetchData("/getProfile?id=$uid"),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              Map userData = snapshot.data;
              name = userData["fullname"];
              carmodel = userData["carName"];
              numberplate = userData["carNumber"];
              print(name);
            }
            return (snapshot.data == null)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : getBody();
          }),
    );
  }

  Widget getBody() {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Theme2.grey2, Theme2.grey2],
      )),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage(selectedAddress),
                radius: 50,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                name,
                style: TextStyle(
                  color: Theme2.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w400
                ),
              ),
            ),
            Divider(
              height: 20,
              thickness: 2,
              color: Palette.blue,
            ),
            Text(
              'Car Model',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Theme2.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            generateCarDetails(carmodel, numberplate),
            Divider(
              height: 35,
              thickness: 2,
              color: Palette.blue,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: RoundedButton(title: "Wallet", factor: 0.6),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: RoundedButton(title: "Booking History", factor: 0.6),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BookingHistory()));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: RoundedButton(title: "Logout", factor: 0.6),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  

  Widget generateCarDetails(String carname, String numberplate) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              image: AssetImage('assets/images/car2.jpg'),
              width: size.width * 0.4,
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    carname,
                    style: TextStyle(
                      fontSize: 23,
                      color: Theme2.black,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  Text(
                    numberplate,
                    style: TextStyle(
                      fontSize: 20,
                      
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
