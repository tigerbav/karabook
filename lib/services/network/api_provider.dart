import 'package:dio/dio.dart';

class ApiProvider {
  ApiProvider._();
  static final shared = ApiProvider._();

  static final _options = Options(
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      // "Authorization": "Bearer $_token",
    },
  );

  Future<Response> get(String url) async {
    final response = await Dio().get(url, options: _options);
    return response;
  }

  Future<Response> delete(String url) async {
    final response = await Dio().delete(url, options: _options);
    return response;
  }

  Future<Response> post(String url, Map<String, dynamic> data) async {
    final response = await Dio().post(url, options: _options, data: data);
    return response;
  }
}
