import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:park_it/services/geolocatorservice.dart';
import 'package:park_it/services/places_service.dart';

class ApplicationBloc with ChangeNotifier {
  final geolocatorService = GeolocatorService();
  final placesService = PlacesService();

  // Variables
  Position currentLocation;
  List searchResults;

  ApplicationBloc() {
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await geolocatorService.getCurrentLocation();
    notifyListeners();
  }

  searchPlaces(String searchTerm, String city, String type) async {
    searchResults = await placesService.getAutocomplete(searchTerm, city, type);
    print(searchResults);
    notifyListeners();
  }
}
