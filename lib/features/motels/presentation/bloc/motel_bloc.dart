import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guia_moteis/features/motels/data/repositories/motel_repository.dart';
import 'package:guia_moteis/features/motels/domain/use_cases/get_motels_use_case.dart';

import 'motel_event.dart';
import 'motel_state.dart';

class MotelBloc extends Bloc<MotelEvent, MotelState> {
  final GetMotelsUseCase getMotelsUseCase;

  MotelBloc(this.getMotelsUseCase) : super(MotelLoading()) {
    on<FetchMotels>(_fetchMotels);
  }

  Future<void> _fetchMotels(FetchMotels event, Emitter<MotelState> emit) async {
    try {
      final motels = await getMotelsUseCase.execute();
      emit(MotelLoaded(motels));
    } catch (e) {
      print("Erro ao carregar os motéis: $e");
      emit(MotelError('Erro ao carregar motéis'));
    }
  }
}

