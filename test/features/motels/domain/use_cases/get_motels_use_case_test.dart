import 'package:flutter_test/flutter_test.dart';
import 'package:guia_moteis/core/network/http_api_client.dart';
import 'package:guia_moteis/features/motels/domain/use_cases/get_motels_use_case.dart';
import 'package:guia_moteis/features/motels/data/repositories/motel_repository.dart';
import 'package:http/http.dart' as http;

void main() {
  late GetMotelsUseCase useCase;
  final String url = "https://www.jsonkeeper.com/b/1IXK"; // URL real da API

  setUp(() {
    // Configura o caso de uso com um cliente HTTP real e o repositório
    final apiClient = HttpApiClient(client: http.Client());
    final repository = MotelRepository(apiClient: apiClient);
    useCase = GetMotelsUseCase(repository);
  });

  test('Deve retornar uma lista de motéis ao chamar a API', () async {
    // Chama o caso de uso
    final motels = await useCase.execute();

    // Verifica se o retorno é uma lista de motéis
    expect(motels, isA<List>());
    expect(motels.isNotEmpty, true);

    // Testa se o primeiro motel contém os atributos essenciais
    final motel = motels.first;
    expect(motel.name, isNotEmpty);
    expect(motel.suites, isA<List>());
  });
}
