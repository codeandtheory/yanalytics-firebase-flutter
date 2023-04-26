import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yanalytics_firebase/src/firebase_analytics_configuration.dart';
import 'package:yanalytics_firebase/src/firebase_event_mapping.dart';

/// A [MockFirebaseOptions] class that extends [Mock] and implements [FirebaseOptions].
class MockFirebaseOptions extends Mock implements FirebaseOptions {}

void main() {
  /// A group of tests for initializing the [FirebaseAnalyticsConfiguration].
  group('can init default FirebaseAnalyticsConfiguration', () {

    /// Tests the default [FirebaseAnalyticsConfiguration].
    test('default configuration', () {
      final config = FirebaseAnalyticsConfiguration.defaultConfiguration;

      expect(config.name, isNull);
      expect(config.options, isNull);
      expect(config.mappings, isNotEmpty);
    });

    /// Tests the initialization of [FirebaseAnalyticsConfiguration] with custom mappings.
    test('can init configuration with mappings', () {
      final mappings = {
        'test_event': FirebaseEventMapping(/*...*/),
      };
      final config = FirebaseAnalyticsConfiguration(mappings: mappings);

      expect(config.name, isNull);
      expect(config.options, isNull);
      expect(config.mappings, equals(mappings));
    });

    /// Tests the initialization of [FirebaseAnalyticsConfiguration] with custom options.
    test('can init configuration with options', () {
      final options = MockFirebaseOptions();
      final config = FirebaseAnalyticsConfiguration.withOptions(options: options);

      expect(config.name, isNull);
      expect(config.options, equals(options));
      expect(config.mappings, isNotEmpty);
    });

    /// Tests the initialization of [FirebaseAnalyticsConfiguration] with custom name and options.
    test('can init configuration with name and options', () {
      final name = 'custom_name';
      final options = MockFirebaseOptions();
      final config = FirebaseAnalyticsConfiguration.withNameAndOptions(
        name: name,
        options: options,
      );

      expect(config.name, equals(name));
      expect(config.options, equals(options));
      expect(config.mappings, isNotEmpty);
    });
  });
}