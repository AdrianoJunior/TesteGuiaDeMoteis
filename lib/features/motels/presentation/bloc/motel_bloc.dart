import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guia_moteis/features/motels/domain/use_cases/get_motels_use_case.dart';
import 'motel_event.dart';
import 'motel_state.dart';

/// Gerencia os estados e eventos relacionados à listagem de motéis.
class MotelBloc extends Bloc<MotelEvent, MotelState> {
  final GetMotelsUseCase getMotelsUseCase;

  /// Inicializa o BLoC com o estado de carregamento e define os eventos suportados.
  MotelBloc({required this.getMotelsUseCase}) : super(MotelLoading()) {
    on<FetchMotels>(_fetchMotels);
  }

  /// Manipula o evento `FetchMotels` para buscar os motéis da API.

  /// - Emite `MotelLoading` antes de fazer a requisição.
  /// - Emite `MotelLoaded` com a lista de motéis caso a requisição seja bem-sucedida.
  /// - Emite `MotelError` caso ocorra algum erro.
  Future<void> _fetchMotels(FetchMotels event, Emitter<MotelState> emit) async {
    emit(MotelLoading());

    try {
      final motels = await getMotelsUseCase.execute();
      emit(MotelLoaded(motels)); // Atualiza o estado com os motéis carregados
    } catch (e) {
      emit(MotelError('Erro ao carregar motéis: ${e.toString()}')); // Dispara um erro
    }
  }
}
