final String screenViewKey = "screenView";
final String screenName =  "screenName";

/// Represents the mapping of a custom event to a Firebase event.
class FirebaseEventMapping {
  /// The name of the Firebase event.
  final String name;

  /// The top-level key to be used for this event.
  final String topLevelKey;

  /// Creates a new instance of [FirebaseEventMapping] with the given [name] and [topLevelKey].
  ///
  /// The default values for [name] and [topLevelKey] are empty strings.
  FirebaseEventMapping({this.name = '', this.topLevelKey = ''});

  /// The default [FirebaseEventMapping] for the screen view event.
  static FirebaseEventMapping get defaultScreenView => FirebaseEventMapping(
    name: screenViewKey,
    topLevelKey: screenName,
  );

  /// The default set of mappings for Firebase events.
  static Map<String, FirebaseEventMapping> get defaultMappings => {
    screenViewKey: defaultScreenView,
  };
}