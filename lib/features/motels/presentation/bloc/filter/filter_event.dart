import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class FilterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleFilterPanel extends FilterEvent {}

class ToggleDiscountFilter extends FilterEvent {}

class ToggleAvailabilityFilter extends FilterEvent {}

class UpdateSelectedFeatures extends FilterEvent {
  final String feature;

  UpdateSelectedFeatures(this.feature);

  @override
  List<Object?> get props => [feature];
}

class UpdateSelectedPeriods extends FilterEvent {
  final String period;

  UpdateSelectedPeriods(this.period);

  @override
  List<Object?> get props => [period];
}

class UpdatePriceFilter extends FilterEvent {
  final int minPrice;
  final int maxPrice;

  UpdatePriceFilter({required this.minPrice, required this.maxPrice});

  @override
  List<Object?> get props => [minPrice, maxPrice];
}

class ApplyFilters extends FilterEvent {
  final BuildContext? context;

  ApplyFilters({this.context});

  @override
  List<Object?> get props => [context];
}

