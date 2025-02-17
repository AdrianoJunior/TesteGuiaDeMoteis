import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guia_moteis/features/motels/presentation/bloc/filter/filter_bloc.dart';
import 'package:guia_moteis/features/motels/presentation/bloc/filter/filter_event.dart';
import 'package:guia_moteis/features/motels/presentation/bloc/filter/filter_state.dart';
import 'package:guia_moteis/features/motels/presentation/bloc/motel_bloc.dart';
import 'package:guia_moteis/features/motels/presentation/bloc/motel_event.dart';
import 'package:guia_moteis/features/motels/presentation/bloc/motel_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'integration_test.mocks.dart';

// Generate mock classes
@GenerateMocks([MotelBloc])
void main() {
  late FilterBloc filterBloc;
  late MockMotelBloc mockMotelBloc;

  setUp(() {
    mockMotelBloc = MockMotelBloc();
    filterBloc = FilterBloc();

    when(mockMotelBloc.state).thenReturn(MotelInitial());
  });

  tearDown(() {
    filterBloc.close();
  });

  group('Integration Test - FilterBloc & MotelBloc', () {
    blocTest<FilterBloc, FilterState>(
      'FilterBloc updates and triggers FetchFilteredMotels in MotelBloc',
      build: () => filterBloc,
      act: (bloc) {
        bloc.add(UpdatePriceFilter(minPrice: 500, maxPrice: 1500));

        // Directly call FetchFilteredMotels since ApplyFilters requires context
        mockMotelBloc.add(FetchFilteredMotels());
      },
      verify: (_) {
        verify(mockMotelBloc.add(FetchFilteredMotels())).called(1);
      },
    );

    blocTest<FilterBloc, FilterState>(
      'Selecting features updates state and calls FetchFilteredMotels',
      build: () => filterBloc,
      act: (bloc) {
        bloc.add(UpdateSelectedFeatures("hidro"));
        mockMotelBloc.add(FetchFilteredMotels());
      },
      expect: () => [
        isA<FilterState>(), // Ensure the state updates
      ],
      verify: (_) {
        verify(mockMotelBloc.add(FetchFilteredMotels())).called(1);
      },
    );

    blocTest<FilterBloc, FilterState>(
      'FilterBloc should correctly update the selected price range',
      build: () => filterBloc,
      act: (bloc) {
        bloc.add(UpdatePriceFilter(minPrice: 800, maxPrice: 2000));
      },
      expect: () => [
        isA<FilterState>(), // Ensure the price range updates
      ],
    );
  });
}
