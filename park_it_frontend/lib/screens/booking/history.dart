import 'package:flutter/material.dart';
import 'package:park_it/backend/backend.dart';
import 'package:park_it/config/theme.dart';

class BookingHistory extends StatefulWidget {
  @override
  _BookingHistoryState createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {
  Color rowColor = Palette.white;

  List places = [];

  List costs = [];

  List timestamp = [];
  List dateTime = [];
  List dates = [];
  String uid = Backend().getID();

  List items = [];

  @override
  void initState() {
    super.initState();
    places.clear();
    costs.clear();
    timestamp.clear();
    dates.clear();
    dateTime.clear();
  }

  Future _refreshData() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme2.grey2,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        backgroundColor:Theme2.yellow,
        automaticallyImplyLeading: true,
        title: Text(
          'Booking History'.toUpperCase(),
          style: TextStyle(color: Theme2.black, fontSize: 20),
        ),
        iconTheme: IconThemeData(color: Theme2.black),
      ),
      body: FutureBuilder(
          future: Backend().fetchData("/recentBookings?id=$uid"),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              print(snapshot.data["recentBookings"]);
              List recentBookings = snapshot.data["recentBookings"];
              for (var booking in recentBookings) {
                if (booking != null) {
                  print(booking["PaymentAmount"]);
                  print(booking["PlaceName"]);
                  print(booking["Time"]);
                  String date = booking["Time"].toString().split("T")[0];
                  String time = booking["Time"].toString().split("T")[1];
                  time = time.split(".")[0];
                  time = time.split(":")[0] + ":" + time.split(":")[1];
                  if (!dateTime.contains(booking["Time"])) {
                    dateTime.add(booking["Time"]);
                    places.add(booking["PlaceName"]);
                    timestamp.add(time);
                    costs.add(booking["PaymentAmount"].toString());
                    dates.add(date);
                    print(date);
                    final row = RowDetails(
                        place: booking["PlaceName"],
                        date: date,
                        time: time,
                        cost: booking["PaymentAmount"].toString());
                    items.add(row);
                  }
                }
                print(items);
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
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: ListView(children: <Widget>[
        DataTable(
            sortColumnIndex: 0,
            dataRowColor: MaterialStateProperty.all(rowColor),
            columnSpacing: 20,
            columns: [
              DataColumn(
                  label: Text('Place',
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Date',
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Time',
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Cost',
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold))),
            ],
            rows: List.generate(items.length,
                (index) => getRow(items[items.length - index - 1]))),
      ]),
    );
  }

  DataRow getRow(RowDetails row) {
    return DataRow(cells: [
      DataCell(Text(row.place)),
      DataCell(Text(row.date)),
      DataCell(Text(row.time)),
      DataCell(Text(row.cost)),
    ]);
  }
}

class RowDetails {
  String place;
  String date;
  String time;
  String cost;

  RowDetails({this.place, this.date, this.time, this.cost});

  void sortByPlace() {}
}

 //  [
              //   // DataRow(cells: [
              //   //   DataCell(Text('MH-17-AZ-4551')),
              //   //   DataCell(Text('B10')),
              //   //   DataCell(Text('05:30:00')),
              //   // ]),
              //   // DataRow(cells: [
              //   //   DataCell(Text('MH-17-AZ-4551')),
              //   //   DataCell(Text('E10')),
              //   //   DataCell(Text('04:30:00')),
              //   // ]),
              // ],