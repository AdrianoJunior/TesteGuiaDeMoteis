import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_client.dart';

class HttpApiClient implements ApiClient {
  final http.Client client;

  HttpApiClient({required this.client});

  @override
  Future<dynamic> get(String url) async {
    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Força o decoding para UTF-8 para lidar com caracteres especiais
      final decodedResponse = utf8.decode(response.bodyBytes);
      return json.decode(decodedResponse);
    } else {
      throw Exception('Erro ao buscar dados da API');
    }
  }
}
