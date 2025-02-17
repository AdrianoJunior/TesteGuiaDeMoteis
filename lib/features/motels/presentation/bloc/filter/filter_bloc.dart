import 'package:flutter_bloc/flutter_bloc.dart';
import 'filter_event.dart';
import 'filter_state.dart';
import '../motel_bloc.dart';
import '../motel_event.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {

  FilterBloc() : super(FilterInitial()) {
    on<ToggleFilterPanel>((event, emit) {
      emit(state.copyWith(isPanelOpen: !state.isPanelOpen));
    });

    on<ToggleDiscountFilter>((event, emit) {
      emit(state.copyWith(onlyDiscounts: !state.onlyDiscounts));
    });

    on<ToggleAvailabilityFilter>((event, emit) {
      emit(state.copyWith(onlyAvailable: !state.onlyAvailable));
    });

    on<UpdateSelectedFeatures>((event, emit) {
      final updatedFeatures = List<String>.from(state.selectedFeatures);
      if (updatedFeatures.contains(event.feature)) {
        updatedFeatures.remove(event.feature);
      } else {
        updatedFeatures.add(event.feature);
      }
      emit(state.copyWith(selectedFeatures: updatedFeatures));
    });

    on<UpdateSelectedPeriods>((event, emit) {
      final updatedPeriods = List<String>.from(state.selectedPeriods);
      if (updatedPeriods.contains(event.period)) {
        updatedPeriods.remove(event.period);
      } else {
        updatedPeriods.add(event.period);
      }
      emit(state.copyWith(selectedPeriods: updatedPeriods));
    });

    on<UpdatePriceFilter>((event, emit) {
      emit(state.copyWith(
        minPrice: event.minPrice,
        maxPrice: event.maxPrice,
      ));
    });

    on<ApplyFilters>((event, emit) {
      final motelBloc = event.context != null
          ? BlocProvider.of<MotelBloc>(event.context!)
          : null;

      motelBloc?.add(FetchFilteredMotels());
      emit(state.copyWith(isPanelOpen: false));
    });

  }
}
