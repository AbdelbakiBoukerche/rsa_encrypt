import 'package:bloc_encryption/business_logic/app_init_bloc/app_init_bloc.dart';
import 'package:bloc_encryption/presentation/screen/encryption_screen.dart';
import 'package:bloc_encryption/presentation/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/screen/home_screen.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppInitBloc _appInitBloc = AppInitBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _appInitBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppInitBloc>(
      create: (BuildContext context) => _appInitBloc,
      child: MaterialApp(
        title: 'RSAEncrypt Demot',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BlocBuilder<AppInitBloc, AppInitState>(
          builder: (context, state) {
            if (state is InitialState) {
              return HomeScreen();
            }
            if (state is KeyGeneration) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (state is KeysGenerated) {
              return EncryptionScreen(asymmetricKeyPair: state.keyPair);
            }
            return HomeScreen();
          },
        ),
      ),
    );
  }
}
