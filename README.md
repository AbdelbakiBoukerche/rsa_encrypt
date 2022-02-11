## This package is no longer maintained by its author! 
  

# rsa_encrypt 1.0.5

  

  

RSA encryption package.

  

  

## Getting Started

  

RSA keys **generator**, String **encryption** and **decryption** and String **signing**.

  

## How it works

  

let say **Alice** want to send a message to **Bob**. a normal messaging solution would be : Alice write the message and send it to Bob the only problem is that the Message will be **transferred** in **PlainText** and every one who **intercept** the message can **read it.**

  

*This is were RSA comes to play*:

  

1. We generate keys( public & private ) for Bob.

2. If Alice wanted to send a message to Bob she have to encrypt that message with Bob's public keys.

3. Then the encrypted message will be transferred to Bob and only Bob's private key can decrypt that message.

  

that way no none can decrypt the message except the owner of that specific private key.

  

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

**A youtube video will be available soon!**

  

## More on RSA

[The RSA Encryption Algorithm (1 of 2: Computing an Example)](https://www.youtube.com/watch?v=4zahvcJ9glg)

[The RSA Encryption Algorithm (2 of 2: Generating the Keys)](https://www.youtube.com/watch?v=oOcTVTpUsPQ)

[How to solve RSA Algorithm Problems?](https://www.geeksforgeeks.org/how-to-solve-rsa-algorithm-problems/)

  

-----------------

depends on [pointycastle](https://pub.dev/packages/pointycastle), [asn1lib](https://pub.dev/packages/asn1lib).

thanks to [Gonçalo Palma](https://medium.com/flutter-community/asymmetric-key-generation-in-flutter-ad2b912f3309) for his Article.

  

------------------

For help getting started with Flutter, view our

  

[online documentation](https://flutter.dev/docs), which offers tutorials,

  

samples, guidance on mobile development, and a full API reference.
