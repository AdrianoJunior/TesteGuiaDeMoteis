import 'package:guia_moteis/features/motels/domain/entities/suite_item_category_entity.dart';

class SuiteItemCategoryModel extends SuiteItemCategoryEntity {
  SuiteItemCategoryModel({
    required super.name,
    required super.icon,
  });

  /// Factory method that ensures invalid categories are not created.
  factory SuiteItemCategoryModel.fromJson(Map<String, dynamic> json) {
    final name = json['nome'];
    final icon = json['icone'];

    if (name == null || name.isEmpty || icon == null || icon.isEmpty) {
      throw ArgumentError('Invalid category: missing name or icon');
    }

    return SuiteItemCategoryModel(
      name: name,
      icon: icon,
    );
  }
}
