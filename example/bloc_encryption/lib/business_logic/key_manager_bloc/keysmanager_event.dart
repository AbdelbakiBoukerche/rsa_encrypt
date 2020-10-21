part of 'keysmanager_bloc.dart';

@immutable
abstract class KeysManagerEvent extends Equatable {}

class ShowPrivateKey extends KeysManagerEvent {
  final AsymmetricKeyPair _asymmetricKeyPair;

  ShowPrivateKey(this._asymmetricKeyPair);

  @override
  List<Object> get props => [_asymmetricKeyPair];
}

class ShowPublicKey extends KeysManagerEvent {
  final AsymmetricKeyPair _asymmetricKeyPair;

  ShowPublicKey(this._asymmetricKeyPair);

  @override
  List<Object> get props => [_asymmetricKeyPair];
}
