import 'package:http/http.dart' as http;

// check if there are internet connectivity
Future<bool> checkNetworkStatus() async {
  try {
    final url = Uri.https('example.com', '');
    final res = await http.get(url);
    return res.statusCode == 200 ? true : false;
  } catch (_) {
    return false;
  }
}
