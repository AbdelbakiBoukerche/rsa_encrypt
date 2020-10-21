part of 'encryption_bloc.dart';

@immutable
abstract class EncryptionState extends Equatable {}

class EncryptionInitial extends EncryptionState {
  @override
  List<Object> get props => [];
}

class Loading extends EncryptionState {
  @override
  List<Object> get props => [];
}

class EncryptionCompleted extends EncryptionState {
  final String _encryptedString;

  EncryptionCompleted(this._encryptedString);

  String get encryptedString => _encryptedString;

  @override
  List<Object> get props => [_encryptedString];
}

class DecryptionCompleted extends EncryptionState {
  final String _decryptedString;

  DecryptionCompleted(this._decryptedString);

  String get decryptedString => _decryptedString;

  @override
  List<Object> get props => [_decryptedString];
}
