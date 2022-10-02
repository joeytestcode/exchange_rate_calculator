import 'package:http/http.dart';

class WebFetcher {
  static const _maxTry = 4;

  static Future<Response> _getResponse(String page) async {
    return await get(Uri.parse(page), headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Credentials': 'true',
      'Accept': 'application/json'
    });
  }

  static Future<Response> getPage(String page) async {
    Response response;
    int nTry = 0;
    do {
      response = await _getResponse(page);
      nTry++;
    } while (response.statusCode != 200 && nTry < _maxTry);

    return response;
  }
}
