// import 'package:connect_me/app.dart';

class CreateFormMap {
  static Map<String, String> createDataMap({
    required List<String> controllersText,
    required List<String> customKeys,
  }) {
    Map<String, String> dataMap = {}; // initiate an empty map

    // Iterate over my List of TextControllers
    for (int i = 0; i < controllersText.length; i++) {
      String text =
          controllersText[i].trim(); // i am trying to avoid empty spaces

      // Check if any of controller's text is empty
      if (text.isNotEmpty) {
        /// assign the custom keys to the empty map [dataMap]
        String key = i < customKeys.length ? customKeys[i] : 'Field $i';
        dataMap[key] = text;
      }
    }

    return dataMap;
  }
}
