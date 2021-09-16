
class Location {
  final double lat;
  final double lon;

  Location({this.lat, this.lon});

  factory Location.fromJson(Map<dynamic, dynamic> parsedJson) {
    return Location(lat: parsedJson['lat'], lon: parsedJson['lon']);
  }
}
