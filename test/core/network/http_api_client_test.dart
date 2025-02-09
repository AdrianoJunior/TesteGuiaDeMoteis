import 'package:flutter_test/flutter_test.dart';
import 'package:guia_moteis/core/network/http_api_client.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  late HttpApiClient apiClient;
  final String url = "https://www.jsonkeeper.com/b/1IXK"; // URL real da API

  setUp(() {
    apiClient = HttpApiClient(client: http.Client());
  });

  test('Deve buscar dados reais da API e analisar corretamente', () async {
    final result = await apiClient.get(url);

    // Verifica se a resposta é um mapa (não uma lista)
    expect(result, isA<Map>());
    expect(result["sucesso"], true); // A API deve retornar "sucesso: true"
    expect(result["data"], isA<Map>()); // O campo "data" deve ser um mapa

    final motels = result["data"]["moteis"];
    expect(motels, isA<List>()); // A lista de motéis deve ser uma lista
    expect(motels.isNotEmpty, true); // Pelo menos um motel deve existir

    final motel = motels.first;
    expect(motel["fantasia"], isNotNull); // O nome do motel deve existir
    expect(motel["suites"], isA<List>()); // As suítes devem ser uma lista
  });

  test('Deve lidar com falhas na requisição da API', () async {
    final invalidUrl = "https://www.jsonkeeper.com/b/INVALID";

    // Deve lançar uma exceção ao tentar acessar uma URL inválida
    expect(() async => await apiClient.get(invalidUrl), throwsException);
  });
}
