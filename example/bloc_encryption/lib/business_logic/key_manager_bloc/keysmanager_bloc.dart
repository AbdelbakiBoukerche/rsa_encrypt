import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pointycastle/export.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';

part 'keysmanager_event.dart';
part 'keysmanager_state.dart';

class KeysManagerBloc extends Bloc<KeysManagerEvent, KeysManagerState> {
  KeysManagerBloc() : super(KeysManagerInitial());

  final RsaKeyHelper _rsaKeyHelper = RsaKeyHelper();

  @override
  Stream<KeysManagerState> mapEventToState(
    KeysManagerEvent event,
  ) async* {
    if (event is ShowPrivateKey) {
      yield* _mapShowPrivateKeyToState(event);
    } else if (event is ShowPublicKey) {
      yield* _mapShowPublicKeyToState(event);
    }
  }

  Stream<KeysManagerState> _mapShowPrivateKeyToState(
      ShowPrivateKey event) async* {
    final String _privateKeyStr = _rsaKeyHelper.encodePrivateKeyToPemPKCS1(
        event._asymmetricKeyPair.privateKey as RSAPrivateKey);
    yield ShowingPrivateKey(_privateKeyStr);
  }

  Stream<KeysManagerState> _mapShowPublicKeyToState(
      ShowPublicKey event) async* {
    final String _publicKeyStr = _rsaKeyHelper.encodePublicKeyToPemPKCS1(
        event._asymmetricKeyPair.publicKey as RSAPublicKey);
    yield ShowingPublicKey(_publicKeyStr);
  }
}
