import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guia_moteis/features/motels/presentation/bloc/filter/filter_bloc.dart';
import 'package:guia_moteis/features/motels/presentation/bloc/filter/filter_event.dart';
import 'package:guia_moteis/features/motels/presentation/bloc/filter/filter_state.dart';

void main() {
  late FilterBloc filterBloc;

  setUp(() {
    filterBloc = FilterBloc();
  });

  tearDown(() {
    filterBloc.close();
  });

  group('FilterBloc Tests', () {
    test('Initial state is FilterInitial', () {
      expect(filterBloc.state, FilterInitial());
    });

    blocTest<FilterBloc, FilterState>(
      'Toggles filter panel visibility',
      build: () => filterBloc,
      act: (bloc) => bloc.add(ToggleFilterPanel()),
      expect: () => [FilterState(isPanelOpen: true)],
    );

    blocTest<FilterBloc, FilterState>(
      'Toggles discount filter',
      build: () => filterBloc,
      act: (bloc) => bloc.add(ToggleDiscountFilter()),
      expect: () => [FilterState(onlyDiscounts: true)],
    );

    blocTest<FilterBloc, FilterState>(
      'Updates selected features',
      build: () => filterBloc,
      act: (bloc) => bloc.add(UpdateSelectedFeatures("hidro")),
      expect: () => [FilterState(selectedFeatures: ["hidro"])],
    );

    blocTest<FilterBloc, FilterState>(
      'Updates selected periods',
      build: () => filterBloc,
      act: (bloc) => bloc.add(UpdateSelectedPeriods("pernoite")),
      expect: () => [FilterState(selectedPeriods: ["pernoite"])],
    );

    blocTest<FilterBloc, FilterState>(
      'Updates price filter',
      build: () => filterBloc,
      act: (bloc) => bloc.add(UpdatePriceFilter(minPrice: 100, maxPrice: 800)),
      expect: () => [FilterState(minPrice: 100, maxPrice: 800)],
    );
  });
}
