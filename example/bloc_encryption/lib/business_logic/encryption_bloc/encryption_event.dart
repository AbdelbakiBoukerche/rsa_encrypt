part of 'encryption_bloc.dart';

@immutable
abstract class EncryptionEvent extends Equatable {}

class EncryptString extends EncryptionEvent {
  final RSAPublicKey publicKey;
  final String text;

  EncryptString(this.text, this.publicKey);

  @override
  List<Object> get props => [text, publicKey];
}

class DecryptString extends EncryptionEvent {
  final RSAPrivateKey privateKey;
  final String encryptedString;

  DecryptString(this.encryptedString, this.privateKey);

  @override
  List<Object> get props => [encryptedString, privateKey];
}
