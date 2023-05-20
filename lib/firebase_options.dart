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
    apiKey: 'AIzaSyAT6x3qA5vaY65PYj482vAUNu6d5Sgp8Po',
    appId: '1:50719577631:web:f80fa096cc28bfa243a72a',
    messagingSenderId: '50719577631',
    projectId: 'insatgram-clone-7f9f0',
    authDomain: 'insatgram-clone-7f9f0.firebaseapp.com',
    storageBucket: 'insatgram-clone-7f9f0.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAuSrNyFdbw3o4IsJtmayfa-ol2Ty4UCrs',
    appId: '1:50719577631:android:c2c3ad6497417d6443a72a',
    messagingSenderId: '50719577631',
    projectId: 'insatgram-clone-7f9f0',
    storageBucket: 'insatgram-clone-7f9f0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBRSSZPQkql2TuDcjj1_rWeeHeFnPUfSPY',
    appId: '1:50719577631:ios:30d95d0e68cac37b43a72a',
    messagingSenderId: '50719577631',
    projectId: 'insatgram-clone-7f9f0',
    storageBucket: 'insatgram-clone-7f9f0.appspot.com',
    iosClientId: '50719577631-qhi0gebbvt6i4d0i64rd1esn6kdgaoa6.apps.googleusercontent.com',
    iosBundleId: 'com.example.instagram',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBRSSZPQkql2TuDcjj1_rWeeHeFnPUfSPY',
    appId: '1:50719577631:ios:30d95d0e68cac37b43a72a',
    messagingSenderId: '50719577631',
    projectId: 'insatgram-clone-7f9f0',
    storageBucket: 'insatgram-clone-7f9f0.appspot.com',
    iosClientId: '50719577631-qhi0gebbvt6i4d0i64rd1esn6kdgaoa6.apps.googleusercontent.com',
    iosBundleId: 'com.example.instagram',
  );
}
