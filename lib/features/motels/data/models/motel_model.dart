import 'package:guia_moteis/features/motels/data/models/suite_model.dart';
import 'package:guia_moteis/features/motels/domain/entities/motel_entity.dart';


class MotelModel extends MotelEntity {
  MotelModel({
    required super.name,
    required super.logo,
    required super.neighborhood,
    required super.rating,
    required super.reviewCount,
    required super.distancia,
    required super.suites,
  });

  factory MotelModel.fromJson(Map<String, dynamic> json) {
    return MotelModel(
      name: json['fantasia'] ?? 'Nome não disponível',
      logo: json['logo'] ?? '',
      neighborhood: json['bairro'] ?? 'Localização não disponível',
      rating: (json['media'] ?? 0).toDouble(),
      reviewCount: json['qtdAvaliacoes'] ?? 0,
      suites: (json['suites'] as List<dynamic>)
          .map((suite) => SuiteModel.fromJson(suite))
          .toList(),
      distancia: (json['distancia'] ?? 0).toDouble(),
    );
  }
}
