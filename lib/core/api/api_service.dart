import 'package:bodega_da_esquina/core/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class APIService {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String url = "https://restful-ecommerce-ufma.herokuapp.com/login";

    final response = await http.post(url, body: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponseModel.fromJson(
        json.decode(response.body),
      );
      print(response.body);
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
