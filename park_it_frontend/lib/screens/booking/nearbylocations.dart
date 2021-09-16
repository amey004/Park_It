import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:park_it/backend/backend.dart';
import 'package:park_it/screens/booking/confirmBooking.dart';
import 'package:provider/provider.dart';
import 'package:park_it/config/theme.dart';
import 'package:park_it/blocs/app_block.dart';

class NearbyLocation extends StatefulWidget {
  @override
  _NearbyLocationState createState() => _NearbyLocationState();
}

class _NearbyLocationState extends State<NearbyLocation> {
  int selectedIndex;
  List places = [];
  List areas = [];
  List distance = [];
  List time = [];
  // List occupied = [];
  List available = [];
  List AIDs = [];
  List images = [];
  List types = ["", "Mall", "Stadium", ""];
  @override
  void initState() {
    super.initState();
    places.clear();
    areas.clear();
    images.clear();
    AIDs.clear();
  }

  String uid = Backend().getID();
  Position userLocation;
  Map data;

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    userLocation = applicationBloc.currentLocation;
    data = {
      "lat": userLocation.latitude.toString(),
      "long": userLocation.longitude.toString()
    };
    print(uid);

    print(places.length);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Theme2.yellow,
        iconTheme: IconThemeData(color: Theme2.black),
        centerTitle: true,
        title: Text(
          "Book a parking spot!".toUpperCase(),
          style: TextStyle(
              fontSize: 20, color: Theme2.black, fontWeight: FontWeight.w500),
        ),
      ),
      backgroundColor: Theme2.grey2,
      body: FutureBuilder(
          future: Backend().sendData("/allparkingdetails", data),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(places.length);
            if (snapshot.data != null) {
              print(snapshot.data);
              List parkings = snapshot.data["allUsers"];
              print(parkings);
              for (var parking in parkings) {
                print(places.length);
                if (!places.contains(parking["placeName"])) {
                  places.add(parking["placeName"]);
                  areas.add(parking["Address"]);
                  images.add(parking['image']);
                  // occupied.add(parking["occupied"].toString());
                  int occ = parking["occupied"];
                  int r = parking["Row"];
                  print(r);
                  int c = parking["Columns"];
                  int total = r * c;
                  int av = total - occ;
                  available.add(av.toString());
                  print("Before adding");
                  AIDs.add(parking["_id"].toString());
                  distance.add(
                      ((parking["distance"] / 1000).round()).toString() +
                          ' kms');
                  time.add(
                      (parking["duration"] / 60).round().toString() + ' mins');
                  print("Before adding");
                  //AIDs.add(parking["_id"].toString());
                }
              }
              print(AIDs);
              print(places);
            }
            return (snapshot.data == null)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : getParkingDetails();
          }),
    );
  }

  Future _refreshData() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      places.clear();
      areas.clear();
      available.clear();
      AIDs.clear();
      images.clear();
    });
  }

  Widget getParkingDetails() {
    return RefreshIndicator(
      onRefresh: _refreshData,
      backgroundColor: Theme2.grey2,
      color: Theme2.black,
      child: ListView.builder(
        itemCount: places.length,
        itemBuilder: (BuildContext context, int i) {
          print(places);
          print(areas);
          print(available);
          return generateCard(context, places[i], areas[i], distance[i],
              time[i], images[i], available[i], AIDs[i], uid);
        },
      ),
    );
  }
}

Card generateCard(
    BuildContext context,
    String place,
    String area,
    String distance,
    String time,
    String image,
    String available,
    String aid,
    String uid) {
  Size size = MediaQuery.of(context).size;
  print(place);
  return Card(
    shadowColor: Colors.grey,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
      child: ExpansionTile(
        leading: Container(
          width: size.width * 0.3,
          child: Image(
            fit: BoxFit.fitWidth,
            image: AssetImage(image),
          ),
        ),
        title: Text(
          place,
          style: TextStyle(
            fontSize: 20,
            color: Theme2.black,
          ),
        ),
        subtitle: Text(
          area == null ? " " : area,
          style: TextStyle(
            fontSize: 15,
            color: Theme2.black,
          ),
        ),
        trailing: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Theme2.lightyellow)),
          child: Text(
            "Book",
            style: TextStyle(
              fontSize: 15,
              color: Theme2.black,
            ),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ConfirmBooking(
                          placeName: place,
                          address: area,
                          aid: aid,
                          uid: uid,
                          slots: available,
                        )));
          },
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Theme2.yellow2,
                    ),
                    Text(
                      distance,
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme2.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.time_to_leave_outlined,
                      color: Theme2.yellow2,
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme2.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.event_available_outlined,
                      color: Theme2.yellow2,
                    ),
                    Text(
                      available,
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme2.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
