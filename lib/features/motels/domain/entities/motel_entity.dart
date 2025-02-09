import 'suite_entity.dart';

class MotelEntity {
  final String name;
  final String logo;
  final String neighborhood;
  final double rating;
  final double distancia;
  final int reviewCount;
  final List<SuiteEntity> suites;

  MotelEntity({
    required this.name,
    required this.logo,
    required this.neighborhood,
    required this.rating,
    required this.reviewCount,
    required this.distancia,
    required this.suites,
  });
}
