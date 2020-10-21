part of 'app_init_bloc.dart';

@immutable
abstract class AppInitState extends Equatable {}

class InitialState extends AppInitState {
  @override
  List<Object> get props => [];
}

class KeyGeneration extends AppInitState {
  @override
  List<Object> get props => [];
}

class KeysGenerated extends AppInitState {
  final AsymmetricKeyPair _asymmetricKeyPair;

  AsymmetricKeyPair get keyPair => _asymmetricKeyPair;

  KeysGenerated(this._asymmetricKeyPair);

  @override
  List<Object> get props => [_asymmetricKeyPair];
}
