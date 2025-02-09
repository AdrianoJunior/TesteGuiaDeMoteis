import 'package:guia_moteis/features/motels/domain/entities/pricing_entity.dart';

class PricingModel extends PricingEntity {
  PricingModel({
    required super.formattedTime,
    required super.totalValue,
    super.discount,
  });

  factory PricingModel.fromJson(Map<String, dynamic> json) {
    return PricingModel(
      formattedTime: json['tempoFormatado'] ?? '',
      totalValue: (json['valorTotal'] ?? 0).toDouble(),
      discount: json['desconto'] != null
          ? (json['desconto']['desconto'] ?? 0).toDouble()
          : null,
    );
  }
}
