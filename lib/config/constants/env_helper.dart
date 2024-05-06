
import '../../app.dart';

enum EnvKeys {
  fcmServerKeys('FCM_SERVER_KEYS'),
  fcmPostUrlV2('FCM_POST_URL_V2'),
  googleCredentials('GOOGLE_APPLICATION_CREDENTIALS'),
  fcmPostUrl('FCM_POST_URL');

  const EnvKeys(this.key);
  final String key;
}

class EnvHelper {
  static String getEnv(EnvKeys envKeys) {
    return dotenv.env[envKeys.key] ?? '';
  }
}
