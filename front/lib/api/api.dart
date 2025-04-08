import "dart:convert";

import "package:http/http.dart" as http;

class ApiService {
  final String baseUrl;
  bool isList;

  ApiService({
    this.baseUrl = "http://192.168.1.14:8000",
    this.isList = false,
  });

  Future<dynamic> _performRequest(
      String method,
      String path, {
      dynamic data,
  }) async {
    try {
      final url = Uri.parse(baseUrl + path);

      final response = await (method == "GET"
          ? http.get(url)
          : method == "POST"
              ? http.post(url, body: data)
              : method == "PUT"
                  ? http.put(url, body: data)
                  : http.delete(url));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        return {
          "error":
          "HTTP ${response.statusCode}: ${response.reasonPhrase}",
        };
      }
    } catch (error) {
      return {
        "error":
        error.toString(),
      };
    }
  }

  Future delete(String path) async {
    return await _performRequest("DELETE", path);
  }

  Future get(String path) async {
    return await _performRequest("GET", path);
  }

  Future post(String path, dynamic data) async {
    return await _performRequest("POST", path, data: data);
  }

  Future put(String path, dynamic data) async {
    return await _performRequest("PUT", path, data: data);
  }
}
