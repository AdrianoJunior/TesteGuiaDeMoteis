import 'package:guia_moteis/features/motels/data/repositories/motel_repository_protocol.dart';
import 'package:guia_moteis/features/motels/domain/entities/motel_entity.dart';

class GetMotelsUseCase {
  final MotelRepositoryProtocol repository;

  GetMotelsUseCase(this.repository);

  Future<List<MotelEntity>> execute() async {
    return await repository.fetchMotels();
  }
}
