import 'package:flutter/material.dart';

import 'package:rsa_encrypt/rsa_encrypt.dart';
import 'package:pointycastle/api.dart' as crypto;
import 'package:rsa_example/screens/encryption_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isBusy = false;
  bool isKeyGenerated = false;

  crypto.AsymmetricKeyPair keyPair;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rsa Encrypt"),
        centerTitle: true,
      ),
      body: !isBusy
          ? Center(
              child: MaterialButton(
                height: 50.0,
                color: Theme.of(context).accentColor,
                onPressed: () async {
                  setState(() {
                    isBusy = true;
                  });
                  keyPair = await getKeyPair();
                  setState(() {
                    isBusy = false;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EncryptionScreen(
                        rsaPrivateKey: keyPair.privateKey,
                        rsaPublicKey: keyPair.publicKey,
                      ),
                    ),
                  );
                },
                child: Text(
                  "Generate RSA keys",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Future<crypto.AsymmetricKeyPair<crypto.PublicKey, crypto.PrivateKey>>
      getKeyPair() {
    var helper = RsaKeyHelper();
    return helper.computeRSAKeyPair(helper.getSecureRandom());
  }
}
