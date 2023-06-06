// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBqcFh3aFo5B0d9fTPciNtwg6kZ5kdD2p0',
    appId: '1:1031712601805:web:c068d2ea67db95e61d1b84',
    messagingSenderId: '1031712601805',
    projectId: 'app-messages-ca3e1',
    authDomain: 'app-messages-ca3e1.firebaseapp.com',
    storageBucket: 'app-messages-ca3e1.appspot.com',
    measurementId: 'G-4VCRSMVRBP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAfG6pnbkQKO3saJrOmFkv53Mwx7tpdTUg',
    appId: '1:1031712601805:android:d57aaab73a081c1a1d1b84',
    messagingSenderId: '1031712601805',
    projectId: 'app-messages-ca3e1',
    storageBucket: 'app-messages-ca3e1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBaKpf4X3r40Tz1e9lAtZzUx5oyNE4hw44',
    appId: '1:1031712601805:ios:f3c492dadc1d5cc91d1b84',
    messagingSenderId: '1031712601805',
    projectId: 'app-messages-ca3e1',
    storageBucket: 'app-messages-ca3e1.appspot.com',
    iosBundleId: 'com.example.appMensajeria',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBaKpf4X3r40Tz1e9lAtZzUx5oyNE4hw44',
    appId: '1:1031712601805:ios:f3c492dadc1d5cc91d1b84',
    messagingSenderId: '1031712601805',
    projectId: 'app-messages-ca3e1',
    storageBucket: 'app-messages-ca3e1.appspot.com',
    iosBundleId: 'com.example.appMensajeria',
  );
}