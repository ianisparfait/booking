import "dart:convert";

import "package:http/http.dart" as http;
import "package:booking/model/response.dart";

class ApiService {
  final String baseUrl;

  ApiService({
    required this.baseUrl,
  });

  Future<Response> _performRequest(String method, String path,
      {dynamic data}) async {
    try {
      final url = Uri.parse(baseUrl + path);
      var headers = withAuth();

      final response = await (method == "GET"
          ? http.get(url, headers: headers)
          : method == "POST"
              ? http.post(url, body: data, headers: headers)
              : method == "PUT"
                  ? http.put(url, body: data, headers: headers)
                  : http.delete(url, headers: headers));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonResponse = jsonDecode(response.body);

        return Response(
            resultType: method, resultError: null, resultData: jsonResponse);
      } else {
        return Response(
            resultType: method,
            resultError: "Network error: cannot retrieve documents.",
            resultData: null);
      }
    } catch (error) {
      return Response(
        resultType: method,
        resultError: error.toString(),
        resultData: null,
      );
    }
  }

  Future<Response> delete(String path) async {
    return await _performRequest("DELETE", path);
  }

  Future<Response> get(String path) async {
    return await _performRequest("GET", path);
  }

  Future<Response> post(String path, dynamic data) async {
    return await _performRequest("POST", path, data: data);
  }

  Future<Response> put(String path, dynamic data) async {
    return await _performRequest("PUT", path, data: data);
  }

  Map<String, String> withAuth() {
    String bearer = "";

    return {"Authorization": "Bearer $bearer"};
  }
}
