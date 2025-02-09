import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_client.dart';

/// Implementação do `ApiClient` que utiliza o pacote `http` para realizar requisições HTTP.
class HttpApiClient implements ApiClient {
  /// Cliente HTTP injetado para permitir testes e reutilização.
  final http.Client client;

  /// Construtor que exige a injeção de um `http.Client`,
  /// permitindo flexibilidade para testes.
  HttpApiClient({required this.client});

  /// Realiza uma requisição HTTP do tipo GET para a URL fornecida.

  /// - Retorna um `Future<dynamic>` que contém os dados da resposta decodificados em JSON.
  /// - Se a resposta for bem-sucedida (`statusCode == 200`), os dados são decodificados e retornados.
  /// - Caso contrário, lança uma exceção informando que houve erro ao buscar os dados.
  @override
  Future<dynamic> get(String url) async {
    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Converte os bytes para UTF-8 para evitar problemas com acentuação
      final decodedResponse = utf8.decode(response.bodyBytes);
      return json.decode(decodedResponse); // Converte JSON para um objeto Dart.
    } else {
      throw Exception('Erro ao buscar dados da API');
    }
  }
}
