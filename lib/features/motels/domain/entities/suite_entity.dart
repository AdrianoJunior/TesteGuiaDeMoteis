import 'pricing_entity.dart';
import 'suite_item_category_entity.dart'; // ✅ Import new entity

class SuiteEntity {
  final String name;
  final List<String> photos;
  final List<String> features;
  final List<PricingEntity> pricing;
  final List<SuiteItemCategoryEntity> itemCategories; // ✅ Updated type

  SuiteEntity({
    required this.name,
    required this.photos,
    required this.features,
    required this.pricing,
    required this.itemCategories,
  });
}
