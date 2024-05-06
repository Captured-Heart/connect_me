class CreateFormMap {
  static Map<String, dynamic> createDataMap({
    required List<dynamic> controllersText,
    required List<String> customKeys,
  }) {
    Map<String, dynamic> dataMap = {}; // initiate an empty map

    // Iterate over my List of TextControllers
    for (int i = 0; i < controllersText.length; i++) {
      var text = controllersText[i]; // i am trying to avoid empty spaces

      // Check if any of controller's text is empty
      if (text.isNotEmpty || text != null) {
        /// assign the custom keys to the empty map [dataMap]
        String key = i < customKeys.length ? customKeys[i] : 'Field $i';
        dataMap[key] = text;
      }
    }

    return dataMap;
  }
}
