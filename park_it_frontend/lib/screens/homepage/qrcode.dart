
import 'package:flutter/material.dart';
import 'package:park_it/backend/backend.dart';
import 'package:park_it/components/rounded_button.dart';
import 'package:park_it/config/theme.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OpenQR extends StatefulWidget {
  OpenQR({Key key, @required this.bid}) : super(key: key);
  final bid;
  @override
  _OpenQRState createState() => _OpenQRState();
}

class _OpenQRState extends State<OpenQR> {
  @override
  OpenQR get widget => super.widget;
  String bid;
  String qrData = "";
  String place = "ABC Mall";
  String address = "PQR Road, Pune - 27";
  String date = "5 September 2021";
  String time = "4 pm";
  String duration = "2 hrs";
  String expectedCost = "Rs. 10";
  String status = "Paid";
  DateTime endTime = DateTime.now();
  FToast fToast;
  bool bookingPresent = true;
  bool bookingCancelled = false;
  String uid = Backend().getID();


  @override
  void initState() {
    super.initState();
    bookingPresent = true;
    print("USER ID:");
    print(Backend().getID());
    print("PARKING ID");
    print(Backend().getParkingID());
    print("CURRENT BOOKING ID");
    print(Backend().getCurrentBookingId());
    bid = Backend().getCurrentBookingId();
  }

  @override
  Widget build(BuildContext context) {
    fToast = FToast();
    fToast.init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme2.grey2 ,
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Theme2.yellow,
          iconTheme: IconThemeData(color: Theme2.black),
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            "Current Booking".toUpperCase(),
            style: TextStyle(
              color: Theme2.black,
            ),
          ),
        ),
        body: FutureBuilder(
            future: Backend().fetchData("/bookingDetails?bookingId=$bid"),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (Backend().getStatusCode() == 200 && snapshot.data != null) {
                Map bookingData = snapshot.data;
                aid = bookingData["parkingId"];
                place = bookingData["PlaceName"];
                String datetime = bookingData["Time"];
                date = datetime.split("T")[0];
                String unformattedTime = datetime.split("T")[1];
                time = unformattedTime.split(".")[0];
                duration = bookingData["Duration"].toString();
                print(duration);

                expectedCost = bookingData["PaymentAmount"].toString();
                print(bookingData);
                DateTime startTime = DateTime.parse(date + " " + time);
                endTime = startTime.add(Duration(hours: int.parse(duration)));
                print(endTime);
                qrData =
                    "{'place':'$place','date':'$date','time':'$time','duration':'$duration','cost':'$expectedCost'}";
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
    if (endTime.isBefore(DateTime.now())) {
      bookingPresent = false;
    }
    return (!bookingPresent)
        ? Center(
            child: Container(
              
              child: Text("No current bookings", style: TextStyle(color: Theme2.darkgrey, fontSize: 20, fontWeight: FontWeight.w500),),
            ),
          )
        : Container(
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: QrImage(
                      data: qrData,
                      version: QrVersions.auto,
                      size: 175,
                    ),
                  ),
                ),
                Divider(
                  height: 15,
                  thickness: 1,
                  color: Palette.blue,
                  endIndent: 20,
                  indent: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_pin,
                              color: Theme2.darkgrey,
                              size: 35,
                            ),
                            Text(
                              place,
                              style: TextStyle(
                                color: Theme2.black,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: Icon(
                                Icons.calendar_today,
                                color: Theme2.darkgrey,
                                size: 35,
                              ),
                            ),
                            Text(
                              date,
                              style: TextStyle(
                                color: Theme2.black,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: Icon(
                                Icons.timer_rounded,
                                color: Theme2.darkgrey,
                                size: 35,
                              ),
                            ),
                            Text(
                              time,
                              style: TextStyle(
                                color: Theme2.black,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.account_balance_wallet_outlined,
                              color: Theme2.darkgrey,
                              size: 35,
                            ),
                            Text(
                              ' Rs '+expectedCost,
                              style: TextStyle(
                                color: Theme2.black,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          openGoogleMaps();
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: RoundedButton(
                            title: 'Get to Location', factor: 0.8),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                          onTap: () => showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                      "Are you sure you want to cancel your booking?"),
                                  content: ButtonBar(
                                    alignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            print(aid);
                                            print(bid);

                                            Navigator.pop(context);
                                          },
                                          child: Text("No")),
                                      InkWell(
                                          onTap: () {
                                            _showToast();
                                            Navigator.pop(context);
                                            setState(() {
                                              Backend().sendData(
                                                  "/cancelBooking?parkingId=$aid&bookingId=$bid",
                                                  null);

                                              bookingPresent = false;
                                              bookingCancelled = true;
                                            });
                                          },
                                          child: Text("Yes")),
                                    ],
                                  ),
                                );
                              }),
                          borderRadius: BorderRadius.circular(30),
                          child: RoundedButton(
                            title: 'Cancel Booking',
                            factor: 0.8,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  openGoogleMaps() {
    String url1 = "https://maps.google.com/?q=" + 'Westend,Pune';
    launch(url1);
  }

  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("Booking Cancelled"),
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
