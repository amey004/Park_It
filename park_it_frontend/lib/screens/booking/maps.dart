import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_it/blocs/app_block.dart';
import 'package:provider/provider.dart';

class MapView extends StatefulWidget {
  const MapView({key}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Completer<GoogleMapController> _mapController = Completer();
  String city = 'Pune';
  String type = 'Mall';
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    print(applicationBloc.currentLocation);

    return Scaffold(
      body: (applicationBloc.currentLocation == null)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Search Here',
                        suffixIcon: Icon(Icons.search)),
                    onChanged: (value) {
                      print('Enter Text field');
                      applicationBloc.searchPlaces(value, city, type);
                    },
                  ),
                ), 
                Stack(
                  children: [
                    Container(
                      height: 600,
                      child: GoogleMap(
                        mapType: MapType.normal,
                        myLocationButtonEnabled: true,
                        initialCameraPosition: CameraPosition(
                            target: LatLng(
                                applicationBloc.currentLocation.latitude,
                                applicationBloc.currentLocation.longitude),
                            zoom: 14),
                        onMapCreated: (GoogleMapController controller) {
                          _mapController.complete(controller);
                        },
                      ),
                    ),
                    if (applicationBloc.searchResults != null &&
                        applicationBloc.searchResults.length != 0)
                      Container(
                          height: 600.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.6),
                              backgroundBlendMode: BlendMode.darken)),
                    if (applicationBloc.searchResults != null &&
                        applicationBloc.searchResults.length != 0)
                      Container(
                          height: 300.0,
                          child: ListView.builder(
                              itemCount: applicationBloc.searchResults.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    applicationBloc.searchResults[index]
                                        ['name'],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                      print(double.parse(applicationBloc
                                              .searchResults[index]['lon'])
                                          .runtimeType);
                                      _goToPlace(
                                          selectedIndex, applicationBloc);
                                      print('Printing SELECTED INDEX...');
                                      print(selectedIndex);
                                    });
                                  },
                                );
                              }))
                  ],
                )
              ],
            ),
    );
  }

  void _goToPlace(int index, ApplicationBloc applicationBloc) async {
    // final applicationBloc = Provider.of<ApplicationBloc>(context);
    print('Before target');
    final GoogleMapController controller = await _mapController.future;
    print('controller created');
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(
            double.parse(applicationBloc.searchResults[index]['lat']),
            double.parse(applicationBloc.searchResults[index]['lon'])),
        zoom: 14.0)));
    print('After target');
    print(applicationBloc.searchResults[index]['lat'] + 'hi');
    print('Printing L a t i t u d e');
  }
}
