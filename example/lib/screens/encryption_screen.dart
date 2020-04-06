import 'package:flutter/material.dart';

import "package:pointycastle/export.dart";
import 'package:rsa_encrypt/rsa_encrypt.dart';
import 'package:marquee/marquee.dart';

class EncryptionScreen extends StatefulWidget {
  final RSAPrivateKey rsaPrivateKey;
  final RSAPublicKey rsaPublicKey;

  EncryptionScreen({
    @required this.rsaPrivateKey,
    @required this.rsaPublicKey,
  });

  @override
  _EncryptionScreenState createState() => _EncryptionScreenState();
}

class _EncryptionScreenState extends State<EncryptionScreen> {
  TextEditingController _textController = TextEditingController();
  String _rsaKeyPem = "";
  String _encryptedString = "Encrypted text shows here";

  @override
  void initState() {
    super.initState();
    setState(() {
      _rsaKeyPem =
          RsaKeyHelper().encodePrivateKeyToPemPKCS1(widget.rsaPrivateKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rsa Encrypt"),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              MaterialButton(
                onPressed: () {
                  setState(() {
                    _rsaKeyPem = RsaKeyHelper()
                        .encodePrivateKeyToPemPKCS1(widget.rsaPrivateKey);
                  });
                },
                color: Theme.of(context).accentColor,
                child: Text(
                  "Private Key",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    _rsaKeyPem = RsaKeyHelper()
                        .encodePublicKeyToPemPKCS1(widget.rsaPublicKey);
                  });
                },
                color: Theme.of(context).accentColor,
                child: Text(
                  "Public Key",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
            height: 100.0,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Text(_rsaKeyPem),
            ),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 35.0, vertical: 5.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(hintText: "String to encrypt"),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 55.0, vertical: 1.0),
            child: MaterialButton(
              child: Text(
                "Encrypt",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              onPressed: () {
                setState(() {
                  _encryptedString =
                      encrypt(_textController.text, widget.rsaPublicKey);
                });
              },
              color: Theme.of(context).accentColor,
            ),
          ),
          _encryptedString != "Encrypted text shows here"
              ? Container(
                  margin: EdgeInsets.symmetric(horizontal: 55.0, vertical: 1.0),
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        _encryptedString =
                            decrypt(_encryptedString, widget.rsaPrivateKey);
                      });
                    },
                    child: Text(
                      "Decrypt",
                      style: TextStyle(color: Colors.white, fontSize: 17.0),
                    ),
                    color: Theme.of(context).accentColor,
                  ),
                )
              : Text(""),
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
              height: 150,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(
                  _encryptedString,
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
