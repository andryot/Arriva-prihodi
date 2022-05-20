import 'dart:io';

import 'package:http/http.dart' as http;

import '../config/config.dart';

class HttpService {
  static HttpService? _instance;
  static HttpService get instance => _instance!;
  static const Duration timeoutDuration = Duration(seconds: 30);

  HttpService._();

  factory HttpService() {
    if (_instance != null) {
      throw StateError('HttpService already created');
    }

    _instance = HttpService._();
    return _instance!;
  }

  Uri parseUri(List<String> pathSegments) {
    return Uri(
      scheme: Config.backendApiScheme,
      host: Config.backendHost,
      pathSegments: pathSegments,
    );
  }

  Uri parseGetUri(
      List<String> pathSegments, Map<String, dynamic>? queryParameters) {
    return Uri(
      scheme: Config.backendApiScheme,
      host: Config.backendHost,
      pathSegments: pathSegments,
      queryParameters: queryParameters,
    );
  }

  http.Response requestTimeoutResponse() {
    return http.Response("", HttpStatus.requestTimeout);
  }

  Future<http.Response?> get(List<String> pathSegments,
      {Map<String, String>? headers,
      Map<String, dynamic>? queryParameters}) async {
    try {
      return await http
          .get(parseGetUri(pathSegments, queryParameters), headers: headers)
          .timeout(timeoutDuration, onTimeout: requestTimeoutResponse);
    } on SocketException catch (_) {
      return null;
    }
  }

  Future<http.Response?> post(List<String> pathSegments,
      {Map<String, String>? headers, Object? body}) async {
    try {
      return await http
          .post(
            parseUri(pathSegments),
            headers: headers,
            body: body,
          )
          .timeout(timeoutDuration, onTimeout: requestTimeoutResponse);
    } on SocketException catch (_) {
      return null;
    }
  }

  Future<http.Response?> patch(List<String> pathSegments,
      {Map<String, String>? headers, Object? body}) async {
    try {
      return await http
          .patch(
            parseUri(pathSegments),
            headers: headers,
            body: body,
          )
          .timeout(timeoutDuration, onTimeout: requestTimeoutResponse);
    } on SocketException catch (_) {
      return null;
    }
  }

  Future<http.Response?> del(List<String> pathSegments,
      {Map<String, String>? headers, Object? body}) async {
    try {
      return await http
          .delete(
            parseUri(pathSegments),
            headers: headers,
            body: body,
          )
          .timeout(timeoutDuration, onTimeout: requestTimeoutResponse);
    } on SocketException catch (_) {
      return null;
    }
  }

  Future<http.Response?> put(List<String> pathSegments,
      {Map<String, String>? headers, Object? body}) async {
    try {
      return await http
          .put(
            parseUri(pathSegments),
            headers: headers,
            body: body,
          )
          .timeout(timeoutDuration, onTimeout: requestTimeoutResponse);
    } on SocketException catch (_) {
      return null;
    }
  }
}
