// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBHu2kQv9mOb3iSN_-QTuQHZtPMTZjtEZU',
    appId: '1:90348684818:web:18612d9cdf8f2748003acb',
    messagingSenderId: '90348684818',
    projectId: 'gpt-clone-7ca8e',
    authDomain: 'gpt-clone-7ca8e.firebaseapp.com',
    storageBucket: 'gpt-clone-7ca8e.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyADjxP0V9Jgi4N_YHsvpt-5d0GZMC4qFfE',
    appId: '1:90348684818:android:164bdc843f48fd96003acb',
    messagingSenderId: '90348684818',
    projectId: 'gpt-clone-7ca8e',
    storageBucket: 'gpt-clone-7ca8e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDhDUWexsqbw9gQrm5AKrPRKAtHmlVzgkk',
    appId: '1:90348684818:ios:1ad62d651002d768003acb',
    messagingSenderId: '90348684818',
    projectId: 'gpt-clone-7ca8e',
    storageBucket: 'gpt-clone-7ca8e.appspot.com',
    iosBundleId: 'com.example.chatgptClone',
  );
}
