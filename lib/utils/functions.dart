import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../viewmodels/category.dart';
import '../viewmodels/commande.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'dart:async';

Future<http.Response> sendSelectedDrink(
    int idRecette, int idIngredient, String quantiy) async {
  final url = Uri.parse('${dotenv.env["API_URL"]}/Distributeur/command');
  return http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'idRecette': idRecette,
        'idIngredient': idIngredient,
        'quantity': quantiy
      }));
}

Future<Commande> getCommande(id, sugar) async {
  http.Response response = await sendSelectedDrink(id, 1, sugar.toString());
  if (response.statusCode == 200) {
    return Commande.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to get commande code :  ${response.statusCode} ');
  }
}

Future<List<Category>> fetchCategories() async {
  final url = Uri.parse('${dotenv.env["API_URL"]}/Distributeur/categories');
  final response = await http.get(url);
  // final response = await Client().send(request);
  if (response.statusCode == 200) {
    List myList = jsonDecode(response.body);
    return myList.map((e) => Category.fromJson(e)).toList();
  } else {
    throw Exception(
        'failed to load categories,error code: ${response.statusCode}');
  }
}

void startLocationTracking() {
  var geolocator = Geolocator();
  var location = Location();
  bool isFirstLocationUpdate = true;
  LocationData previousLocation;

  // Start location tracking
  location.onLocationChanged.listen((LocationData currentLocation) {
    double latitude = currentLocation.latitude!;
    double longitude = currentLocation.longitude!;

    previousLocation = currentLocation;
    // Compare with the previous location
    if (isFirstLocationUpdate ||
        hasLocationChanged(previousLocation, currentLocation)) {
      print("lcoation changed");
      print("longitude : $longitude");
      print("Latitude : $latitude");
      // send location to backend
      sendLocation(longitude, latitude);

      // Update the previous location
      previousLocation = currentLocation;
      isFirstLocationUpdate = false;
    }
  });

  // Set up a timer to stop location tracking after a specific interval (optional)
  // timer = Timer.periodic(Duration(minutes: 5), (Timer t) {
  //   location.stop();
  //   timer.cancel();
  // });
}

double roundDouble(double value, int places) {
  //print(double.parse((value).toStringAsFixed(places)));
  return double.parse((value).toStringAsFixed(places));
}

bool hasLocationChanged(
    LocationData previousLocation, LocationData currentLocation) {
  // Compare latitude and longitude
  // we round it to 4 degits after the comma to reduce the rate of change
  if (roundDouble(previousLocation.latitude!, 4) !=
          roundDouble(currentLocation.latitude!, 4) ||
      roundDouble(previousLocation.longitude!, 4) !=
          roundDouble(currentLocation.longitude!, 4)) {
    return true; // Location has changed
  }
  return false; // Location has not changed
}

void sendLocation(double longitude, double latitude) async {
  final url = Uri.parse('${dotenv.env["API_URL"]}/Distributeur/localisation');
  final response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'distributeurId': "0A1Z4",
        'longitude': longitude.toString(),
        'latitude': latitude.toString()
      }));
  if (response.statusCode == 200) {
    print("location changes sent sucessfully");
  } else {
    throw Exception('failed to send location changes: ${response.statusCode}');
  }
}
