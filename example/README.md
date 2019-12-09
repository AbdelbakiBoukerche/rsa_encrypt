# rsa_example

RSA encryption package example.

## How to use

in order to use RSA encryption you need to generate *2 key*s a **public key** (used to **encrypt** a text) and a **private key** (used to **decrypt** a text).

  Those are the **functions** and **header** *needed*: 
  

    import 'package:rsa_encrypt/rsa_encrypt.dart';
    import 'package:pointycastle/api.dart' as crypto;
    
    //Future to hold our KeyPair
	Future<crypto.AsymmetricKeyPair> futureKeyPair;
	
	//to store the KeyPair once we get data from our future
	crypto.AsymmetricKeyPair keyPair;
	
    Future<crypto.AsymmetricKeyPair<crypto.PublicKey, crypto.PrivateKey>> getKeyPair()
    {
    var helper = RsaKeyHelper();
    return helper.computeRSAKeyPair(helper.getSecureRandom());
    }

  

 1. Generate **KeyPair** with the function **getKeyPair()** store the returned value in **futureKeyPair**.
 2. Once we get data from the future we can store that data in **keyPair** (Now we have acces to our private and public key).
 3. In order to view our keys as "a string" we need to use two functions **encodePrivateKeyToPemPKCS1(*keyPair.privateKey*)** & **encodePublicKeyToPemPKCS1(*keyPair.publicKey*)**.
 4. In order to **encrypt** and **decrypt** strings you can use two functions
 * **encrypt()** : use this function to encrypt a string, pass your **string** as first argument and a **public key** as the second one. **[IMPORTANT]**: this will **return a string** so you should **store the returned** value in a variable.
 * **decrypt()** : use this function to decrypt an **encrypted String**, pass your **encrypted String** as first argument and a **private key** as the second. this will also **return a string** dont forget to store it :) .

**A youtube video will be available soon**

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
