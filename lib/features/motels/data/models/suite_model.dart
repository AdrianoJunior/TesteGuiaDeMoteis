
import 'package:guia_moteis/features/motels/data/models/pricing_model.dart';
import 'package:guia_moteis/features/motels/domain/entities/suite_entity.dart';


class SuiteModel extends SuiteEntity {
  SuiteModel({
    required super.name,
    required super.photos,
    required super.features,
    required super.pricing,
  });

  factory SuiteModel.fromJson(Map<String, dynamic> json) {
    return SuiteModel(
      name: json['nome'] ?? 'Nome não disponível',
      photos: (json['fotos'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      features: (json['itens'] as List<dynamic>?)?.map((e) => e['nome'].toString()).toList() ?? [],
      pricing: (json['periodos'] as List<dynamic>?)
          ?.map((e) => PricingModel.fromJson(e))
          .toList() ?? [],
    );
  }
}
