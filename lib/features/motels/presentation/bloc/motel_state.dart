import 'package:equatable/equatable.dart';
import '../../domain/entities/motel_entity.dart';

abstract class MotelState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MotelLoading extends MotelState {}

class MotelLoaded extends MotelState {
  final List<MotelEntity> motels;

  MotelLoaded(this.motels);

  @override
  List<Object?> get props => [motels];
}

class MotelError extends MotelState {
  final String message;

  MotelError(this.message);

  @override
  List<Object?> get props => [message];
}
