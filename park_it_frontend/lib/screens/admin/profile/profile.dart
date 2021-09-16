import 'package:flutter/material.dart';
import 'package:park_it/backend/backend.dart';
import 'package:park_it/components/rounded_button.dart';
import 'package:park_it/config/theme.dart';
import 'package:park_it/screens/admin/profile/editProfile.dart';
import 'package:park_it/screens/login/login.dart';

class AdminProfile extends StatefulWidget {
  @override
  _AdminProfileState createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  String assetImgAddress = 'assets/images/profile';
  String name;
  String address;
  int rows;
  int parkings;
  double rate = 10.0;
  int total;
  int available;
  String selectedAddress = 'assets/images/profile1.jpg';
  String aid;
  String data = "";
  @override
  void initState() {
    super.initState();
    total = 0;
    aid = Backend().getParkingID();
    name = "Daal rahe hai ruk jao";
    address = "sabr karo";
    available = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme2.grey2,
        appBar: AppBar(
          toolbarHeight: 70,
          automaticallyImplyLeading: false,
          backgroundColor: Theme2.yellow,
          centerTitle: true,
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
                    MaterialPageRoute(builder: (context) => EditProfile()));
              },
              icon: Icon(
                Icons.edit_rounded,
                color: Theme2.black,
              ),
            ),
          ],
        ),
        body: FutureBuilder(
            future: Backend().fetchData("/parkingDetails?id=$aid"),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data != null) {
                print(snapshot.data);
                Map details = snapshot.data;
                name = details["placeName"];
                address = details["Address"];
                rows = details["Row"];
                parkings = details["Columns"];
                total = rows * parkings;
                int occupied = details["occupied"];
                available = total - occupied;
                selectedAddress = details["image"];
              }
              return (snapshot.data == null)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : getBody();
            }),
      ),
    );
  }

  Widget getBody() {
    Size size = MediaQuery.of(context).size;
    return (data == null)
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
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
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      name,
                      style: TextStyle(
                        color: Theme2.black,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    address,
                    style: TextStyle(
                      color: Theme2.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Total Number of Parkings:",
                          style: TextStyle(
                              color: Theme2.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          "$total",
                          style: TextStyle(
                            color: Theme2.black,
                            fontSize: 21,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Available Parkings: ",
                          style: TextStyle(
                              color: Theme2.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          "$available",
                          style: TextStyle(
                            color: Theme2.black,
                            fontSize: 21,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: RoundedButton(title: "Logout", factor: 0.8),
                  ),
                ),
              ],
            ),
          );
  }

  Widget getBooking(String car, String pID) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(car),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(pID),
        ),
      ],
    );
  }

  Widget getCurrent(List cars, List pIDs) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
            cars.length, (index) => getBooking(cars[index], pIDs[index])),
      ),
    );
  }
}
