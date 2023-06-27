import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_rtdb_concept/firebase_options.dart';
import 'package:flutter/material.dart';

class MainUtils {
  MainUtils._();

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
