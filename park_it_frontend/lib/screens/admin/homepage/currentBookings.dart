import 'package:flutter/material.dart';
import 'package:park_it/backend/backend.dart';
import 'package:park_it/config/theme.dart';

class CurrentBookings extends StatefulWidget {
  @override
  _CurrentBookingsState createState() => _CurrentBookingsState();
}

class _CurrentBookingsState extends State<CurrentBookings> {
  List items = [];
  String aid;
  @override
  void initState() {
    super.initState();
    aid = Backend().getParkingID();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme2.grey2,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Theme2.yellow,
        iconTheme: IconThemeData(color: Theme2.black),
        title: Text(
          "Current Bookings",
          style: TextStyle(color: Theme2.black),
        ),
      ),
      body: FutureBuilder(
          future: Backend().fetchData("/currentBookings?parkingId=$aid"),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              print(snapshot.data);
              List users = snapshot.data["currentBookings"];
              for (var details in users) {
                String dateTime = details["Time"];
                String d = dateTime.split("T")[0];
                String t = dateTime.split("T")[1];
                t = t.split(".")[0];
                t = t.split(":")[0] + ":" + t.split(":")[1];
                dateTime = d + " " + t;
                final item = RowDetails(
                  numberplate: details["NumberPlate"],
                  time: t,
                  date: d,
                  duration: details["Duration"].toString(),
                  cost: details["PaymentAmount"].toString(),
                );
                print(item.cost);
                print(item.duration);
                print(item.numberplate);
                print(item.time);
                items.add(item);
              }
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
      //width: size.width * 0.95,
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(Theme2.grey),
        horizontalMargin: 2,
        columnSpacing: size.width/14.5,
        columns: [
          DataColumn(label: Text("Number Plate")),
          DataColumn(label: Text("Date")),
          DataColumn(label: Text("Time")),
          DataColumn(label: Text("Duration")),
          DataColumn(label: Text("Cost")),
        ],
        rows: List.generate(
          items.length,
          (index) => getRow(items[index]),
        ),
      ),
    );
  }

  DataRow getRow(RowDetails row) {
    return DataRow(cells: [
      DataCell(Text(row.numberplate, textAlign: TextAlign.center,)),
      DataCell(Text(row.date, textAlign: TextAlign.center,)),
      DataCell(Text(row.time, textAlign: TextAlign.center,)),
      DataCell(Text(row.duration, textAlign: TextAlign.center,)),
      DataCell(Text(row.cost, textAlign: TextAlign.center,)),
    ]);
  }
}

class RowDetails {
  String cost;
  String numberplate;
  String time;
  String date;
  String duration;

  RowDetails(
      {this.cost, this.numberplate, this.time, this.duration, this.date});

  void sortByPlace() {}
}
