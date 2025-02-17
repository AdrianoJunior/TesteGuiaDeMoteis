import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guia_moteis/features/motels/domain/entities/motel_entity.dart';
import 'package:guia_moteis/features/motels/domain/use_cases/get_motels_use_case.dart';
import 'package:guia_moteis/features/motels/presentation/bloc/filter/filter_bloc.dart';
import 'motel_event.dart';
import 'motel_state.dart';

class MotelBloc extends Bloc<MotelEvent, MotelState> {
  final GetMotelsUseCase getMotelsUseCase;
  final FilterBloc filterBloc;

  MotelBloc({required this.getMotelsUseCase, required this.filterBloc}) : super(MotelInitial()) {
    on<FetchMotels>(_fetchMotels);
    on<FetchFilteredMotels>(_fetchFilteredMotels);
  }

  /// Fetches all motels without filters
  Future<void> _fetchMotels(FetchMotels event, Emitter<MotelState> emit) async {
    emit(MotelLoading());

    try {
      final motels = await getMotelsUseCase.execute();
      emit(MotelLoaded(motels));
    } catch (e) {
      emit(MotelError('Erro ao carregar motéis: ${e.toString()}'));
    }
  }

  /// Fetches motels and applies filters from `FilterBloc`
  Future<void> _fetchFilteredMotels(FetchFilteredMotels event, Emitter<MotelState> emit) async {
    emit(MotelLoading());

    try {
      final motels = await getMotelsUseCase.execute();
      final filteredMotels = _applyFilters(motels);
      emit(MotelLoaded(filteredMotels));
    } catch (e) {
      emit(MotelError('Erro ao carregar motéis: ${e.toString()}'));
    }
  }

  /// Applies filters from `FilterBloc` to the list of motels
  List<MotelEntity> _applyFilters(List<MotelEntity> motels) {
    final filterState = filterBloc.state;

    return motels
        .map((motel) {
      final filteredSuites = motel.suites.where((suite) {
        // 🔹 Filter by discount
        if (filterState.onlyDiscounts &&
            !suite.pricing.any((price) => price.discount != null && price.discount! > 0)) {
          return false;
        }

        // 🔹 Filter by features and categories
        if (filterState.selectedFeatures.isNotEmpty &&
            !filterState.selectedFeatures.every((feature) =>
            suite.features.contains(feature.toLowerCase()) ||
                suite.itemCategories.any((item) => item.name.toLowerCase() == feature))) {
          return false;
        }

        // 🔹 Filter by pricing (✅ FIXED)
        if (!suite.pricing.any((price) =>
        price.totalValue >= filterState.minPrice && price.totalValue <= filterState.maxPrice)) {
          return false;
        }

        return true;
      }).toList();

      if (filteredSuites.isEmpty) return null;

      return MotelEntity(
        name: motel.name,
        logo: motel.logo,
        neighborhood: motel.neighborhood,
        rating: motel.rating,
        reviewCount: motel.reviewCount,
        distancia: motel.distancia,
        suites: filteredSuites,
      );
    })
        .where((motel) => motel != null)
        .cast<MotelEntity>()
        .toList();
  }
}
