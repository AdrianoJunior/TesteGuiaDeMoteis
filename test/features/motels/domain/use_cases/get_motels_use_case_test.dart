import 'package:flutter_test/flutter_test.dart';
import 'package:guia_moteis/core/network/http_api_client.dart';
import 'package:guia_moteis/features/motels/domain/use_cases/get_motels_use_case.dart';
import 'package:guia_moteis/features/motels/data/repositories/motel_repository.dart';
import 'package:http/http.dart' as http;

void main() {
  late GetMotelsUseCase useCase;
  final String url = "https://www.jsonkeeper.com/b/1IXK";

  setUp(() {
    final apiClient = HttpApiClient(client: http.Client());
    final repository = MotelRepository(apiClient: apiClient);
    useCase = GetMotelsUseCase(repository);
  });

  test('should return a list of motels from real API', () async {
    final motels = await useCase.execute();

    expect(motels, isA<List>());
    expect(motels.isNotEmpty, true);

    final motel = motels[0];
    expect(motel.name, isNotEmpty);
    expect(motel.suites, isA<List>());
  });
}
