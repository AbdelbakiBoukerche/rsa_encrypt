part of 'keysmanager_bloc.dart';

@immutable
abstract class KeysManagerState {}

class KeysManagerInitial extends KeysManagerState {}

class ShowingPrivateKey extends KeysManagerState {
  final String _privateKey;

  ShowingPrivateKey(this._privateKey);

  String get privateKey => _privateKey;

  @override
  List<Object> get props => [_privateKey];
}

class ShowingPublicKey extends KeysManagerState {
  final String _publicKey;

  ShowingPublicKey(this._publicKey);

  String get publicKey => _publicKey;

  @override
  List<Object> get props => [_publicKey];
}
