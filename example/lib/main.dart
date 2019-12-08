import 'package:flutter/material.dart';
import 'package:rsa_encrypt/rsa_encrypt.dart';
import 'package:pointycastle/api.dart' as crypto;
import 'package:pointycastle/export.dart' as rsaKeys;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isKeyGenerated = false;
  bool isBusy = false;

  Future<String> futureKeyText;

  TextEditingController _textController = TextEditingController();

  String cipherText;
  String deCipherText;

  ///Future to hold our Key pair [PRIVATE & PUBLIC]
  Future<crypto.AsymmetricKeyPair> futureKeyPair;

  ///Store our key pair From [futureKeyPair]
  crypto.AsymmetricKeyPair keyPair;

  /// in order to encrypt and decrypt text we need public and private keys this will store [RSAPrivateKey & RSAPublicKey]
  rsaKeys.RSAPrivateKey privateKey;
  rsaKeys.RSAPublicKey publicKey;

  /// this will store the keys as string after converting them to [PEM]
  String priKey;
  String pubKey;

  /// [IMPORTANT] : you can use convert keys to PEM with [encodePrivateKeyToPemPKCS1 & encodePublicKeyToPemPKCS1]

  /// This will allow us to generate Key Pair wich we then store in [futureKeyPair]
  Future<crypto.AsymmetricKeyPair<crypto.PublicKey, crypto.PrivateKey>>
      getKeyPair() {
    var helper = RsaKeyHelper();
    return helper.computeRSAKeyPair(helper.getSecureRandom());
  }

  Widget buildKeyGenerationScreen() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('RSA Encryption'),
      ),
      body: isBusy
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 40.0, horizontal: 25.0),
                  child: RaisedButton(
                    color: Theme.of(context).accentColor,
                    child: Text(
                      'Generate my keys',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    onPressed: () {
                      print('Keys generating...');
                      futureKeyPair =
                          getKeyPair(); //Generate keys and store them
                      setState(() {
                        isKeyGenerated = true;
                      });
                    },
                  ),
                )
              ],
            ),
    );
  }

  Widget buildEncryptDecryptScreen() {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                isKeyGenerated = false;
              });
            },
          ),
          centerTitle: true,
          title: Text('RSA Encryption'),
        ),
        body: FutureBuilder(
          future: futureKeyPair,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              this.keyPair = snapshot.data;

              ///if snapshot has data [Private & Public keys] store those key in keyPair
              return ListView(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                    child: RaisedButton(
                      color: Colors.red,
                      child: Text(
                        'Show private Key',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                      onPressed: () {
                        print('show private Key');
                        setState(() {
                          futureKeyText = Future.value(
                            RsaKeyHelper()
                                .encodePrivateKeyToPemPKCS1(keyPair.privateKey),

                            ///Convert our private key to PEM format
                          );
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 50.0),
                    child: RaisedButton(
                      color: Colors.blueAccent,
                      child: Text(
                        'Show public Key',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                      onPressed: () {
                        print('show public Key');
                        setState(() {
                          futureKeyText = Future.value(
                            RsaKeyHelper()
                                .encodePublicKeyToPemPKCS1(keyPair.publicKey),

                            ///Convert our public key to PEM format
                          );
                        });
                      },
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      onSubmitted: (value) => _textController.text = value,
                      decoration: InputDecoration(
                        labelText: 'Enter text to encrypt',
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).accentColor),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 50.0),
                    child: RaisedButton(
                      color: Colors.teal,
                      child: Text(
                        'Encrypt text',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                      onPressed: () {
                        print('Encrypt text');
                        setState(() {
                          futureKeyText = Future.value(
                            encrypt(_textController.text, keyPair.publicKey),

                            ///[Encryption]
                          );
                        });
                        setState(() async {
                          //TODO This line will give you this warning "setState() callback argument returned a Future."
                          cipherText = await futureKeyText;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 50.0),
                    child: RaisedButton(
                      color: Colors.grey,
                      child: Text(
                        'Decrypt text',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                      onPressed: () {
                        print('Decrypt text');
                        setState(() {
                          futureKeyText = Future.value(
                            decrypt(cipherText, keyPair.privateKey),

                            ///[Decryption]
                          );
                        });
                      },
                    ),
                  ),
                  Divider(),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 2.0),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: FutureBuilder(
                        future: futureKeyText,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasData) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data,
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isKeyGenerated
          ? buildEncryptDecryptScreen()
          : buildKeyGenerationScreen(),
    );
  }
}
