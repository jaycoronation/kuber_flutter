import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:kuber/screen/places_autocomplete.dart';
import 'package:uuid/uuid.dart';

import '../constant/api_end_point.dart';

// We will use this util class to fetch the auto complete result and get the details of the place.
class PlaceApiProvider {
  PlaceApiProvider();
  final String sessionToken = const Uuid().v4();
  final apiKey = API_KEY;

  http.Request createGetRequest(String url) => http.Request('GET', Uri.parse(url));

  Future<List<Suggestion>> fetchSuggestions(String input) async {
    final url =
        'https://cors-anywhere.herokuapp.com/https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$apiKey&sessiontoken=$sessionToken';
    var request = createGetRequest(url);


    //http.StreamedResponse response = await request.send();

    var response = await http.get(Uri.parse(url), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'Access-Control-Allow-Origin' : 'true',
      'Access-Control-Allow-Methods' : 'GET, POST',
      'Access-Control-Allow-Headers' : 'X-Requested-With',
      'X-Requested-With' : 'XMLHttpRequest'
    });


    if (response.statusCode == 200) {
      final data = response.body;
      final result = json.decode(data);

      print(result);

      if (result['status'] == 'OK') {
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(
            p['place_id'], p['description'], p['structured_formatting']['main_text']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<PlaceDetail> getPlaceDetailFromId(String placeId) async {
    final url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=formatted_address,name,geometry/location&key=$apiKey&sessiontoken=$sessionToken';
    var request = createGetRequest(url);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      final result = json.decode(data);
      print(result);

      if (result['status'] == 'OK') {
        // build result
        final place = PlaceDetail();
        place.address = result['result']['formatted_address'];
        place.latitude = result['result']['geometry']['location']['lat'];
        place.longitude = result['result']['geometry']['location']['lng'];
        place.name = result['result']['name'];
        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}