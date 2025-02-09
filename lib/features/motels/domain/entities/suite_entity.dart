import 'pricing_entity.dart';

class SuiteEntity {
  final String name;
  final List<String> photos;
  final List<String> features;
  final List<PricingEntity> pricing;

  SuiteEntity({
    required this.name,
    required this.photos,
    required this.features,
    required this.pricing,
  });
}
