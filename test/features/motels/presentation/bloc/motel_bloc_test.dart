import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:guia_moteis/core/network/http_api_client.dart';
import 'package:guia_moteis/features/motels/domain/use_cases/get_motels_use_case.dart';
import 'package:guia_moteis/features/motels/data/repositories/motel_repository.dart';
import 'package:guia_moteis/features/motels/presentation/bloc/motel_bloc.dart';
import 'package:guia_moteis/features/motels/presentation/bloc/motel_event.dart';
import 'package:guia_moteis/features/motels/presentation/bloc/motel_state.dart';
import 'package:http/http.dart' as http;

void main() {
  late MotelBloc bloc;
  final String url = "https://www.jsonkeeper.com/b/1IXK";

  setUp(() {
    final apiClient = HttpApiClient(client: http.Client());
    final repository = MotelRepository(apiClient: apiClient);
    final useCase = GetMotelsUseCase(repository);
    bloc = MotelBloc(useCase);
  });

  blocTest<MotelBloc, MotelState>(
    'emits [MotelLoading, MotelLoaded] when FetchMotels is called with real API data',
    build: () => bloc,
    act: (bloc) => bloc.add(FetchMotels()),
    wait: const Duration(seconds: 3), // Allow API call time
    expect: () => [
      MotelLoading(),
      isA<MotelLoaded>(), // Verify that the state contains a loaded list
    ],
  );

  blocTest<MotelBloc, MotelState>(
    'emits [MotelLoading, MotelError] when API fails',
    build: () {
      final failingApiClient = HttpApiClient(client: http.Client());
      final failingRepository = MotelRepository(apiClient: failingApiClient);
      final failingUseCase = GetMotelsUseCase(failingRepository);
      return MotelBloc(failingUseCase);
    },
    act: (bloc) => bloc.add(FetchMotels()),
    expect: () => [
      MotelLoading(),
      isA<MotelError>(), // Expect an error state when API fails
    ],
  );
}
