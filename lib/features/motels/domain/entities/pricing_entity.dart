class PricingEntity {
  final String formattedTime;
  final double totalValue;
  final double? discount;

  PricingEntity({
    required this.formattedTime,
    required this.totalValue,
    this.discount,
  });
}
