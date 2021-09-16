import 'package:flutter/material.dart';
import 'package:park_it/backend/backend.dart';
import 'package:park_it/config/theme.dart';
import 'package:park_it/screens/booking/history.dart';
import 'package:park_it/screens/booking/nearbylocations.dart';
import 'package:park_it/screens/booking/parkings.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:park_it/screens/homepage/rescheduleBookings.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String bid;
  bool bookingPresent;
  DateTime currentTime = DateTime.now();
  DateTime endTime;
  DateTime startTime;
  int duration = 1;
  int leftDuration = 100;
  Duration d;
  bool timerStart;
  CountdownController countdownController;
  //StreamController timeController = StreamController();

  bool isRunning = false;

  @override
  void initState() {
    super.initState();
    bid = Backend().getCurrentBookingId();
    print(bid);
    isRunning = true;
    if (bid == "" || bid == null) {
      bookingPresent = false;
    } else {
      bookingPresent = true;
      print(bookingPresent);
      print(currentTime);
    }
    countdownController = CountdownController(
        duration: Duration(seconds: 100),
        onEnd: () {
          isRunning = false;
          timerStart = false;
        });
    timerStart = false;
  }

  String uid = Backend().getID();

  @override
  Widget build(BuildContext context) {
    setTimer();
    setState(() {
      bid = Backend().getCurrentBookingId();
      print(bid);
    });
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Theme2.grey2,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: GestureDetector(
            child: Image.asset(
              "assets/images/logo.jpg",
              scale: 2,
            ),
          ),
          centerTitle: true,
          toolbarHeight: 70,
          automaticallyImplyLeading: false,
          backgroundColor: Theme2.yellow,
          title: Text(
            "Dashboard".toUpperCase(),
            style: TextStyle(color: Theme2.black, fontSize: 20),
          ),
          leading: GestureDetector(
            child: Image.asset(
              "assets/images/logofi.png",
              scale: 2,
            ),  
          ),
          actions: [
            IconButton(
              onPressed: null,
              icon: Icon(
                Icons.notifications_outlined,
                color: Theme2.black,
                size: 30,
              ),
            ),
          ],
        ),
        body: FutureBuilder(
            future: Backend().fetchData("/bookingDetails?bookingId=$bid"),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (Backend().getStatusCode() == 200 &&
                  snapshot.data != null &&
                  snapshot.data["Time"] != null) {
                print("*********************************************");
                print(snapshot.data);

                String dateTime = snapshot.data["Time"]; //wrong format
                String date = dateTime.split("T")[0];
                String time = dateTime.split("T")[1];
                time = time.split("Z")[0];
                startTime = DateTime.parse(date + " " + time);
                print(startTime);
                duration = snapshot.data["Duration"];
                endTime = startTime.add(Duration(hours: duration));
                print(endTime);
                print(currentTime.isBefore(startTime));
                leftDuration = endTime.difference(currentTime).inSeconds;
                print(leftDuration);
                d = Duration(seconds: leftDuration);

                countdownController = CountdownController(
                    duration: d,
                    onEnd: () {
                      isRunning = false;
                      timerStart = false;
                    });

                timerStart = true;
                //print(diff);
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
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
<<<<<<< HEAD
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("/assets/images/logo.jpg")),
              ),
            ),
=======
>>>>>>> 18fab65c6f9045730e3f580214c0315c6a52497e
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
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
                  child: InkWell(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 40,
                          color: Theme2.black,
                        ),
                        Text(
                          "Nearby Locations",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme2.black,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NearbyLocation()));
                    },
                  ),
                ),
                Container(
                  constraints: BoxConstraints.tightFor(height: 150, width: 150),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme2.lightyellow,
                        Theme2.yellow2
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookingHistory()));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history_outlined,
                          size: 40,
                          color: Theme2.black,
                        ),
                        Text(
                          "Booking History",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme2.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  constraints: BoxConstraints.tightFor(height: 150, width: 150),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme2.lightyellow,
                        Theme2.yellow2
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => NearbyLocation()));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.time_to_leave_outlined,
                          size: 40,
                          color: Theme2.black,
                        ),
                        Text(
                          "Book Now",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme2.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  constraints: BoxConstraints.tightFor(height: 150, width: 150),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme2.lightyellow,
                        Theme2.yellow2
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RescheduleBookings()));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          size: 40,
                          color: Theme2.black,
                        ),
                        Text(
                          "Renew Booking",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme2.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 100,
              width: 250,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Theme2.yellow,
                    Theme2.yellow2
                  ])),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: timerBox(bookingPresent, timerStart)),
            ),
          ],
        ),
      ),
    );
  }

  void setTimer() {
    if (!countdownController.isRunning) {
      countdownController.start();
      if (mounted) {
        setState(() {
          isRunning = true;
        });
      }
    } else {
      countdownController.stop();
      if (mounted) {
        setState(() {
          isRunning = false;
        });
      }
    }
  }

  Widget timerBox(bool bookingPresent, bool timerStart) {
    return (!bookingPresent)
        ? Center(
            child: Text(
            "No Current Booking".toUpperCase(),
            style: TextStyle(color: Theme2.black, fontSize: 18, fontWeight: FontWeight.w600),
          ))
        : (!timerStart)
            ? Center(
                child: Text("Loading"),
              )
            : (currentTime.isBefore(endTime))
                ? (!currentTime.isBefore(startTime))
                    ? Container(
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Remaining time ",
                              style: TextStyle(
                                color: Theme2.black,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Countdown(
                                  countdownController: countdownController,
                                  builder: (_, Duration time) {
                                    if (time.inHours == 0) {
                                      return Text(
                                        '${time.inMinutes % 60} minutes',
                                        style: TextStyle(
                                            fontSize: 30, color: Theme2.black),
                                      );
                                    }
                                    return Text(
                                      '${time.inHours} hrs ${time.inMinutes % 60} minutes',
                                      style: TextStyle(
                                          fontSize: 30, color: Theme2.black),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Starts at",
                              style: TextStyle(
                                color: Theme2.black,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Text(
                                '${startTime.hour}:${startTime.minute}:${startTime.second}',
                                style: TextStyle(
                                    fontSize: 40, color: Theme2.black),
                              ),
                            ),
                          ],
                        ),
                      )
                : Center(
                    child: Text("No Current Bookings", style: TextStyle(color: Theme2.black),),
                  );
  }
}
