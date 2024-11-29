import 'package:http/http.dart' as http;
import 'dart:convert';

Future<int> registerUser(
  String firstName,
  String lastName,
  String email,
  String password,
  String adress,
  String postalCode,
  String city,
  List<String> roles,
) async {
  var url = Uri.parse('https://s3-4987.nuage-peda.fr/music/api/users');
  var headers = {'Content-Type': 'application/ld+json'};
  var body = json.encode({
    'password': password,
    'lastName': lastName,
    'firstName': firstName,
    'email': email,
    'roles': roles,
    'address': adress,
    'postalCode': postalCode,
    'city': city,
  });
  try {
    var response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 201) {
      return response.statusCode;
    } else {
      // ignore: avoid_print
      print(
          "Échec de la requête : Code de statut ${response.statusCode}, Réponse : ${response.body}");
      return response.statusCode;
    }
  } catch (e) {
    // ignore: avoid_print
    print("Exception lors de la requête : $e");
    return 0;
  }
}

Future<http.Response> loginUser(String email, String password) async {
  final url = Uri.parse('https://s3-4987.nuage-peda.fr/music/api/authentication_token');
  final headers = {
    'accept': 'application/json',
    'Content-Type': 'application/json',  
  };
  final body = jsonEncode({
    'email': email,
    'password': password,
  });
  final response = await http.post(
    url,
    headers: headers,
    body: body,
  );
  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to login: ${response.reasonPhrase}');
  }
}
