import 'package:dio/dio.dart';

class ApiProvider {
  ApiProvider._();
  static final shared = ApiProvider._();

  static const _token =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJKV1QgU2lnbiBBZG1pbiIsImlhdCI6MTcxMjEzMTIxNSwiZXhwIjoxNzQzNjY3MjY3LCJhdWQiOiJrYXJhYm9vay5jb20iLCJzdWIiOiJuby1yZXBseUBrYXJhYm9vay5jb20iLCJHaXZlbk5hbWUiOiJBbmRyaWkiLCJTdXJuYW1lIjoiWmRyb2J5bGtvIiwiRW1haWwiOiJuby1yZXBseUBrYXJhYm9vay5jb20iLCJSb2xlIjoiRGV2ZWxvcGVyIn0.TzcJ9_DCuA3f1RI_0D1RDg4EhBJmbo3Ys6VEpy5GGUM';

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
}
