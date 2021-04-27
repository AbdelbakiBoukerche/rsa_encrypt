import 'package:bloc_encryption/business_logic/encryption_bloc/encryption_bloc.dart';
import 'package:bloc_encryption/business_logic/key_manager_bloc/keysmanager_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';

class EncryptionScreen extends StatefulWidget {
  final AsymmetricKeyPair _asymmetricKeyPair;
  const EncryptionScreen(
      {Key? key, required AsymmetricKeyPair asymmetricKeyPair})
      : _asymmetricKeyPair = asymmetricKeyPair,
        super(key: key);

  @override
  _EncryptionScreenState createState() => _EncryptionScreenState();
}

class _EncryptionScreenState extends State<EncryptionScreen> {
  final EncryptionBloc _encryptionBloc = EncryptionBloc();
  final KeysManagerBloc _keysManagerBloc = KeysManagerBloc();

  final TextEditingController _textController = TextEditingController();
  String encryptedString = "";

  @override
  void dispose() {
    _encryptionBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EncryptionBloc>(
          create: (context) => _encryptionBloc,
        ),
        BlocProvider<KeysManagerBloc>(
          create: (context) => _keysManagerBloc,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Encryption"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    child: Text("Private Key"),
                    onPressed: () {
                      _keysManagerBloc.add(
                        ShowPrivateKey(widget._asymmetricKeyPair),
                      );
                    },
                  ),
                  SizedBox(width: 10),
                  RaisedButton(
                    child: Text("Public Key"),
                    onPressed: () {
                      _keysManagerBloc.add(
                        ShowPublicKey(widget._asymmetricKeyPair),
                      );
                    },
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                margin: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 16.0,
                  bottom: 16.0,
                ),
                padding: EdgeInsets.all(12.0),
                width: double.infinity,
                height: 150,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: BlocBuilder<KeysManagerBloc, KeysManagerState>(
                    builder: (context, state) {
                      if (state is KeysManagerInitial) {
                        return Text(
                          "Show RSA Key Pem Here",
                          textAlign: TextAlign.center,
                        );
                      }
                      if (state is ShowingPrivateKey) {
                        return Text(
                          state.privateKey,
                          textAlign: TextAlign.center,
                        );
                      }
                      if (state is ShowingPublicKey) {
                        return Text(
                          state.publicKey,
                          textAlign: TextAlign.center,
                        );
                      }
                      return Text(
                        "Show RSA Key Pem Here",
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                ),
              ),
              Divider(thickness: 2),
              // Encryption
              Container(
                margin: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 8.0,
                  bottom: 8.0,
                ),
                child: TextField(
                  controller: _textController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(hintText: "String to encrypt"),
                ),
              ),
              RaisedButton(
                child: Text("Encrypt"),
                onPressed: () {
                  _encryptionBloc.add(
                    EncryptString(
                      _textController.text.trim(),
                      widget._asymmetricKeyPair.publicKey as RSAPublicKey,
                    ),
                  );
                },
              ),
              // Decryption
              Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                margin: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 16.0,
                  bottom: 16.0,
                ),
                padding: EdgeInsets.all(12.0),
                width: double.infinity,
                height: 75,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: BlocBuilder<EncryptionBloc, EncryptionState>(
                    buildWhen: (previous, current) => previous != current,
                    builder: (context, state) {
                      if (state is EncryptionCompleted) {
                        encryptedString = state.encryptedString;
                        return Text(
                          state.encryptedString,
                          textAlign: TextAlign.center,
                        );
                      }
                      if (state is DecryptionCompleted) {
                        return Text(
                          state.decryptedString,
                          textAlign: TextAlign.center,
                        );
                      }
                      return Text(
                        "Show Encrypted String Here",
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                ),
              ),
              RaisedButton(
                child: Text("Decrypt"),
                onPressed: () {
                  _encryptionBloc.add(
                    DecryptString(
                      encryptedString,
                      widget._asymmetricKeyPair.privateKey as RSAPrivateKey,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
