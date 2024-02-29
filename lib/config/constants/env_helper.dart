import 'package:connect_me/app.dart';

enum EnvKeys {
  fcmServerKeys('FCM_SERVER_KEYS'),
  fcmPostUrl('FCM_POST_URL');

  const EnvKeys(this.key);
  final String key;
}

class EnvHelper {
  static String getEnv(EnvKeys envKeys) {
    return dotenv.env[envKeys.key] ?? '';
  }
}
