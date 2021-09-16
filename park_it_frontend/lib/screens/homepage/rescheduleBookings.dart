import 'package:flutter/material.dart';
import 'package:park_it/backend/backend.dart';
import 'package:park_it/config/theme.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RescheduleBookings extends StatefulWidget {
  @override
  _RescheduleBookingsState createState() => _RescheduleBookingsState();
}

class _RescheduleBookingsState extends State<RescheduleBookings> {
  String place = "ABC Mall";
  String address = "PQR Road, Pune - 27";
  String date = "5 September 2021";
  String time = "4 pm";
  int duration = 2;
  FToast fToast;
  int prevCost = 30;
  String bid;

  int estVal = 10;
  int price = 10;
  int newcost = 0;

  List<String> slotTime = ['1 hr', '2 hrs', '3 hrs'];

  bool bookingPresent = true;

  String dropdownValue = "1 hr";

  @override
  void initState() {
    super.initState();
    newcost = prevCost + (price);
    bid = Backend().getCurrentBookingId();
    print(bid);
    if (bid == null || bid == "") {
      bookingPresent = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    fToast = FToast();
    fToast.init(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme2.black),
        backgroundColor: Theme2.yellow,
        centerTitle: true,
        title: Text(
          'Renew booking',
          style: TextStyle(color: Theme2.black),
        ),
      ),
      body: FutureBuilder(
          future: Backend().fetchData("/bookingDetails?bookingId=$bid"),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (Backend().getStatusCode() == 200 && snapshot.data != null) {
              Map bookingData = snapshot.data;
              print(bookingData);
              place = bookingData["PlaceName"];
              String datetime = bookingData["Time"];
              date = datetime.split("T")[0];
              String unformattedTime = datetime.split("T")[1];
              time = unformattedTime.split(".")[0];
              //duration = bookingData["Duration"];
              prevCost = bookingData["PaymentAmount"];
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
    return (!bookingPresent)
        ? Center(
            child: Text("No current booking to renew!", style: TextStyle(color: Theme2.darkgrey, fontSize: 18),),
          )
        : Container(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Center(
                    child: Text("Your Current Booking Details".toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: Theme2.yellow2,
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
                            color: Theme2.yellow2,
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
                            color: Theme2.yellow2,
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
                          color: Theme2.yellow2,
                          size: 35,
                        ),
                        Text(
                          " Rs $prevCost/-",
                          style: TextStyle(
                            color: Theme2.black,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 20, thickness: 1),
                  Text(
                    "By how many hours do you want to extend your parking time?",
                    style: TextStyle(fontSize: 16),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      value: dropdownValue,
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(fontSize: 20, color: Theme2.black),
                      underline: Container(
                        height: 2,
                        color: Theme2.yellow2,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                          int val = int.parse(dropdownValue[0]);
                          duration = val;
                          estVal = val * price;
                          newcost = (prevCost + estVal);
                        });
                      },
                      items: slotTime
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "New estimated cost:",
                    style: TextStyle(fontSize: 16),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Rs $newcost/-",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Theme2.yellow)),
                      onPressed: () {
                        Map data = {
                          "duration": duration.toString(),
                          "newCost": newcost.toString(),
                        };
                        Backend()
                            .sendData("/renewBooking?bookingId=$bid", data)
                            .whenComplete(() {
                          _showToast();
                          Navigator.pop(context);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Confirm and Renew",
                          style: TextStyle(fontSize: 18, color: Theme2.black),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
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
          Text("Booking Renewed"),
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
