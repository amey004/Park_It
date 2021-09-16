import 'package:flutter/material.dart';
import 'package:park_it/backend/backend.dart';
import 'package:park_it/config/theme.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:park_it/screens/homepage/navigationbar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConfirmBooking extends StatefulWidget {
  ConfirmBooking(
      {Key key,
      @required this.placeName,
      @required this.address,
      @required this.slots,
      @required this.uid,
      @required this.aid})
      : super(key: key);
  final uid;
  final aid;
  final slots;
  final placeName;
  final address;
  @override
  _ConfirmBookingState createState() => _ConfirmBookingState();
}

class _ConfirmBookingState extends State<ConfirmBooking> {
  @override
  ConfirmBooking get widget => super.widget;
  String uid = "";
  String aid = "";
  String pname = "";
  String address = "";
  FToast fToast;
  String bookingDate = "Select Date";
  String bookingTime = "Select Time";
  String bookingDateTime;
  Color c1 = Theme2.black;
  Color c2 = Theme2.black;
  List<String> slotTime = ['1 hr', '2 hr', '3 hr', '4 hr', '5 hr', '6 hr'];
  String dropdownValue = '1 hr';
  int estVal = 0;
  int price = 30;
  int duration = 1;
  String availableSpaces = "";
  @override
  void initState() {
    super.initState();
    uid = widget.uid;
    aid = widget.aid;
    pname = widget.placeName;
    address = widget.address;
    availableSpaces = widget.slots;
    estVal = price;
  }

  @override
  Widget build(BuildContext context) {
    fToast = FToast();
    fToast.init(context);
    return Scaffold(
      backgroundColor: Theme2.grey2,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Theme2.yellow,
        iconTheme: IconThemeData(color: Theme2.black),
        title: Text(
          "Booking Details".toUpperCase(),
          style: TextStyle(
            fontSize: 20,
            color: Theme2.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  pname.toUpperCase(),
                  style: TextStyle(
                    color: Theme2.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Flexible(
                  child: Text(
                    address,
                    style: TextStyle(color: Theme2.black, fontSize: 17),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Available slots: " + availableSpaces,
                  style: TextStyle(color: Theme2.black, fontSize: 17),
                ),
              ),
              SizedBox(
                height: 30,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(
                  "When to reserve?".toUpperCase(),
                  style: TextStyle(
                    color: Theme2.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Theme2.lightyellow)),
                      child: Text(
                        bookingDate,
                        style: TextStyle(color: Theme2.black),
                      ),
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime.now(),
                            maxTime: DateTime(3021, 9, 3),
                            theme: DatePickerTheme(
                              headerColor: Theme2.lightyellow,
                              backgroundColor: Theme2.lightgrey,
                              itemStyle: TextStyle(
                                  color: Theme2.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                              doneStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              cancelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ), onConfirm: (date) {
                          setState(() {
                            bookingDate = date.toString().split(' ')[0];
                            c1 = Theme2.black;
                          });
                        });
                      },
                    ),
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Theme2.lightyellow)),
                      child: Text(
                        bookingTime.split('.')[0],
                        style: TextStyle(color: Theme2.black),
                      ),
                      onPressed: () {
                        DatePicker.showTime12hPicker(
                          context,
                          showTitleActions: true,
                          theme: DatePickerTheme(
                            headerColor: Theme2.lightyellow,
                            backgroundColor: Theme2.lightgrey,
                            itemStyle: TextStyle(
                                color: Theme2.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            doneStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                            cancelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          onConfirm: (time) {
                            setState(() {
                              bookingTime = time.toString().split(" ")[1];
                              c2 = Theme2.black;
                            });
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "Parking Duration".toUpperCase(),
                  style: TextStyle(
                    color: Theme2.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: DropdownButton<String>(
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
                        print(estVal);
                      });
                    },
                    items:
                        slotTime.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                child: Container(
                  child: Text(
                    'Estimated Amount:  Rs ' + estVal.toString() + '/-',
                    style: TextStyle(
                      color: Palette.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Spacer(),
              Center(
                  child: Text(
                "Your parking spot:",
                style: TextStyle(
                    color: Theme2.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              )),
              Center(
                child: Text(
                  "B10",
                  style: TextStyle(
                    color: Palette.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        // minimumSize: MaterialStateProperty.all(size/15,) ,
                        elevation: MaterialStateProperty.all(6),
                        backgroundColor:
                            MaterialStateProperty.all(Theme2.yellow)),
                    onPressed: () {
                      print(int.parse(availableSpaces));
                      if (bookingDate == "Select Date" ||
                          bookingTime == "Select Time") {
                        _showToast('Please select a date and time',
                            Colors.redAccent, Icon(Icons.cancel));
                      } else {
                        if (int.parse(availableSpaces) != 0) {
                          bookingDateTime = bookingDate + " " + bookingTime;

                          Map data = {
                            "userId": uid,
                            "parkingId": aid,
                            "PaymentAmount": estVal.toString(),
                            "Duration": duration.toString(),
                            "Time": bookingDateTime,
                            "PaymentConfirmation": "false",
                            "PlaceName": pname,
                            "NumberPlate": Backend().getNoPlate(),
                          };
                          //2021-09-01T00:00:00.000+00:00
                          print(data);
                          Backend()
                              .sendData("/createBooking", data)
                              .whenComplete(() {
                            Map bookingDetails = Backend().getData();
                            String bid = bookingDetails["BookingId"];

                            _showToast("Booking Confirmed", Colors.greenAccent,
                                Icon(Icons.check));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NavigationBar(
                                          selectedIndex: 1,
                                          bid: bid,
                                        )));
                          });
                        } else {
                          _showToast("Bookings full", Colors.redAccent,
                              Icon(Icons.cancel));
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Book",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
