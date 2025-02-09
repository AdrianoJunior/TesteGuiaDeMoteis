import 'package:flutter_test/flutter_test.dart';
import 'package:guia_moteis/core/network/http_api_client.dart';
import 'package:http/http.dart' as http;

void main() {
  late HttpApiClient apiClient;
  final String url = "https://www.jsonkeeper.com/b/1IXK";

  setUp(() {
    apiClient = HttpApiClient(client: http.Client());
  });

  test('should fetch real data from API and parse it correctly', () async {
    final result = await apiClient.get(url);

    expect(result, isA<List>());
    expect(result.isNotEmpty, true);

    final motel = result[0];
    expect(motel["name"], isNotNull);
    expect(motel["suites"], isA<List>());
  });

  test('should handle API request failure gracefully', () async {
    final invalidUrl = "https://www.jsonkeeper.com/b/INVALID";

    expect(() => apiClient.get(invalidUrl), throwsException);
  });
}
