import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pointycastle/api.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';

part 'app_init_event.dart';
part 'app_init_state.dart';

class AppInitBloc extends Bloc<AppInitEvent, AppInitState> {
  AppInitBloc() : super(InitialState());

  @override
  Stream<AppInitState> mapEventToState(
    AppInitEvent event,
  ) async* {
    if (event is AppStarted) {
      yield InitialState();
    }
    if (event is GenerateKeys) {
      yield* _mapGenerateKeysToState();
    }
  }

  Stream<AppInitState> _mapGenerateKeysToState() async* {
    yield KeyGeneration();
    var _rsaKeyHelper = RsaKeyHelper();
    final AsymmetricKeyPair _keyPair =
        await _rsaKeyHelper.computeRSAKeyPair(_rsaKeyHelper.getSecureRandom());
    yield KeysGenerated(_keyPair);
  }
}
