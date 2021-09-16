import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:park_it/backend/backend.dart';
import 'package:park_it/screens/booking/confirmBooking.dart';
import 'package:provider/provider.dart';
import 'package:park_it/config/theme.dart';
import 'package:park_it/blocs/app_block.dart';

class Parkings extends StatefulWidget {
  @override
  _ParkingsState createState() => _ParkingsState();
}

class _ParkingsState extends State<Parkings> {
  int selectedIndex;
  List places = [];
  List areas = [];
  List distance = [];
  List time = [];
  //List occupied = [];
  List available = [];
  List AIDs = [];
  List images = [];
  List types = ["", "Mall", "Stadium", ""];

  Map data;
  Position userLocation;
  @override
  void initState() {
    super.initState();
    places.clear();
    areas.clear();
    // occupied.clear();
    available.clear();
    AIDs.clear();
    images.clear();
    distance.clear();
    time.clear();
  }

  String uid = Backend().getID();

  @override
  Widget build(BuildContext context) {
    print(uid);
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    userLocation = applicationBloc.currentLocation;
    data = {
      "lat": userLocation.latitude.toString(),
      "long": userLocation.longitude.toString()
    };
    print(data);
    print(places.length);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Palette.cream,
        iconTheme: IconThemeData(color: Palette.red),
        centerTitle: true,
        title: Text(
          "Book a parking spot!".toUpperCase(),
          style: TextStyle(
              fontSize: 20, color: Palette.red, fontWeight: FontWeight.w500),
        ),
      ),
      backgroundColor: Palette.white,
      body: FutureBuilder(
          future: Backend().sendData("/allparkingdetails", data),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(places.length);
            if (snapshot.data != null) {
              print(snapshot.data);
              List parkings = snapshot.data["allUsers"];
              print(parkings);
              for (var parking in parkings) {
                //print(places.length);
                if (!places.contains(parking["placeName"])) {
                  places.add(parking["placeName"]);
                  areas.add(parking["Address"]);
                  //occupied.add(parking["occupied"].toString());
                  print("Before occupied");
                  int occ = parking["occupied"];
                  int r = parking["Row"];
                  print(r);
                  int c = parking["Columns"];
                  int total = r * c;
                  int av = total - occ;
                  available.add(av.toString());
                  print("Before adding");
                  AIDs.add(parking["_id"].toString());
                  images.add(parking['image']);
                  distance.add(
                      ((parking["distance"] / 1000).round()).toString() +
                          ' kms');
                  time.add(
                      (parking["duration"] / 60).round().toString() + ' mins');
                }
              }
              print(AIDs);
              print(images);
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
      images.clear();
      available.clear();
      AIDs.clear();
      distance.clear();
      time.clear();
    });
  }

  Widget getBody() {
    return buildPage(context, selectedIndex);
  }

  Widget buildPage(BuildContext context, int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        {
          selectedIndex = 0;
          return Container();
        }
      case 1:
        {
          selectedIndex = 1;
          return Container();
        }
      case 2:
        {
          selectedIndex = 2;
          return getParkingDetails();
        }
    }
    return Container();
  }

  Widget getParkingDetails() {
    return RefreshIndicator(
      onRefresh: _refreshData,
      backgroundColor: Palette.white,
      color: Palette.red,
      child: ListView.builder(
        itemCount: places.length,
        itemBuilder: (BuildContext context, int i) {
          print(places);
          print(distance);
          print(images);
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
            color: Palette.blue,
          ),
        ),
        subtitle: Text(
          area == null ? " " : area,
          style: TextStyle(
            fontSize: 15,
            color: Palette.blue,
          ),
        ),
        trailing: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Colors.green.shade700)),
          child: Text(
            "Book",
            style: TextStyle(
              fontSize: 15,
              color: Palette.white,
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
                      color: Palette.red,
                    ),
                    Text(
                      distance,
                      style: TextStyle(
                        fontSize: 15,
                        color: Palette.blue,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.time_to_leave_outlined,
                      color: Palette.red,
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 15,
                        color: Palette.blue,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.event_available_outlined,
                      color: Palette.red,
                    ),
                    Text(
                      available,
                      style: TextStyle(
                        fontSize: 15,
                        color: Palette.blue,
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

/* Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DefaultTabController(
              length: 4,
              initialIndex: 0,
              child: Column(
                children: [
                  TabBar(
                    isScrollable: true,
                    indicatorColor: Palette.red,
                    tabs: [
                      Tab(
                        child: Text(
                          "All".toUpperCase(),
                          style: TextStyle(
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Malls".toUpperCase(),
                          style: TextStyle(
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Stadiums".toUpperCase(),
                          style: TextStyle(
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      // Tab(
                      //   child: Text(
                      //     "Restaurants".toUpperCase(),
                      //     style: TextStyle(
                      //       letterSpacing: 2,
                      //     ),
                      //   ),
                      // ),
                      Tab(
                        child: Text(
                          "Others".toUpperCase(),
                          style: TextStyle(
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ],
                    onTap: (value) {
                      print(value);
                      /* String text = types[value];
                      print("**********************");
                      print(text);
                      applicationBloc.searchPlaces(text, "Westend, Pune", text);
                      print("Printing search results................");
                      print(applicationBloc.searchResults); */
                    },
                    labelColor: Palette.blue,
                    unselectedLabelColor: Colors.black.withOpacity(0.3),
                    labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    labelPadding: EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                  ),
                  Divider(
                    color: Colors.black.withOpacity(0.3),
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ), */
