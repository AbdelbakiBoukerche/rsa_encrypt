import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pointycastle/export.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';

part 'encryption_event.dart';
part 'encryption_state.dart';

class EncryptionBloc extends Bloc<EncryptionEvent, EncryptionState> {
  EncryptionBloc() : super(EncryptionInitial());

  @override
  Stream<EncryptionState> mapEventToState(
    EncryptionEvent event,
  ) async* {
    if (event is EncryptString) {
      yield* _mapEncryptStringToState(event);
    } else if (event is DecryptString) {
      yield* _mapDecryptStringToState(event);
    }
  }

  Stream<EncryptionState> _mapEncryptStringToState(EncryptString event) async* {
    yield Loading();
    final String _encryptedString = encrypt(event.text, event.publicKey);
    yield EncryptionCompleted(_encryptedString);
  }

  Stream<EncryptionState> _mapDecryptStringToState(DecryptString event) async* {
    yield Loading();
    final String _decryptedString =
        decrypt(event.encryptedString, event.privateKey);
    yield DecryptionCompleted(_decryptedString);
  }
}
