import 'package:flutter_test/flutter_test.dart';
import 'package:guia_moteis/core/network/http_api_client.dart';
import 'package:guia_moteis/features/motels/data/repositories/motel_repository_protocol.dart';
import 'package:guia_moteis/features/motels/data/repositories/motel_repository.dart';
import 'package:http/http.dart' as http;

void main() {
  late MotelRepositoryProtocol repository; // Define a interface do repositório
  final String url = "https://www.jsonkeeper.com/b/1IXK"; // URL real da API

  setUp(() {
    // Configura o repositório com um cliente HTTP real
    final apiClient = HttpApiClient(client: http.Client());
    repository = MotelRepository(apiClient: apiClient);
  });

  test('Deve buscar e retornar uma lista de MotelEntity da API', () async {
    // Executa a chamada ao repositório
    final motels = await repository.fetchMotels();

    // Verifica se o resultado é uma lista de motéis
    expect(motels, isA<List>());
    expect(motels.isNotEmpty, true);

    // Testa se o primeiro motel contém os atributos essenciais
    final motel = motels.first;
    expect(motel.name, isNotEmpty);
    expect(motel.suites, isA<List>());
  });
}
