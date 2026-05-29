import 'dart:convert';
import 'package:http/http.dart' as http;

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

  /// 🔥 HEADERS CENTRALIZADOS
  Map<String, String> _buildHeaders(Map<String, String>? headers) {
    final requestHeaders = {
      'Content-Type': 'application/json',
      ...?headers,
    };

    if (_token != null && _token!.isNotEmpty) {
      requestHeaders['Authorization'] = 'Bearer $_token';
      requestHeaders['apiKey'] = _token!; // Supabase
    }

    return requestHeaders;
  }

  /// 🔥 MANEJO DE RESPUESTA
  http.Response _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    } else {
      throw HttpException(
        'Error ${response.statusCode}: ${response.body}',
      );
    }
  }

  /// GET
  Future<http.Response> get(
      Uri url, {
        Map<String, String>? headers,
      }) async {
    final response = await _client.get(
      url,
      headers: _buildHeaders(headers),
    );

    return _handleResponse(response);
  }

  /// POST
  Future<http.Response> post(
      Uri url, {
        Map<String, String>? headers,
        Object? body,
      }) async {
    final response = await _client.post(
      url,
      headers: _buildHeaders(headers),
      body: body != null ? jsonEncode(body) : null,
    );

    return _handleResponse(response);
  }

  /// PATCH
  Future<http.Response> patch(
      Uri url, {
        Map<String, String>? headers,
        Object? body,
      }) async {
    final response = await _client.patch(
      url,
      headers: _buildHeaders(headers),
      body: body != null ? jsonEncode(body) : null,
    );

    return _handleResponse(response);
  }

  /// DELETE
  Future<http.Response> delete(
      Uri url, {
        Map<String, String>? headers,
      }) async {
    final response = await _client.delete(
      url,
      headers: _buildHeaders(headers),
    );

    return _handleResponse(response);
  }
}

/// EXCEPCIÓN PERSONALIZADA
class HttpException implements Exception {
  final String message;

  HttpException(this.message);

  @override
  String toString() => message;
}