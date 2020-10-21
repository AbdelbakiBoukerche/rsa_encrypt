part of 'app_init_bloc.dart';

@immutable
abstract class AppInitEvent extends Equatable {}

class AppStarted extends AppInitEvent {
  List<Object> get props => [];
}

class GenerateKeys extends AppInitEvent {
  @override
  List<Object> get props => [];
}
