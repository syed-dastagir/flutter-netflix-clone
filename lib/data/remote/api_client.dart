import 'package:http/http.dart' as http;
import 'package:watchit/data/remote/api_constants.dart';

class ApiClient {
  final apiClient = http.Client();

  Future<String> get(String endpoint) async {
    final resposne = await http.get(Uri.parse(ApiConstants.baseUrl + endpoint),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${ApiConstants.token}'
        });
    if (resposne.statusCode == 200) {
      return resposne.body;
    } else {
      throw Exception(resposne.reasonPhrase);
    }
  }
}
