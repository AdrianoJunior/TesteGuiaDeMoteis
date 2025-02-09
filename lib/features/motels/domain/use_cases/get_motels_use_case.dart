import 'package:guia_moteis/features/motels/data/repositories/motel_repository_protocol.dart';
import 'package:guia_moteis/features/motels/domain/entities/motel_entity.dart';

/// Caso de uso responsável por obter a lista de motéis.

/// Segue o princípio da separação de responsabilidades, delegando a
/// busca de dados para o repositório injetado.
class GetMotelsUseCase {
  final MotelRepositoryProtocol repository;

  /// Construtor que recebe uma implementação do repositório.
  GetMotelsUseCase(this.repository);

  /// Executa a chamada ao repositório para buscar a lista de motéis.

  /// - Retorna uma `Future<List<MotelEntity>>` com os dados obtidos.
  Future<List<MotelEntity>> execute() async {
    return await repository.fetchMotels();
  }
}
