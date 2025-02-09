import 'package:guia_moteis/features/motels/data/models/motel_model.dart';
import 'package:guia_moteis/features/motels/data/repositories/motel_repository_protocol.dart';
import 'package:guia_moteis/features/motels/domain/entities/motel_entity.dart';
import 'package:guia_moteis/core/network/http_api_client.dart';

class MotelRepository implements MotelRepositoryProtocol {
  final HttpApiClient apiClient;

  MotelRepository({required this.apiClient});

  @override
  Future<List<MotelEntity>> fetchMotels() async {
    try {
      final response = await apiClient.get('https://www.jsonkeeper.com/b/1IXK');

      if (response['sucesso'] == true) {
        final List<dynamic> data = response['data']['moteis'];

        return data.map((json) => MotelModel.fromJson(json)).toList();
      } else {
        throw Exception('Erro ao carregar motéis: resposta inválida.');
      }
    } catch (e) {
      throw Exception('Erro ao carregar motéis: $e');
    }
  }
}
