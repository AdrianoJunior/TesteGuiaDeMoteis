import 'package:equatable/equatable.dart';

class FilterState extends Equatable {
  final bool isPanelOpen;
  final bool onlyDiscounts;
  final bool onlyAvailable;
  final List<String> selectedFeatures;
  final List<String> allFeatures;
  final List<String> selectedPeriods;
  final List<String> allPeriods;
  final int minPrice;
  final int maxPrice;

  const FilterState({
    this.isPanelOpen = false,
    this.onlyDiscounts = false,
    this.onlyAvailable = false,
    this.selectedFeatures = const [],
    this.allFeatures = const [
      "hidro", "piscina", "sauna", "ofurô", "decoração erótica", "decoração temática",
      "cadeira erótica", "pista de dança", "garagem privativa", "frigobar",
      "internet wi-fi", "suíte para festas", "suíte com acessibilidade"
    ],
    this.selectedPeriods = const [],
    this.allPeriods = const [
      "1 hora", "2 horas", "3 horas", "4 horas", "5 horas", "6 horas",
      "7 horas", "8 horas", "9 horas", "10 horas", "11 horas", "12 horas",
      "perdia", "pernoite"
    ],
    this.minPrice = 30,
    this.maxPrice = 2030,
  });

  FilterState copyWith({
    bool? isPanelOpen,
    bool? onlyDiscounts,
    bool? onlyAvailable,
    List<String>? selectedFeatures,
    List<String>? selectedPeriods,
    int? minPrice,
    int? maxPrice,
  }) {
    return FilterState(
      isPanelOpen: isPanelOpen ?? this.isPanelOpen,
      onlyDiscounts: onlyDiscounts ?? this.onlyDiscounts,
      onlyAvailable: onlyAvailable ?? this.onlyAvailable,
      selectedFeatures: selectedFeatures ?? this.selectedFeatures,
      allFeatures: this.allFeatures,
      selectedPeriods: selectedPeriods ?? this.selectedPeriods,
      allPeriods: this.allPeriods,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
    );
  }

  @override
  List<Object?> get props => [
    isPanelOpen,
    onlyDiscounts,
    onlyAvailable,
    selectedFeatures,
    allFeatures,
    selectedPeriods,
    allPeriods,
    minPrice,
    maxPrice,
  ];
}

class FilterInitial extends FilterState {}
