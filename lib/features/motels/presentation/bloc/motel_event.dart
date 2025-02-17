import 'package:equatable/equatable.dart';

abstract class MotelEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchMotels extends MotelEvent {}

class FetchFilteredMotels extends MotelEvent {} // 🔹 New event
