import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyA9i0Ih_4bsniYvwmLSUslna-VsVa2pARo",
            authDomain: "glucobpm.firebaseapp.com",
            projectId: "glucobpm",
            storageBucket: "glucobpm.firebasestorage.app",
            messagingSenderId: "625917332119",
            appId: "1:625917332119:web:dd249bda95fea20d7a77d2",
            measurementId: "G-GSLYL1V090"));
  } else {
    await Firebase.initializeApp();
  }
}
