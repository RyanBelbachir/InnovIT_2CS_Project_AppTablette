import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../viewmodels/category.dart';
import '../viewmodels/commande.dart';

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
