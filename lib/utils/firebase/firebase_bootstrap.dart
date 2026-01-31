import 'package:firebase_core/firebase_core.dart';

import '../../firebase_options.dart';
import '../logger.dart';

class FirebaseBootstrap {
  static Future<bool> ensureInitialized() async {
    if (Firebase.apps.isNotEmpty) {
      return true;
    }

    if (!DefaultFirebaseOptions.isConfigured) {
      debugLog(
        DebugTags.firebase,
        'Firebase options not configured. Skipping init.',
      );
      return false;
    }

    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      debugLog(DebugTags.firebase, 'Firebase initialized');
      return true;
    } catch (e) {
      errorLog(DebugTags.firebase, 'Firebase init failed: $e');
      return false;
    }
  }
}
