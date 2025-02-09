import 'package:flutter_test/flutter_test.dart';
import 'package:guia_moteis/core/network/http_api_client.dart';
import 'package:guia_moteis/features/motels/data/repositories/motel_repository_protocol.dart';
import 'package:guia_moteis/features/motels/data/repositories/motel_repository.dart';
import 'package:http/http.dart' as http;

void main() {
  late MotelRepositoryProtocol repository;
  final String url = "https://www.jsonkeeper.com/b/1IXK";

  setUp(() {
    final apiClient = HttpApiClient(client: http.Client());
    repository = MotelRepository(apiClient: apiClient);
  });

  test('should fetch and return a list of MotelEntity from API', () async {
    final motels = await repository.fetchMotels();

    expect(motels, isA<List>());
    expect(motels.isNotEmpty, true);

    final motel = motels[0];
    expect(motel.name, isNotEmpty);
    expect(motel.suites, isA<List>());
  });

  test('should return empty list if API returns empty data', () async {
    final emptyRepository = MotelRepository(
      apiClient: HttpApiClient(
        client: http.Client(),
      ),
    );

    expect(await emptyRepository.fetchMotels(), isA<List>());
  });
}
