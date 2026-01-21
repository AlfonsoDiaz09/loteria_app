import 'package:http/http.dart' as http;
import 'package:loteria_app/main.dart';

class ClientManager {
  static final ClientManager _instance = ClientManager._internal();

  late http.Client _client;
  String? _token;

  ClientManager._internal() {
    _client = http.Client();
  }

  static ClientManager get instance => _instance;

  void setToken(String? token) {
    _token = token;
  }

  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    final requestHeaders = {
      ...?headers,
      'Content-type': 'application/json'
    };

    if (_token != null && _token!.isNotEmpty) {
      requestHeaders['Authorization'] = 'Bearer $_token';
      requestHeaders['apiKey'] = _token!;
    }
    return _client.get(url, headers: requestHeaders);
  }

  Future<http.Response> post(Uri url, {Map<String, String>? headers, Object? body}) async {
    final requestHeaders = {
      ...?headers,
      'Content-type': 'application/json'
    };

    if (_token != null && _token!.isNotEmpty) {
      requestHeaders['Authorization'] = 'Bearer $_token';
    }
    return _client.post(
      url,
      headers: requestHeaders,
      body: body,
    );
  }
}