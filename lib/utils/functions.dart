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
  //LocationData previousLocation=;

  // Start location tracking

  location.onLocationChanged.listen((LocationData currentLocation) {
    double latitude = currentLocation.latitude!;
    double longitude = currentLocation.longitude!;
    print("longitude : $longitude");
    print("Latitude : $latitude");

    // Compare with the previous location
    sendLocation(longitude, latitude);
    // if (isFirstLocationUpdate ||
    //     hasLocationChanged(previousLocation, currentLocation)) {
    //   print("lcoation changed");
    //   print("longitude : $longitude");
    //   print("Latitude : $latitude");
    //   // send location to backend

    //   // Update the previous location
    //   previousLocation = currentLocation;
    //   isFirstLocationUpdate = false;
    //   print(isFirstLocationUpdate);
    // }
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
  // if (roundDouble(previousLocation.latitude!, 6) !=
  //         roundDouble(currentLocation.latitude!, 6) ||
  //     roundDouble(previousLocation.longitude!, 6) !=
  //         roundDouble(currentLocation.longitude!, 6)) {
  print("pr : ${previousLocation.latitude}");
  print("current : ${currentLocation.latitude}");
  if ((previousLocation.latitude != currentLocation.latitude) ||
      (previousLocation.longitude != currentLocation.longitude)) {
    print("location has changed");
    return true; // Location has changed
  } else {
    print("location has not changed");
    return false; // Location has not changed
  }
}

void sendLocation(double longitude, double latitude) async {
  try {
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
      throw Exception(
          'failed to send location changes: ${response.statusCode}');
    }
  } on http.ClientException catch (clientException) {
    // skip exception to not crash the app
    print(clientException.message);
    print("failed to send location changes");
  }
}

Future<void> notifyMaintenanceMode() async {
  final url = Uri.parse('${dotenv.env["API_URL"]}/Distributeur/modeAm');
  final response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'identifiant': "0A1Z4",
        'maintenance': true,
      }));
  if (response.statusCode == 200) {
    print("maintenance mode notified");
  } else {
    throw Exception(
        'failed to notify maintenance mode: ${response.statusCode}');
  }
}

Future<String> fetchVerouCode() async {
  final url = Uri.parse(
      '${dotenv.env["API_URL"]}/Distributeur/log?ditributeurId=0A1Z4');
  final response = await http.get(url);
  // final response = await Client().send(request);
  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);
    return json["codeverou"].toString();
  } else {
    throw Exception('failed to load drinks,error code: ${response.statusCode}');
  }
}
