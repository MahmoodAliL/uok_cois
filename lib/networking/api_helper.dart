import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'custom_exception.dart';

class ApiHelper {
  final String _baseUrl = 'http://cois.uokerbala.edu.iq/wp/wp-json/wp/v2/';

  Future<dynamic> get(url) async {
    var fullUrl = _baseUrl + url;
    final response = await http.get(fullUrl);
    return _response(response);
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        print(responseJson);
        return responseJson;

      case 400:
        throw BadRequestException(response.body.toString());

      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server with StatusCode: ${response.statusCode}');
    }
  }
}
