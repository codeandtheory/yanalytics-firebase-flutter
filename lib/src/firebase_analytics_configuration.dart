import 'package:firebase_core/firebase_core.dart';

/// A class that represents the configuration of Firebase Analytics.
class FirebaseAnalyticsConfiguration {
  /// The optional name for the Firebase Analytics configuration.
  final String? name;

  /// The optional [FirebaseOptions] to configure the Firebase Analytics instance.
  final FirebaseOptions? options;

  /// The mappings between custom events and Firebase events.
  final Map<String, FirebaseEventMapping> mappings;

  FirebaseAnalyticsConfiguration._({
    this.name,
    this.options,
    required this.mappings,
  });

  /// Creates a [FirebaseAnalyticsConfiguration] with the given [mappings].
  ///
  /// If [mappings] is not provided, it defaults to [FirebaseEventMapping.defaultMappings].
  factory FirebaseAnalyticsConfiguration({
    Map<String, FirebaseEventMapping>? mappings,
  }) {
    return FirebaseAnalyticsConfiguration._(
      mappings: mappings ?? FirebaseEventMapping.defaultMappings,
    );
  }

  /// Creates a [FirebaseAnalyticsConfiguration] with the given [options] and [mappings].
  ///
  /// [options] is required to configure the Firebase Analytics instance.
  /// If [mappings] is not provided, it defaults to [FirebaseEventMapping.defaultMappings].
  factory FirebaseAnalyticsConfiguration.withOptions({
    required FirebaseOptions options,
    Map<String, FirebaseEventMapping>? mappings,
  }) {
    return FirebaseAnalyticsConfiguration._(
      options: options,
      mappings: mappings ?? FirebaseEventMapping.defaultMappings,
    );
  }

  /// Creates a [FirebaseAnalyticsConfiguration] with the given [name], [options], and [mappings].
  ///
  /// [name] is required to identify the Firebase Analytics configuration.
  /// [options] is required to configure the Firebase Analytics instance.
  /// If [mappings] is not provided, it defaults to [FirebaseEventMapping.defaultMappings].
  factory FirebaseAnalyticsConfiguration.withNameAndOptions({
    required String name,
    required FirebaseOptions options,
    Map<String, FirebaseEventMapping>? mappings,
  }) {
    return FirebaseAnalyticsConfiguration._(
      name: name,
      options: options,
      mappings: mappings ?? FirebaseEventMapping.defaultMappings,
    );
  }

  /// Returns the default [FirebaseAnalyticsConfiguration] instance.
  static FirebaseAnalyticsConfiguration get defaultConfiguration =>
      FirebaseAnalyticsConfiguration();
}

/// A class that represents the mapping between custom events and Firebase events.
class FirebaseEventMapping {
  // Define the properties and methods for the FirebaseEventMapping class

  /// Returns the default mappings for Firebase events.
  static Map<String, FirebaseEventMapping> get defaultMappings {
    // Return the default mappings
    return {};
  }
}
