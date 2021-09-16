import 'package:flutter/material.dart';
import 'package:park_it/backend/backend.dart';
import 'package:park_it/config/theme.dart';
import 'package:flip_card/flip_card.dart';
import 'package:park_it/screens/admin/homepage/currentBookings.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  List cars = ['MH-05-AB-4517', 'MH-05-AJ-6427', 'MH-05-EM-2340'];
  List pIDs = ['E10', 'C24', 'A5'];
  Map tabdata = {
    'City Mall': 10,
    'Phoenix Mall': 10,
    'Westend': 10,
    'Asian Mall': 10,
    'Inorbit Mall': 10,
  };
  String aid;
  int revenue = 0;
  int slots = 0;
  int totalslots = 0;

  @override
  void initState() {
    super.initState();
    aid = Backend().getParkingID();
    print(aid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme2.grey2,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: GestureDetector(
          child: Image.asset(
            "assets/images/logofi.png",
            scale: 2,
          ),
        ),
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        backgroundColor: Theme2.yellow,
        centerTitle: true,
        title: Text(
          "Dashboard".toUpperCase(),
          style: TextStyle(color: Theme2.black),
        ),
        actions: [
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.notifications_outlined,
              color: Theme2.black,
              size: 30,
            ),
          )
        ],
      ),
      body: FutureBuilder(
          future: Backend().fetchData("/parkingDetails?id=$aid"),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              Map parkingDetails = snapshot.data;
              //aid = parkingDetails["parkingId"];
              print(parkingDetails);
              slots = parkingDetails["occupied"];
              revenue = parkingDetails["Revenue"];
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
      height: size.height,
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                constraints: BoxConstraints.tightFor(height: 150, width: 150),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme2.lightyellow,
                      Theme2.yellow2,
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: FlipCard(
                  front: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.attach_money_outlined,
                        size: 40,
                      ),
                      Text(
                        "Total Revenue",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  back: Center(
                    child: Text(
                      "Total revenue: Rs.$revenue",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                constraints: BoxConstraints.tightFor(height: 150, width: 150),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme2.lightyellow,
                      Theme2.yellow2,
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: FlipCard(
                  front: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.event_available_outlined,
                        size: 40,
                      ),
                      Text(
                        "Occupied Slots",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  back: Center(
                    child: Text(
                      "$slots/$totalslots",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CurrentBookings()));
                },
                child: Container(
                  constraints: BoxConstraints.tightFor(height: 150, width: 150),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme2.lightyellow,
                        Theme2.yellow2,
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.time_to_leave,
                        size: 40,
                      ),
                      Text(
                        "Current Bookings",
                        textAlign: TextAlign.center,
                      ),
                      
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

TableRow returnRows(String car, String pID) {
  return TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TableCell(
          child: Container(
            child: Center(
                child: Text(
              car,
              style: TextStyle(color: Palette.blue),
            )),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TableCell(
          child: Container(
            child: Center(
                child: Text(
              pID,
              style: TextStyle(color: Palette.blue),
            )),
          ),
        ),
      )
    ],
  );
}
