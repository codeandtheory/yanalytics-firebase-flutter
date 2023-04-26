final String screenViewKey = "screenView";
final String screenName =  "screenName";

/// A class that represents the mapping between custom events and Firebase events.
class FirebaseEventMapping 
{
  // Define the properties and methods for the FirebaseEventMapping class
  final String name;
  final String topLevelKey;

  FirebaseEventMapping({this.name = '', this.topLevelKey = ''});

  static FirebaseEventMapping get defaultScreenView => FirebaseEventMapping(name: screenViewKey, topLevelKey: screenName);

  /// Returns the default mappings for Firebase events.
  static Map<String, FirebaseEventMapping> get defaultMappings 
  {
    // Return the default mappings
    return {screenViewKey: FirebaseEventMapping.defaultScreenView};
  }
}