import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesService {
  final key = '68eefee6ce5e41f8925b05338f91f69e';
  Future<List> getAutocomplete(String search, String city, String type) async {
    var url =
        'https://api.geoapify.com/v1/geocode/autocomplete?text=$search%20$type%20$city&apiKey=$key&filter=';
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResult = json['features'];
    List searchDetails = [];
    for (var i = 0; i < 5; i++) {
      var name = jsonResult[i]['properties']['name'];
      var placeId = jsonResult[i]['properties']['place_id'];
      var lat = jsonResult[i]['properties']['lat'];
      var lon = jsonResult[i]['properties']['lon'];
      Map value = {'name': '$name', 'lat': '$lat', 'lon': '$lon'};
      searchDetails.add(value);
    }

    return searchDetails;
  }
}
