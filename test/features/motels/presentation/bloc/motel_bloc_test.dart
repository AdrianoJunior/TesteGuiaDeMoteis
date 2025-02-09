import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guia_moteis/core/network/http_api_client.dart';
import 'package:guia_moteis/features/motels/data/repositories/motel_repository.dart';
import 'package:guia_moteis/features/motels/domain/use_cases/get_motels_use_case.dart';
import 'package:guia_moteis/features/motels/presentation/bloc/motel_bloc.dart';
import 'package:guia_moteis/features/motels/presentation/bloc/motel_event.dart';
import 'package:guia_moteis/features/motels/presentation/bloc/motel_state.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'motel_bloc_test.mocks.dart';

// Gera a classe Mock para o HttpApiClient
@GenerateMocks([HttpApiClient])
void main() {
  late MotelBloc realBloc;
  late MotelBloc failureBloc;
  late MockHttpApiClient mockApiClient;
  late MotelRepository realRepository;
  late MotelRepository mockRepository;
  late GetMotelsUseCase realUseCase;
  late GetMotelsUseCase mockUseCase;

  setUp(() {
    // Configuração para o teste usando a API
    final realApiClient = HttpApiClient(client: http.Client());
    realRepository = MotelRepository(apiClient: realApiClient);
    realUseCase = GetMotelsUseCase(realRepository);
    realBloc = MotelBloc(getMotelsUseCase: realUseCase);

    // Configuração para o teste de falha simulada com um Mock
    mockApiClient = MockHttpApiClient(); // Cliente HTTP falso
    mockRepository = MotelRepository(apiClient: mockApiClient);
    mockUseCase = GetMotelsUseCase(mockRepository);
    failureBloc = MotelBloc(getMotelsUseCase: mockUseCase);
  });

  tearDown(() {
    realBloc
        .close(); // Fecha o BLoC para evitar o consumo desnecessário de memória
    failureBloc.close();
  });

  group('Testes de Integração do MotelBloc', () {
    blocTest<MotelBloc, MotelState>(
      'Emite [MotelLoading, MotelLoaded] quando FetchMotels é chamado com dados da API',
      build: () => realBloc,
      act: (bloc) => bloc.add(FetchMotels()),
      wait: const Duration(seconds: 3),
      // Aguarda alguns segundos para a API responder
      expect: () => [
        MotelLoading(),
        // Primeiro estado esperado: carregando
        isA<MotelLoaded>(),
        // Segundo estado esperado: dados carregados com sucesso
      ],
      verify: (bloc) {
        final state = bloc.state;
        if (state is MotelLoaded) {
          print('Sucesso: ${state.motels.length} motéis carregados da API.');
        }
      },
    );

    blocTest<MotelBloc, MotelState>(
      'Emite [MotelLoading, MotelError] quando a API falha',
      build: () {
        when(mockApiClient.get(any)).thenThrow(
            Exception("Falha ao carregar os dados")); // Simula falha na API

        return failureBloc;
      },
      act: (bloc) => bloc.add(FetchMotels()),
      expect: () => [
        MotelLoading(),
        isA<MotelError>(), // Estado esperado ao ocorrer um erro
      ],
      verify: (bloc) {
        final state = bloc.state;
        if (state is MotelError) {
          print('Erro ao carregar motéis: ${state.message}');
        }
      },
    );
  });
}
