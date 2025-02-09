import 'package:guia_moteis/features/motels/domain/entities/motel_entity.dart';

abstract class MotelRepositoryProtocol {
  Future<List<MotelEntity>> fetchMotels();
}
