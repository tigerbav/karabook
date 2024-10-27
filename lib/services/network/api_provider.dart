import 'package:dio/dio.dart';

class ApiProvider {
  ApiProvider._();
  static final shared = ApiProvider._();
  static const _staticKey =
      '0e007493fbf1ea585c558cde957f2e8b03b08bb191961cfb2d6c186855b8dab0';

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

  Future<Response> put(String url, Map<String, dynamic> data) async {
    final response = await Dio().put(url, options: _options, data: data);
    return response;
  }

  Future<Response> patch(String url, Map<String, dynamic> data) async {
    final response = await Dio().patch(url, options: _options, data: data);
    return response;
  }
}
